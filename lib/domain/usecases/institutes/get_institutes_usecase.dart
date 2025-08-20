import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/institute.dart';
import '../../repositories/institute_repository.dart';

class GetInstitutesUseCase implements UseCase<List<Institute>, NoParams> {
  final InstituteRepository repository;

  GetInstitutesUseCase(this.repository);

  @override
  Future<Either<Failure, List<Institute>>> call(NoParams params) async {
    return await repository.getAllInstitutes();
  }
}

class GetInstituteDetailsUseCase implements UseCase<Institute, String> {
  final InstituteRepository repository;

  GetInstituteDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, Institute>> call(String instituteId) async {
    return await repository.getInstituteDetails(instituteId);
  }
}

class GetAcademicProgramsUseCase implements UseCase<List<AcademicProgram>, Map<String, dynamic>> {
  final InstituteRepository repository;

  GetAcademicProgramsUseCase(this.repository);

  @override
  Future<Either<Failure, List<AcademicProgram>>> call(Map<String, dynamic> params) async {
    return await repository.getAcademicPrograms(
      instituteId: params['instituteId'],
    );
  }
}
