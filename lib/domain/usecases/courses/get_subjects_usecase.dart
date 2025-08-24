import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/subject.dart';
import '../../repositories/course_repository.dart';
import '../../../core/error/failures.dart';

class GetSubjectsUseCase {
  final CourseRepository repository;

  GetSubjectsUseCase(this.repository);

  Future<Either<Failure, List<Subject>>> call() async {
    return await repository.getSubjects();
  }
}

class GetSubjectsParams extends Equatable {
  final String institute;
  final String year;

  const GetSubjectsParams({
    required this.institute,
    required this.year,
  });

  @override
  List<Object> get props => [institute, year];
}
