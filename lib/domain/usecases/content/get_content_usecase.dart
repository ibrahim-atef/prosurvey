import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/study_unit.dart';
import '../../repositories/content_repository.dart';

class GetStudyUnitsUseCase implements UseCase<List<StudyUnit>, String> {
  final ContentRepository repository;

  GetStudyUnitsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StudyUnit>>> call(String subjectId) async {
    return await repository.getStudyUnits(subjectId);
  }
}

class GetUnitDetailsUseCase implements UseCase<StudyUnit, String> {
  final ContentRepository repository;

  GetUnitDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StudyUnit>> call(String unitId) async {
    return await repository.getUnitDetails(unitId);
  }
}

class GetEducationalContentUseCase implements UseCase<List<EducationalContent>, String> {
  final ContentRepository repository;

  GetEducationalContentUseCase(this.repository);

  @override
  Future<Either<Failure, List<EducationalContent>>> call(String unitId) async {
    return await repository.getEducationalContent(unitId);
  }
}

class GetContentByTypeUseCase implements UseCase<List<EducationalContent>, Map<String, dynamic>> {
  final ContentRepository repository;

  GetContentByTypeUseCase(this.repository);

  @override
  Future<Either<Failure, List<EducationalContent>>> call(Map<String, dynamic> params) async {
    return await repository.getContentByType(
      type: params['type'],
      isFree: params['isFree'],
    );
  }
}

class UpdateContentViewCountUseCase implements UseCase<void, String> {
  final ContentRepository repository;

  UpdateContentViewCountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String contentId) async {
    return await repository.updateContentViewCount(contentId);
  }
}
