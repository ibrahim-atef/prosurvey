import 'package:dartz/dartz.dart';
import 'dart:developer' as developer;
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/error/failures.dart';
import '../../core/mock_data.dart';
import '../../core/config/app_config.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  }) async {
    try {
      developer.log('🔐 Login Attempt: $email', name: 'AuthRepository');

      developer.log('🌐 Using Real API for Login', name: 'AuthRepository');
      
      // Debug current token status
      final currentToken = _localStorage.getToken();
      developer.log('🔍 Current stored token: ${currentToken != null ? "Found (${currentToken.length} chars)" : "None"}', name: 'AuthRepository');

      final response = await _apiClient.post('/login', data: {
        'email': email,
        'password': password,
      });

      developer.log('📊 Login Response Status: ${response.statusCode}', name: 'AuthRepository');
      developer.log('📄 Login Response Data: ${response.data}', name: 'AuthRepository');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = UserModel.fromJson(data['user']);
        final token = data['token'];

        await _localStorage.saveUser(user);
        await _localStorage.saveToken(token);
        _apiClient.setToken(token); // Ensure ApiClient also has the token
        await _localStorage.setLoggedIn(true);

        // Verify token was saved
        final savedToken = _localStorage.getToken();
        developer.log('🔍 Token verification - Saved: ${savedToken != null ? "Yes (${savedToken.length} chars)" : "No"}', name: 'AuthRepository');
        developer.log('🔍 ApiClient token status: ${_apiClient.isAuthenticated ? "Authenticated" : "Not authenticated"}', name: 'AuthRepository');

        developer.log('✅ Real Login Success: ${user.name}', name: 'AuthRepository');
        return Right(user);
      } else {
        developer.log('❌ Login Failed: Invalid response', name: 'AuthRepository');
        return const Left(AuthFailure('Login failed'));
      }
    } catch (e) {
      developer.log('💥 Login Error: $e', name: 'AuthRepository');
      return Left(AuthFailure(e.toString()));
    }
  }


  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String instituteId,
    required String academicProgramId,
    String? whatsappNumber,
    String? profileImage,
  }) async {
    try {
      developer.log('📝 Register Attempt: $email', name: 'AuthRepository');
      developer.log('👤 Full Name: $fullName', name: 'AuthRepository');
      developer.log('🏫 Institute ID: $instituteId', name: 'AuthRepository');
      developer.log('📚 Academic Program ID: $academicProgramId', name: 'AuthRepository');
      
      final response = await _apiClient.post('/register', data: {
        'full_name': fullName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'institute_id': int.parse(instituteId),
        'academic_program_id': int.parse(academicProgramId),
        if (whatsappNumber != null) 'whatsapp_number': whatsappNumber,
      });

      developer.log('📊 Register Response Status: ${response.statusCode}', name: 'AuthRepository');
      developer.log('📄 Register Response Data: ${response.data}', name: 'AuthRepository');

      if (response.statusCode == 201 && response.data['success'] == true) {
        final data = response.data['data'];
        final user = UserModel.fromJson(data);
        final token = data['token'] ?? '';

        // Save user and token locally
        await _localStorage.saveUser(user);
        await _localStorage.saveToken(token);
        _apiClient.setToken(token); // Ensure ApiClient also has the token
        await _localStorage.setLoggedIn(true);

        developer.log('✅ Register Success: ${user.name}', name: 'AuthRepository');
        return Right(user);
      } else {
        developer.log('❌ Register Failed: Invalid response', name: 'AuthRepository');
        return const Left(AuthFailure('Registration failed'));
      }
    } catch (e) {
      developer.log('💥 Register Error: $e', name: 'AuthRepository');
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _apiClient.post('/logout');
      await _localStorage.clearAll();
      return const Right(null);
    } catch (e) {
      // Even if API call fails, clear local data
      await _localStorage.clearAll();
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = _localStorage.getUser();
      return Right(user);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUser(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      await _localStorage.saveUser(userModel);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearUser() async {
    try {
      await _localStorage.clearUser();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
