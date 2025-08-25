import 'package:dartz/dartz.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../../../core/error/failures.dart';

class GetAvailableExamsUseCase {
  final ExamRepository repository;

  GetAvailableExamsUseCase(this.repository);

  Future<Either<Failure, List<Exam>>> call() async {
    return await repository.getAvailableExams();
  }
}


