part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSubjects extends CoursesEvent {
  const LoadSubjects();

  @override
  List<Object> get props => [];
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

class CheckAndLoadSubjects extends CoursesEvent {
  const CheckAndLoadSubjects();

  @override
  List<Object> get props => [];
}
