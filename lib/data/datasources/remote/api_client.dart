import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import '../../../core/config/app_config.dart';
import '../../../core/error/exceptions.dart';


class ApiClient {
  final Dio _dio;
  final SharedPreferences _prefs;

  static const String baseUrl = AppConfig.apiBaseUrl;
  static const String studentBaseUrl = AppConfig.studentBaseUrl;
  static const String tokenKey = 'auth_token';

  ApiClient(this._dio, this._prefs) {
    _setupDio();
  }

  void _setupDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout =
        Duration(seconds: AppConfig.connectionTimeout);
    _dio.options.receiveTimeout = Duration(seconds: AppConfig.receiveTimeout);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = _prefs.getString(tokenKey);
        developer.log('🔍 Interceptor - Request URL: ${options.uri}', name: 'ApiClient');
        developer.log('🔍 Interceptor - Token found: ${token != null}', name: 'ApiClient');
        if (token != null) {
          options.headers['Authorization'] = '$token';
          developer.log('🔑 Interceptor - Added Authorization header', name: 'ApiClient');
        } else {
          developer.log('⚠️ Interceptor - No token found, request will be unauthorized', name: 'ApiClient');
        }
        developer.log('📋 Interceptor - Final headers: ${options.headers}', name: 'ApiClient');
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle common errors
        if (error.response?.statusCode == 401) {
          developer.log('🚫 Interceptor - 401 Unauthorized, clearing token', name: 'ApiClient');
          // Token expired, clear and redirect to login
          _prefs.remove(tokenKey);
        }
        handler.next(error);
      },
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, bool useStudentBase = false}) async {
    try {
      final fullUrl = useStudentBase ? '$path' : '$baseUrl$path';
      developer.log('🌐 API GET Request: $fullUrl', name: 'ApiClient');
      developer.log('📋 Query Parameters: $queryParameters', name: 'ApiClient');
      
      // Token is automatically added by the interceptor
      final response = await _dio.get(
        fullUrl, 
        queryParameters: queryParameters,
      );
      
      developer.log('✅ API GET Success: ${response.statusCode}', name: 'ApiClient');
      developer.log('📄 Response Data: ${response.data}', name: 'ApiClient');
      
      return response;
    } on DioException catch (e) {
      developer.log('❌ API GET Error: ${e.message}', name: 'ApiClient');
      developer.log('🔍 Error Type: ${e.type}', name: 'ApiClient');
      developer.log('📊 Status Code: ${e.response?.statusCode}', name: 'ApiClient');
      developer.log('📄 Error Response: ${e.response?.data}', name: 'ApiClient');
      developer.log('🔗 Request URL: ${e.requestOptions.uri}', name: 'ApiClient');
      developer.log('📋 Request Headers: ${e.requestOptions.headers}', name: 'ApiClient');
      
      throw _handleDioError(e);
    } catch (e) {
      developer.log('💥 Unexpected Error in GET: $e', name: 'ApiClient');
      throw ServerException('Unexpected error: $e');
    }
  }

  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      developer.log('🌐 API POST Request: $path', name: 'ApiClient');
      developer.log('📋 Query Parameters: $queryParameters', name: 'ApiClient');
      developer.log('📦 Request Data: $data', name: 'ApiClient');
      
      // Token is automatically added by the interceptor
      final response = await _dio.post(
        path, 
        data: data,
        queryParameters: queryParameters,
      );
      
      developer.log('✅ API POST Success: ${response.statusCode}', name: 'ApiClient');
      developer.log('📄 Response Data: ${response.data}', name: 'ApiClient');
      
      return response;
    } on DioException catch (e) {
      developer.log('❌ API POST Error: ${e.message}', name: 'ApiClient');
      developer.log('🔍 Error Type: ${e.type}', name: 'ApiClient');
      developer.log('📊 Status Code: ${e.response?.statusCode}', name: 'ApiClient');
      developer.log('📄 Error Response: ${e.response?.data}', name: 'ApiClient');
      developer.log('🔗 Request URL: ${e.requestOptions.uri}', name: 'ApiClient');
      developer.log('📋 Request Headers: ${e.requestOptions.headers}', name: 'ApiClient');
      developer.log('📦 Request Data: ${e.requestOptions.data}', name: 'ApiClient');
      
      throw _handleDioError(e);
    } catch (e) {
      developer.log('💥 Unexpected Error in POST: $e', name: 'ApiClient');
      throw ServerException('Unexpected error: $e');
    }
  }

  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.put(path, data: data, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  Exception _handleDioError(DioException error) {
    developer.log('🔧 Processing DioException: ${error.type}', name: 'ApiClient');
    
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        developer.log('⏰ Timeout Error: ${error.type}', name: 'ApiClient');
        return ServerException('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data?['message'] ?? 'Server error';
        developer.log('🚫 Bad Response: HTTP $statusCode - $message', name: 'ApiClient');
        return ServerException('HTTP $statusCode: $message');
      case DioExceptionType.cancel:
        developer.log('❌ Request Cancelled', name: 'ApiClient');
        return ServerException('Request cancelled');
      case DioExceptionType.connectionError:
        developer.log('🌐 Connection Error: No internet connection', name: 'ApiClient');
        return ServerException('No internet connection');
      default:
        developer.log('❓ Unknown Error Type: ${error.type}', name: 'ApiClient');
        return ServerException('Network error');
    }
  }

  void setToken(String token) {
    developer.log('🔑 Setting token in ApiClient: ${token.substring(0, token.length > 10 ? 10 : token.length)}...', name: 'ApiClient');
    _prefs.setString(tokenKey, token);
  }

  void clearToken() {
    _prefs.remove(tokenKey);
  }

  bool get isAuthenticated {
    final token = _prefs.getString(tokenKey);
    return token != null && token.isNotEmpty;
  }

  String? get currentToken => _prefs.getString(tokenKey);
}
