import 'package:dartz/dartz.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/course_content.dart';
import '../../domain/repositories/course_repository.dart';
import '../../core/error/failures.dart';
import '../../core/mock_data.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/subject_model.dart';
import '../models/course_content_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  CourseRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, List<Subject>>> getSubjects(String institute, String year) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final subjects = MockData.subjectsFirstYearMataria
          .map((json) => SubjectModel.fromJson(json))
          .toList();
      return Right(subjects);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseContent>>> getCourseContent(String subjectId, ContentType type) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final content = MockData.courseContent
          .where((item) => item['subject_id'] == subjectId && item['type'] == type.toString().split('.').last)
          .map((json) => CourseContentModel.fromJson(json))
          .toList();
      return Right(content);
    } catch (e) {
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
}
