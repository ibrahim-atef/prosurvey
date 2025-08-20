import 'package:dartz/dartz.dart';
import 'dart:developer' as developer;
import '../../domain/repositories/dashboard_repository.dart';
import '../../core/error/failures.dart';
import '../../core/config/app_config.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  DashboardRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, Map<String, dynamic>>> getDashboardData() async {
    try {
      developer.log('📊 Getting Dashboard Data', name: 'DashboardRepository');
      developer.log('⚙️ Using Mock Data: ${AppConfig.useMockData}', name: 'DashboardRepository');
      
      if (AppConfig.useMockData) {
        developer.log('🎭 Using Mock Data for Dashboard', name: 'DashboardRepository');
        // Return mock dashboard data
        await Future.delayed(const Duration(seconds: 1));
        final mockData = {
          'user': {
            'full_name': 'أحمد محمد علي',
            'institute_name': 'معهد المساحة المطرية',
            'program_name': 'السنة الأولى',
          },
          'statistics': {
            'total_subjects': 8,
            'completed_units': 3,
            'total_exams': 5,
            'passed_exams': 4,
            'subscription_status': 'active',
            'days_remaining': 7,
          },
          'recent_activities': [
            {
              'type': 'exam',
              'title': 'امتحان المساحة الجيوديسية',
              'score': 85,
              'created_at': '2024-01-15 10:30:00',
            },
          ],
        };
        
        developer.log('✅ Mock Dashboard Data Loaded', name: 'DashboardRepository');
        return Right(mockData);
      } else {
        developer.log('🌐 Using Real API for Dashboard', name: 'DashboardRepository');
        // Use real API
        final response = await _apiClient.get('/dashboard');

        developer.log('📊 Dashboard Response Status: ${response.statusCode}', name: 'DashboardRepository');
        developer.log('📄 Dashboard Response Data: ${response.data}', name: 'DashboardRepository');

        if (response.statusCode == 200 && response.data['success'] == true) {
          developer.log('✅ Real Dashboard Data Loaded', name: 'DashboardRepository');
          return Right(response.data['data']);
        } else {
          developer.log('❌ Dashboard Failed: Invalid response', name: 'DashboardRepository');
          return const Left(ServerFailure('Failed to load dashboard data'));
        }
      }
    } catch (e) {
      developer.log('💥 Dashboard Error: $e', name: 'DashboardRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }
}
