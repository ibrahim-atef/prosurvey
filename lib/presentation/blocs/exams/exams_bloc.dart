import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/exam.dart';
import '../../../domain/repositories/exam_repository.dart';
import '../../../domain/usecases/exams/get_available_exams_usecase.dart';
import '../../../domain/usecases/exams/get_exam_details_usecase.dart';
import '../../../domain/usecases/exams/submit_exam_usecase.dart';
import '../../../core/error/failures.dart';

part 'exams_event.dart';
part 'exams_state.dart';

class ExamsBloc extends Bloc<ExamsEvent, ExamsState> {
  final GetAvailableExamsUseCase _getAvailableExamsUseCase;
  final GetExamDetailsUseCase _getExamDetailsUseCase;
  final SubmitExamUseCase _submitExamUseCase;

  ExamsBloc(this._getAvailableExamsUseCase, this._getExamDetailsUseCase, this._submitExamUseCase)
      : super(ExamsInitial()) {
    on<LoadExams>(_onLoadExams);
    on<LoadExamDetails>(_onLoadExamDetails);
    on<SubmitExam>(_onSubmitExam);
  }

  Future<void> _onLoadExams(
    LoadExams event,
    Emitter<ExamsState> emit,
  ) async {
    emit(ExamsLoading());

    final result = await _getAvailableExamsUseCase();

    result.fold(
      (failure) => emit(ExamsFailure(_mapFailureToMessage(failure))),
      (exams) => emit(ExamsLoaded(exams)),
    );
  }

  Future<void> _onLoadExamDetails(
    LoadExamDetails event,
    Emitter<ExamsState> emit,
  ) async {
    emit(ExamsLoading());

    final result = await _getExamDetailsUseCase(event.examId);

    result.fold(
      (failure) => emit(ExamsFailure(_mapFailureToMessage(failure))),
      (examDetails) => emit(ExamDetailsLoaded(examDetails)),
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
