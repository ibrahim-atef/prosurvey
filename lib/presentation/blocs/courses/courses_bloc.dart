import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/subject.dart';
import '../../../domain/entities/course_content.dart' show CourseContent, ContentType;
import '../../../domain/usecases/courses/get_subjects_usecase.dart';
import '../../../domain/usecases/courses/get_course_content_usecase.dart';
import '../../../core/error/failures.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetSubjectsUseCase _getSubjectsUseCase;
  final GetCourseContentUseCase _getCourseContentUseCase;

  CoursesBloc(
    this._getSubjectsUseCase, 
    this._getCourseContentUseCase,
  ) : super(const CoursesDataLoaded()) {
    on<LoadSubjects>(_onLoadSubjects);
    on<LoadCourseContent>(_onLoadCourseContent);
    on<CheckAndLoadSubjects>(_onCheckAndLoadSubjects);
  }

  Future<void> _onLoadSubjects(
    LoadSubjects event,
    Emitter<CoursesState> emit,
  ) async {
    final currentState = state;
    if (currentState is CoursesDataLoaded) {
      emit(currentState.copyWith(isLoading: true, errorMessage: null));
    } else {
      emit(const CoursesDataLoaded(isLoading: true));
    }

    final result = await _getSubjectsUseCase();

    result.fold(
      (failure) {
        if (currentState is CoursesDataLoaded) {
          emit(currentState.copyWith(
            isLoading: false,
            errorMessage: _mapFailureToMessage(failure),
          ));
        } else {
          emit(CoursesDataLoaded(errorMessage: _mapFailureToMessage(failure)));
        }
      },
      (subjects) {
        if (currentState is CoursesDataLoaded) {
          emit(currentState.copyWith(
            subjects: subjects,
            isLoading: false,
            errorMessage: null,
          ));
        } else {
          emit(CoursesDataLoaded(subjects: subjects));
        }
      },
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

  Future<void> _onCheckAndLoadSubjects(
    CheckAndLoadSubjects event,
    Emitter<CoursesState> emit,
  ) async {
    final currentState = state;
    if (currentState is CoursesDataLoaded && currentState.subjects != null) {
      // Data already exists, no need to reload
      return;
    }
    
    // Load subjects if not available
    await _onLoadSubjects(const LoadSubjects(), emit);
  }
}
