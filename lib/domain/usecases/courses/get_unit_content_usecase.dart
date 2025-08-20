import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/unit_content.dart';
import '../../repositories/course_repository.dart';

class GetUnitContentUseCase implements UseCase<UnitContent, GetUnitContentParams> {
  final CourseRepository repository;

  GetUnitContentUseCase(this.repository);

  @override
  Future<Either<Failure, UnitContent>> call(GetUnitContentParams params) async {
    return await repository.getUnitContent(params.unitId);
  }
}

class GetUnitContentParams {
  final int unitId;

  GetUnitContentParams({required this.unitId});
}
