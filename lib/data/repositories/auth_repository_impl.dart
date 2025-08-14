import 'package:dartz/dartz.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/error/failures.dart';
import '../../core/mock_data.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final user = UserModel.fromJson(MockData.loginResponse['user']);
      final token = MockData.loginResponse['token'];

      // Save user and token locally
      await _localStorage.saveUser(user);
      await _localStorage.saveToken(token);
      await _localStorage.setLoggedIn(true);

      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String password,
    required String whatsappNumber,
    required String institute,
    required String year,
    String? profileImage,
  }) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final user = UserModel.fromJson(MockData.registerResponse['user']);
      final token = MockData.registerResponse['token'];

      // Save user and token locally
      await _localStorage.saveUser(user);
      await _localStorage.saveToken(token);
      await _localStorage.setLoggedIn(true);

      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _apiClient.post('/auth/logout');
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
