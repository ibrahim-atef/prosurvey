part of 'exams_bloc.dart';

abstract class ExamsState extends Equatable {
  const ExamsState();

  @override
  List<Object?> get props => [];
}

class ExamsInitial extends ExamsState {}

class ExamsLoading extends ExamsState {}

class ExamSubmitting extends ExamsState {}

class ExamsLoaded extends ExamsState {
  final List<Exam> exams;

  const ExamsLoaded(this.exams);

  @override
  List<Object> get props => [exams];
}

class ExamSubmitted extends ExamsState {
  final ExamResult result;

  const ExamSubmitted(this.result);

  @override
  List<Object> get props => [result];
}

class ExamsFailure extends ExamsState {
  final String message;

  const ExamsFailure(this.message);

  @override
  List<Object> get props => [message];
}
