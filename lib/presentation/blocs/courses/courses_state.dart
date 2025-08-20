part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesDataLoaded extends CoursesState {
  final List<Subject>? subjects;
  final List<CourseContent>? courseContent;
  final bool isLoading;
  final String? errorMessage;

  const CoursesDataLoaded({
    this.subjects,
    this.courseContent,
    this.isLoading = false,
    this.errorMessage,
  });

  CoursesDataLoaded copyWith({
    List<Subject>? subjects,
    List<CourseContent>? courseContent,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CoursesDataLoaded(
      subjects: subjects ?? this.subjects,
      courseContent: courseContent ?? this.courseContent,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        subjects,
        courseContent,
        isLoading,
        errorMessage,
      ];
}

// Legacy states for backward compatibility
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
