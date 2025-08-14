import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/exam.dart';
import '../../repositories/exam_repository.dart';
import '../../../core/error/failures.dart';

class GetExamsUseCase {
  final ExamRepository repository;

  GetExamsUseCase(this.repository);

  Future<Either<Failure, List<Exam>>> call(GetExamsParams params) async {
    return await repository.getExams(params.subjectId);
  }
}

class GetExamsParams extends Equatable {
  final String subjectId;

  const GetExamsParams({
    required this.subjectId,
  });

  @override
  List<Object> get props => [subjectId];
}
