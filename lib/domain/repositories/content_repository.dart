import 'package:dartz/dartz.dart';
import '../entities/study_unit.dart';
import '../../core/error/failures.dart';

abstract class ContentRepository {
  Future<Either<Failure, List<StudyUnit>>> getStudyUnits(String subjectId);
  Future<Either<Failure, StudyUnit>> getUnitDetails(String unitId);
  Future<Either<Failure, List<EducationalContent>>> getEducationalContent(String unitId);
  Future<Either<Failure, List<EducationalContent>>> getContentByType({
    String? type,
    bool? isFree,
  });
  Future<Either<Failure, void>> updateContentViewCount(String contentId);
}
