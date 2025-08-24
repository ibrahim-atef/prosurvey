import 'package:dartz/dartz.dart';
import '../entities/exam.dart';
import '../../core/error/failures.dart';

abstract class ExamRepository {
  Future<Either<Failure, List<Exam>>> getAvailableExams();
  Future<Either<Failure, List<Exam>>> getExams(String subjectId);
  Future<Either<Failure, ExamDetails>> getExamDetails(int examId);
  Future<Either<Failure, Exam>> getExamById(String examId);
  Future<Either<Failure, ExamResult>> submitExam(String examId, List<int> answers);
  Future<Either<Failure, List<ExamResult>>> getExamResults(String subjectId);
}

class ExamDetails {
  final ExamInfo examInfo;
  final List<Question> questions;

  const ExamDetails({
    required this.examInfo,
    required this.questions,
  });
}
