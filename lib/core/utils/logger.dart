import 'dart:developer' as developer;

class Logger {
  static void info(String message, {String? tag}) {
    developer.log('ℹ️ $message', name: tag ?? 'App');
  }

  static void success(String message, {String? tag}) {
    developer.log('✅ $message', name: tag ?? 'App');
  }

  static void warning(String message, {String? tag}) {
    developer.log('⚠️ $message', name: tag ?? 'App');
  }

  static void error(String message, {String? tag}) {
    developer.log('❌ $message', name: tag ?? 'App');
  }

  static void debug(String message, {String? tag}) {
    developer.log('🔍 $message', name: tag ?? 'App');
  }

  static void api(String message, {String? tag}) {
    developer.log('🌐 $message', name: tag ?? 'ApiClient');
  }

  static void auth(String message, {String? tag}) {
    developer.log('🔐 $message', name: tag ?? 'AuthRepository');
  }

  static void course(String message, {String? tag}) {
    developer.log('📚 $message', name: tag ?? 'CourseRepository');
  }

  static void exam(String message, {String? tag}) {
    developer.log('📝 $message', name: tag ?? 'ExamRepository');
  }

  static void dashboard(String message, {String? tag}) {
    developer.log('📊 $message', name: tag ?? 'DashboardRepository');
  }
}









