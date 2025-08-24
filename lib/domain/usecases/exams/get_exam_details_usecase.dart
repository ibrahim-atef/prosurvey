import 'package:dartz/dartz.dart';
import '../../repositories/exam_repository.dart';
import '../../../core/error/failures.dart';

class GetExamDetailsUseCase {
  final ExamRepository repository;

  GetExamDetailsUseCase(this.repository);

  Future<Either<Failure, ExamDetails>> call(int examId) async {
    return await repository.getExamDetails(examId);
  }
}
