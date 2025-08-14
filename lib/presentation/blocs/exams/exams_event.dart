part of 'exams_bloc.dart';

abstract class ExamsEvent extends Equatable {
  const ExamsEvent();

  @override
  List<Object?> get props => [];
}

class LoadExams extends ExamsEvent {
  final String subjectId;

  const LoadExams({
    required this.subjectId,
  });

  @override
  List<Object> get props => [subjectId];
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
