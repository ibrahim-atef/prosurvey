import '../config/app_config.dart';

class UrlUtils {
  /// Builds a full URL from a relative file path
  /// If the path already has a scheme (http:// or https://), it returns as is
  /// Otherwise, it combines the path with the student base URL
  static String buildFullUrl(String filePath) {
    // Check if the filePath already has a scheme (http:// or https://)
    if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
      return filePath;
    }
    
    // If it's a relative path, combine it with the base URL
    // Remove leading slash if present to avoid double slashes
    final cleanPath = filePath.startsWith('/') ? filePath.substring(1) : filePath;
    return '${AppConfig.studentBaseUrl}/$cleanPath';
  }

  /// Validates if a URL is properly formatted
  static bool isValidUrl(String url) {
    try {
      Uri.parse(url);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Safely parses a URL, returning null if invalid
  static Uri? parseUrl(String url) {
    try {
      return Uri.parse(url);
    } catch (e) {
      return null;
    }
  }
}
