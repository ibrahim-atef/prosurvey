part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubjects extends CoursesEvent {
  final String institute;
  final String year;

  const LoadSubjects({
    required this.institute,
    required this.year,
  });

  @override
  List<Object> get props => [institute, year];
}

class LoadCourseContent extends CoursesEvent {
  final String subjectId;
  final ContentType type;

  const LoadCourseContent({
    required this.subjectId,
    required this.type,
  });

  @override
  List<Object> get props => [subjectId, type];
}
