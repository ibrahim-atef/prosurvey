import 'package:dartz/dartz.dart';
import '../entities/subject.dart';
import '../entities/course_content.dart';
import '../entities/study_unit.dart';
import '../entities/unit_content.dart';
import '../entities/pdf_content.dart';
import '../../core/error/failures.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Subject>>> getSubjects();
  Future<Either<Failure, List<CourseContent>>> getCourseContent(String subjectId, ContentType type);
  Future<Either<Failure, CourseContent>> getContentById(String contentId);
  Future<Either<Failure, List<StudyUnit>>> getUnits(int subjectId);
  Future<Either<Failure, UnitContent>> getUnitContent(int unitId);
  Future<Either<Failure, PdfContentResponse>> getPdfContent();
}
