import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/study_unit.dart';
import '../../repositories/course_repository.dart';

class GetUnitsUseCase implements UseCase<List<StudyUnit>, GetUnitsParams> {
  final CourseRepository repository;

  GetUnitsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StudyUnit>>> call(GetUnitsParams params) async {
    return await repository.getUnits(params.subjectId);
  }
}

class GetUnitsParams {
  final int subjectId;

  GetUnitsParams({required this.subjectId});
}
