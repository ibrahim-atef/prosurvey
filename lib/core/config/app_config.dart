class AppConfig {
  // API Configuration
  static const bool useMockData = false; // Set to true to use mock data, false for real API
  static const String apiBaseUrl = 'https://mesaha.anmka.com/api';
  static const String studentBaseUrl = 'https://mesaha.anmka.com/student';
  static const String adminBaseUrl = 'https://mesaha.anmka.com/admin';
  
  // للطلاب، نستخدم student_base للمعاهد
  static const String institutesUrl = '/institutes'; // سيتم استخدامه مع studentBaseUrl
  
  // App Configuration
  static const String appName = 'Mesaha';
  static const String appVersion = '1.0.0';
  
  // Timeout Configuration
  static const int connectionTimeout = 30; // seconds
  static const int receiveTimeout = 30; // seconds
  
  // Cache Configuration
  static const int cacheTimeout = 300; // 5 minutes
  
  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enablePushNotifications = true;
  
  // Content Types
  static const List<String> supportedContentTypes = ['video', 'pdf', 'sheet'];
  
  // Payment Methods
  static const List<String> supportedPaymentMethods = [
    'credit_card',
    'bank_transfer',
    'mobile_payment',
    'cash',
  ];
}
