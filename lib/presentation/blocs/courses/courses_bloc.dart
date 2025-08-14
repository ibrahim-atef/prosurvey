import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/subject.dart';
import '../../../domain/entities/course_content.dart';
import '../../../domain/usecases/courses/get_subjects_usecase.dart';
import '../../../domain/usecases/courses/get_course_content_usecase.dart';
import '../../../core/error/failures.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetSubjectsUseCase _getSubjectsUseCase;
  final GetCourseContentUseCase _getCourseContentUseCase;

  CoursesBloc(this._getSubjectsUseCase, this._getCourseContentUseCase)
      : super(CoursesInitial()) {
    on<LoadSubjects>(_onLoadSubjects);
    on<LoadCourseContent>(_onLoadCourseContent);
  }

  Future<void> _onLoadSubjects(
    LoadSubjects event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());

    final result = await _getSubjectsUseCase(GetSubjectsParams(
      institute: event.institute,
      year: event.year,
    ));

    result.fold(
      (failure) => emit(CoursesFailure(_mapFailureToMessage(failure))),
      (subjects) => emit(SubjectsLoaded(subjects)),
    );
  }

  Future<void> _onLoadCourseContent(
    LoadCourseContent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());

    final result = await _getCourseContentUseCase(GetCourseContentParams(
      subjectId: event.subjectId,
      type: event.type,
    ));

    result.fold(
      (failure) => emit(CoursesFailure(_mapFailureToMessage(failure))),
      (content) => emit(CourseContentLoaded(content)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'No internet connection';
      case ServerFailure:
        return 'Server error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }
}
