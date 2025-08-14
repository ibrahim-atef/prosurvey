part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class SubjectsLoaded extends CoursesState {
  final List<Subject> subjects;

  const SubjectsLoaded(this.subjects);

  @override
  List<Object> get props => [subjects];
}

class CourseContentLoaded extends CoursesState {
  final List<CourseContent> content;

  const CourseContentLoaded(this.content);

  @override
  List<Object> get props => [content];
}

class CoursesFailure extends CoursesState {
  final String message;

  const CoursesFailure(this.message);

  @override
  List<Object> get props => [message];
}
