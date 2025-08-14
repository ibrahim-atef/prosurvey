import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/usecases/exams/get_exams_usecase.dart';
import '../../../domain/usecases/exams/submit_exam_usecase.dart';
import '../../../core/error/failures.dart';

part 'exams_event.dart';
part 'exams_state.dart';

class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  final GetExamsUseCase _getExamsUseCase;
  final SubmitExamUseCase _submitExamUseCase;

  ExamsBloc(this._getExamsUseCase, this._submitExamUseCase)
      : super(ExamsInitial()) {
    on<LoadExams>(_onLoadExams);
    on<SubmitExam>(_onSubmitExam);
  }

  Future<void> _onLoadExams(
    LoadExams event,
    Emitter<ExamsState> emit,
  ) async {
    emit(ExamsLoading());

    final result = await _getExamsUseCase(GetExamsParams(
      subjectId: event.subjectId,
    ));

    result.fold(
      (failure) => emit(ExamsFailure(_mapFailureToMessage(failure))),
      (exams) => emit(ExamsLoaded(exams)),
    );
  }

  Future<void> _onSubmitExam(
    SubmitExam event,
    Emitter<ExamsState> emit,
  ) async {
    emit(ExamSubmitting());

    final result = await _submitExamUseCase(SubmitExamParams(
      examId: event.examId,
      answers: event.answers,
    ));

    result.fold(
      (failure) => emit(ExamsFailure(_mapFailureToMessage(failure))),
      (result) => emit(ExamSubmitted(result)),
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
