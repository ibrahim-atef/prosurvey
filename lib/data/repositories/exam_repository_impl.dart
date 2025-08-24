import 'package:dartz/dartz.dart';
import 'dart:developer' as developer;
import '../../domain/entities/exam.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../core/error/failures.dart';
import '../datasources/remote/api_client.dart';
import '../datasources/local/local_storage.dart';
import '../models/exam_model.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  ExamRepositoryImpl(this._apiClient, this._localStorage);

  @override
  Future<Either<Failure, List<Exam>>> getAvailableExams() async {
    try {
      developer.log('📝 Getting Available Exams', name: 'ExamRepository');
      
      final response = await _apiClient.get('/student/exams/available', useStudentBase: true);

      developer.log('📊 Available Exams Response Status: ${response.statusCode}', name: 'ExamRepository');
      developer.log('📄 Available Exams Response Data: ${response.data}', name: 'ExamRepository');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> examsData = response.data['data'];
        final exams = examsData
            .map((json) => ExamModel.fromJson(json))
            .toList();
        
        developer.log('✅ Available Exams Loaded: ${exams.length} exams', name: 'ExamRepository');
        return Right(exams);
      } else {
        developer.log('❌ Available Exams Failed: Invalid response', name: 'ExamRepository');
        return const Left(ServerFailure('Failed to load available exams'));
      }
    } catch (e) {
      developer.log('💥 Available Exams Error: $e', name: 'ExamRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Exam>>> getExams(String subjectId) async {
    try {
      developer.log('📝 Getting Exams: SubjectId=$subjectId', name: 'ExamRepository');
      
      final response = await _apiClient.get('/exams', queryParameters: {
        'subject_id': subjectId,
      });

      developer.log('📊 Exams Response Status: ${response.statusCode}', name: 'ExamRepository');
      developer.log('📄 Exams Response Data: ${response.data}', name: 'ExamRepository');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> examsData = response.data['data'];
        final exams = examsData
            .map((json) => ExamModel.fromJson(json))
            .toList();
        
        developer.log('✅ Exams Loaded: ${exams.length} exams', name: 'ExamRepository');
        return Right(exams);
      } else {
        developer.log('❌ Exams Failed: Invalid response', name: 'ExamRepository');
        return const Left(ServerFailure('Failed to load exams'));
      }
    } catch (e) {
      developer.log('💥 Exams Error: $e', name: 'ExamRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Exam>> getExamById(String examId) async {
    try {
      // This method will be implemented when the API endpoint is available
      return const Left(ServerFailure('Method not implemented yet'));
    } catch (e) {
      return Left(NetworkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ExamResult>> submitExam(String examId, List<int> answers) async {
    try {
      // This method will be implemented when the API endpoint is available
      return const Left(ServerFailure('Method not implemented yet'));
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

  @override
  Future<Either<Failure, ExamDetails>> getExamDetails(int examId) async {
    try {
      developer.log('📝 Getting Exam Details: ExamId=$examId', name: 'ExamRepository');
      
      final response = await _apiClient.get('/student/exams/questions?exam_id=$examId', useStudentBase: true);

      developer.log('📊 Exam Details Response Status: ${response.statusCode}', name: 'ExamRepository');
      developer.log('📄 Exam Details Response Data: ${response.data}', name: 'ExamRepository');

      if (response.statusCode == 200 && response.data['success'] == true) {
        final examInfo = ExamInfoModel.fromJson(response.data['data']['exam_info']);
        final questionsData = response.data['data']['questions'] as List;
        final questions = questionsData
            .map((json) => QuestionModel.fromJson(json))
            .toList();
        
        final examDetails = ExamDetails(
          examInfo: examInfo,
          questions: questions,
        );
        
        developer.log('✅ Exam Details Loaded: ${questions.length} questions', name: 'ExamRepository');
        return Right(examDetails);
      } else {
        developer.log('❌ Exam Details Failed: Invalid response', name: 'ExamRepository');
        return const Left(ServerFailure('Failed to load exam details'));
      }
    } catch (e) {
      developer.log('💥 Exam Details Error: $e', name: 'ExamRepository');
      return Left(NetworkFailure(e.toString()));
    }
  }
}
