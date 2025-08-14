import 'package:dartz/dartz.dart';
import '../entities/subject.dart';
import '../entities/course_content.dart';
import '../../core/error/failures.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Subject>>> getSubjects(String institute, String year);
  Future<Either<Failure, List<CourseContent>>> getCourseContent(String subjectId, ContentType type);
  Future<Either<Failure, CourseContent>> getContentById(String contentId);
}
