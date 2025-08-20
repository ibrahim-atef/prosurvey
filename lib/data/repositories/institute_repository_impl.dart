import 'dart:developer';

import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/institute.dart';
import '../../domain/repositories/institute_repository.dart';
import '../datasources/remote/api_client.dart';
import '../models/institute_model.dart';

class InstituteRepositoryImpl implements InstituteRepository {
  final ApiClient apiClient;

  InstituteRepositoryImpl(this.apiClient);

  @override
  Future<Either<Failure, List<Institute>>> getAllInstitutes() async {
    try {
      final response = await apiClient.get('/institutes', useStudentBase: true);
      final List<dynamic> data = response.data['data'] ?? [];
      
      // إذا كانت المصفوفة فارغة، نضيف معاهد تجريبية للاختبار
      if (data.isEmpty) {
        final mockInstitutes = [];
        return Right([]);
      }
      
      final institutes = data
          .map((json) => InstituteModel.fromJson(json))
          .toList();
      return Right(institutes);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log("err on getInstitutes: $e");
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, Institute>> getInstituteDetails(String instituteId) async {
    try {
      final response = await apiClient.get('/institutes/$instituteId', useStudentBase: true);
      final institute = InstituteModel.fromJson(response.data['data']);
      return Right(institute);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, List<AcademicProgram>>> getAcademicPrograms({
    String? instituteId,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (instituteId != null) {
        queryParams['institute_id'] = instituteId;
      }
      
      final response = await apiClient.get('/academic-programs', queryParameters: queryParams, useStudentBase: false);
      final List<dynamic> data = response.data['data'] ?? [];
      
      // إذا كانت المصفوفة فارغة، نضيف برامج تجريبية للاختبار
      if (data.isEmpty) {
        final mockPrograms = [
          AcademicProgramModel(
            id: '1',
            name: 'First Year Surveying',
            nameArabic: 'سنة أولى مساحة',
            instituteId: instituteId ?? '1',
            programType: 'surveying_first_year',
            description: 'البرنامج الأكاديمي للسنة الأولى قسم المساحة',
            duration: 12,
            isActive: true,
          ),
          AcademicProgramModel(
            id: '2',
            name: 'Second Year Surveying',
            nameArabic: 'سنة ثانية قسم مساحة',
            instituteId: instituteId ?? '1',
            programType: 'surveying_second_year',
            description: 'البرنامج الأكاديمي للسنة الثانية قسم المساحة',
            duration: 12,
            isActive: true,
          ),
          AcademicProgramModel(
            id: '3',
            name: 'Second Year Irrigation',
            nameArabic: 'سنة ثانية قسم ري وصرف',
            instituteId: instituteId ?? '1',
            programType: 'irrigation_second_year',
            description: 'البرنامج الأكاديمي للسنة الثانية قسم الري والصرف',
            duration: 12,
            isActive: true,
          ),
        ];
        return Right(mockPrograms);
      }
      
      final programs = data
          .map((json) => AcademicProgramModel.fromJson(json))
          .toList();
      return Right(programs);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }

  @override
  Future<Either<Failure, AcademicProgram>> getProgramByType(String programType) async {
    try {
      final response = await apiClient.get('/academic-programs/type/$programType', useStudentBase: false);
      final program = AcademicProgramModel.fromJson(response.data['data']);
      return Right(program);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('حدث خطأ غير متوقع'));
    }
  }
}
