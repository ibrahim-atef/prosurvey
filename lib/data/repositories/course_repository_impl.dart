import 'package:dartz/dartz.dart';
import 'dart:developer' as developer;
import '../../domain/entities/subject.dart';
import '../../domain/entities/course_content.dart';
import '../../domain/entities/unit.dart';
import '../../domain/entities/unit_content.dart';
import '../../domain/repositories/course_repository.dart';
import '../../core/error/failures.dart';
import '../../core/mock_data.dart';
import '../../core/config/app_config.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/subject_model.dart';
import '../models/course_content_model.dart';
import '../models/unit_model.dart';
import '../models/unit_content_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  CourseRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, List<Subject>>> getSubjects(String institute, String year) async {
    try {
      developer.log('📚 Getting Subjects: Institute=$institute, Year=$year', name: 'CourseRepository');
      developer.log('⚙️ Using Mock Data: ${AppConfig.useMockData}', name: 'CourseRepository');
      
      if (AppConfig.useMockData) {
        developer.log('🎭 Using Mock Data for Subjects', name: 'CourseRepository');
        // Use mock data for demo
        await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
        
        final subjects = MockData.subjectsFirstYearMataria
            .map((json) => SubjectModel.fromJson(json))
            .toList();
        
        developer.log('✅ Mock Subjects Loaded: ${subjects.length} subjects', name: 'CourseRepository');
        return Right(subjects);
      } else {
        developer.log('🌐 Using Real API for Subjects', name: 'CourseRepository');
        // Use real API
        final response = await _apiClient.get('/subjects');

        developer.log('📊 Subjects Response Status: ${response.statusCode}', name: 'CourseRepository');
        developer.log('📄 Subjects Response Data: ${response.data}', name: 'CourseRepository');

        if (response.statusCode == 200 && response.data['success'] == true) {
          final List<dynamic> subjectsData = response.data['data'];
          final subjects = subjectsData
              .map((json) => SubjectModel.fromJson(json))
              .toList();
          
          developer.log('✅ Real Subjects Loaded: ${subjects.length} subjects', name: 'CourseRepository');
          return Right(subjects);
        } else {
          developer.log('❌ Subjects Failed: Invalid response', name: 'CourseRepository');
          return const Left(ServerFailure('Failed to load subjects'));
        }
      }
    } catch (e) {
      developer.log('💥 Subjects Error: $e', name: 'CourseRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseContent>>> getCourseContent(String subjectId, ContentType type) async {
    try {
      developer.log('📖 Getting Course Content: SubjectId=$subjectId, Type=$type', name: 'CourseRepository');
      
      final response = await _apiClient.get('/content', queryParameters: {
        'subject_id': subjectId,
        'type': type.toString().split('.').last,
      });

      developer.log('📊 Content Response Status: ${response.statusCode}', name: 'CourseRepository');
      developer.log('📄 Content Response Data: ${response.data}', name: 'CourseRepository');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> contentData = response.data['data'];
        final content = contentData
            .map((json) => CourseContentModel.fromJson(json))
            .toList();
        
        developer.log('✅ Course Content Loaded: ${content.length} items', name: 'CourseRepository');
        return Right(content);
      } else {
        developer.log('❌ Course Content Failed: Invalid response', name: 'CourseRepository');
        return const Left(ServerFailure('Failed to load content'));
      }
    } catch (e) {
      developer.log('💥 Course Content Error: $e', name: 'CourseRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseContent>> getContentById(String contentId) async {
    try {
      final response = await _apiClient.get('/content/$contentId');

      if (response.statusCode == 200) {
        final content = CourseContentModel.fromJson(response.data);
        return Right(content);
      } else {
        return const Left(ServerFailure('Failed to load content'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudyUnit>>> getUnits(int subjectId) async {
    try {
      developer.log('📚 Getting Units: SubjectId=$subjectId', name: 'CourseRepository');
      developer.log('⚙️ Using Mock Data: ${AppConfig.useMockData}', name: 'CourseRepository');
      
      if (AppConfig.useMockData) {
        developer.log('🎭 Using Mock Data for Units', name: 'CourseRepository');
        // Use mock data for demo
        await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
        
        final units = MockData.sampleUnits
            .map((json) => UnitModel.fromJson(json))
            .toList();
        
        developer.log('✅ Mock Units Loaded: ${units.length} units', name: 'CourseRepository');
        return Right(units);
      } else {
        developer.log('🌐 Using Real API for Units', name: 'CourseRepository');
        
        final response = await _apiClient.get('/units', queryParameters: {
          'subject_id': subjectId,
        });

        developer.log('📊 Units Response Status: ${response.statusCode}', name: 'CourseRepository');
        developer.log('📄 Units Response Data: ${response.data}', name: 'CourseRepository');

        if (response.statusCode == 200 && response.data['success'] == true) {
          final List<dynamic> unitsData = response.data['data'];
          final units = unitsData
              .map((json) => UnitModel.fromJson(json))
              .toList();
          
          developer.log('✅ Real Units Loaded: ${units.length} units', name: 'CourseRepository');
          return Right(units);
        } else {
          developer.log('❌ Units Failed: Invalid response', name: 'CourseRepository');
          return const Left(ServerFailure('Failed to load units'));
        }
      }
    } catch (e) {
      developer.log('💥 Units Error: $e', name: 'CourseRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UnitContent>> getUnitContent(int unitId) async {
    try {
      developer.log('📖 Getting Unit Content: UnitId=$unitId', name: 'CourseRepository');
      developer.log('⚙️ Using Mock Data: ${AppConfig.useMockData}', name: 'CourseRepository');
      
      if (AppConfig.useMockData) {
        developer.log('🎭 Using Mock Data for Unit Content', name: 'CourseRepository');
        // Use mock data for demo
        await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
        
        final unitContent = UnitContentModel.fromJson(MockData.sampleUnitContent);
        
        developer.log('✅ Mock Unit Content Loaded: ${unitContent.content.length} items', name: 'CourseRepository');
        return Right(unitContent);
      } else {
        developer.log('🌐 Using Real API for Unit Content', name: 'CourseRepository');
        
        final response = await _apiClient.get('/content/by-unit', queryParameters: {
          'unit_id': unitId,
        });

        developer.log('📊 Unit Content Response Status: ${response.statusCode}', name: 'CourseRepository');
        developer.log('📄 Unit Content Response Data: ${response.data}', name: 'CourseRepository');

        if (response.statusCode == 200 && response.data['success'] == true) {
          final unitContent = UnitContentModel.fromJson(response.data['data']);
          
          developer.log('✅ Real Unit Content Loaded: ${unitContent.content.length} items', name: 'CourseRepository');
          return Right(unitContent);
        } else {
          developer.log('❌ Unit Content Failed: Invalid response', name: 'CourseRepository');
          return const Left(ServerFailure('Failed to load unit content'));
        }
      }
    } catch (e) {
      developer.log('💥 Unit Content Error: $e', name: 'CourseRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }
}
