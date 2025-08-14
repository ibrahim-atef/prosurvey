import 'package:dartz/dartz.dart';
import '../../domain/entities/exam.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../core/error/failures.dart';
import '../../core/mock_data.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/exam_model.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  ExamRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, List<Exam>>> getExams(String subjectId) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final exams = MockData.sampleExams
          .where((exam) => exam['subject_id'] == subjectId)
          .map((json) => ExamModel.fromJson(json))
          .toList();
      return Right(exams);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Exam>> getExamById(String examId) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 1)); // Simulate API delay
      
      final exam = ExamModel.fromJson(MockData.sampleExam);
      return Right(exam);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExamResult>> submitExam(String examId, List<int> answers) async {
    try {
      // Use mock data for demo
      await Future.delayed(const Duration(seconds: 2)); // Simulate API delay
      
      final result = ExamResultModel.fromJson(MockData.examResult);
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExamResult>>> getExamResults(String subjectId) async {
    try {
      final response = await _apiClient.get('/exams/results', queryParameters: {
        'subject_id': subjectId,
      });

      if (response.statusCode == 200) {
        final List<dynamic> resultsData = response.data['results'];
        final results = resultsData
            .map((json) => ExamResultModel.fromJson(json))
            .toList();
        return Right(results);
      } else {
        return const Left(ServerFailure('Failed to load exam results'));
      }
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }
}
