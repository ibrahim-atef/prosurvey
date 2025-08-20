# API Integration Guide

## Overview
This Flutter app has been integrated with the real Student API for the Surveying Learning platform. The integration supports both mock data (for development/demo) and real API calls.

## Configuration

### Switching Between Mock and Real API
Edit `lib/core/config/app_config.dart`:

```dart
class AppConfig {
  // Set to true for mock data, false for real API
  static const bool useMockData = false;
  
  // API Base URL
  static const String apiBaseUrl = 'https://mesaha.anmka.com/student';
}
```

## API Endpoints Integrated

### Authentication
- `POST /login` - Student login
- `POST /register` - Student registration
- `GET /profile` - Get student profile
- `PUT /profile` - Update student profile

### Institutes
- `GET /institutes` - Get all institutes and programs

### Subjects
- `GET /subjects` - Get all subjects
- `GET /subjects/categories` - Get subject categories

### Content
- `GET /content` - Get educational content (videos, PDFs, sheets)

### Exams
- `GET /exams` - Get all exams

### Dashboard
- `GET /dashboard` - Get student dashboard data

### Subscription
- `GET /subscription/status` - Get subscription status
- `GET /subscription/plans` - Get available subscription plans

### Progress
- `GET /progress` - Get student progress

### Notifications
- `GET /notifications` - Get student notifications

## Response Format
All API responses follow this format:
```json
{
  "success": true,
  "message": "Success message",
  "data": {
    // Response data
  }
}
```

## Error Handling
The app handles common HTTP errors:
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Internal Server Error

## Models Updated
The following models have been updated to match the API response structure:
- `UserModel` - Supports both old and new API formats
- `SubjectModel` - Maps API subject data
- `CourseContentModel` - Handles content types and durations
- `ExamModel` - Exam structure mapping

## Testing
1. Set `useMockData = true` for development with mock data
2. Set `useMockData = false` to test with real API
3. Ensure the API server is running and accessible

## Fallback Mechanism
If the API is unavailable, the app gracefully falls back to mock data for demonstration purposes.

## Debugging and Logging

### Comprehensive Logging System
The app includes detailed logging for all API operations:

#### Log Categories:
- **🌐 ApiClient**: All HTTP requests and responses
- **🔐 AuthRepository**: Authentication operations
- **📚 CourseRepository**: Subject and content operations
- **📝 ExamRepository**: Exam operations
- **📊 DashboardRepository**: Dashboard data operations

#### Log Information:
- Request URLs and parameters
- Response status codes and data
- Error details and stack traces
- Mock vs Real API usage
- Success/failure indicators

#### How to View Logs:
1. **Flutter DevTools**: Open DevTools and check the Console tab
2. **VS Code**: Check the Debug Console when running the app
3. **Android Studio**: Check the Logcat for Android logs
4. **Terminal**: Use `flutter logs` command

#### Example Log Output:
```
🌐 API GET Request: /subjects
📋 Query Parameters: null
✅ API GET Success: 200
📄 Response Data: {success: true, data: [...]}
```

#### Error Logging:
```
❌ API GET Error: Connection timeout
🔍 Error Type: DioExceptionType.connectionTimeout
📊 Status Code: null
🔗 Request URL: https://mesaha.anmka.com/student/subjects
```

### Debugging Tips:
1. **Check Network**: Ensure internet connection is available
2. **API Status**: Verify the API server is running
3. **Configuration**: Check `AppConfig.useMockData` setting
4. **Token Issues**: Look for 401 errors in authentication
5. **Response Format**: Verify API responses match expected format
