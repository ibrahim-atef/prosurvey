part of 'exams_bloc.dart';

abstract class ExamsEvent extends Equatable {
  const ExamsEvent();

  @override
  List<Object?> get props => [];
}

class LoadExams extends ExamsEvent {
  const LoadExams();

  @override
  List<Object> get props => [];
}

class LoadExamDetails extends ExamsEvent {
  final int examId;

  const LoadExamDetails(this.examId);

  @override
  List<Object> get props => [examId];
}

class SubmitExam extends ExamsEvent {
  final String examId;
  final List<int> answers;

  const SubmitExam({
    required this.examId,
    required this.answers,
  });

  @override
  List<Object> get props => [examId, answers];
}
