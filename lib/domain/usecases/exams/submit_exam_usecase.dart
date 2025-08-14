import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../../../core/error/failures.dart';

class SubmitExamUseCase {
  final ExamRepository repository;

  SubmitExamUseCase(this.repository);

  Future<Either<Failure, ExamResult>> call(SubmitExamParams params) async {
    return await repository.submitExam(params.examId, params.answers);
  }
}

class SubmitExamParams extends Equatable {
  final String examId;
  final List<int> answers;

  const SubmitExamParams({
    required this.examId,
    required this.answers,
  });

  @override
  List<Object> get props => [examId, answers];
}
