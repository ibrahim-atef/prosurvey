import 'package:dartz/dartz.dart';
import '../entities/institute.dart';
import '../../core/error/failures.dart';

abstract class InstituteRepository {
  Future<Either<Failure, List<Institute>>> getAllInstitutes();
  Future<Either<Failure, Institute>> getInstituteDetails(String instituteId);
  Future<Either<Failure, List<AcademicProgram>>> getAcademicPrograms({
    String? instituteId,
  });
  Future<Either<Failure, AcademicProgram>> getProgramByType(String programType);
}
