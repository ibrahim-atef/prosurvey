import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/course_content.dart';
import '../../repositories/course_repository.dart';
import '../../../core/error/failures.dart';

class GetCourseContentUseCase {
  final CourseRepository repository;

  GetCourseContentUseCase(this.repository);

  Future<Either<Failure, List<CourseContent>>> call(GetCourseContentParams params) async {
    return await repository.getCourseContent(params.subjectId, params.type);
  }
}

class GetCourseContentParams extends Equatable {
  final String subjectId;
  final ContentType type;

  const GetCourseContentParams({
    required this.subjectId,
    required this.type,
  });

  @override
  List<Object> get props => [subjectId, type];
}
