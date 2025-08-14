import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final String id;
  final String title;
  final String subjectId;
  final List<Question> questions;
  final int timeLimit; // in minutes
  final int totalScore;

  const Exam({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.questions,
    required this.timeLimit,
    required this.totalScore,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subjectId,
        questions,
        timeLimit,
        totalScore,
      ];
}

class Question extends Equatable {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final int score;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.score,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        options,
        correctAnswerIndex,
        score,
      ];
}

class ExamResult extends Equatable {
  final String examId;
  final int score;
  final int totalScore;
  final List<QuestionResult> questionResults;
  final DateTime submittedAt;

  const ExamResult({
    required this.examId,
    required this.score,
    required this.totalScore,
    required this.questionResults,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [
        examId,
        score,
        totalScore,
        questionResults,
        submittedAt,
      ];
}

class QuestionResult extends Equatable {
  final String questionId;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;
  final bool isCorrect;
  final int score;

  const QuestionResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
    required this.isCorrect,
    required this.score,
  });

  @override
  List<Object?> get props => [
        questionId,
        selectedAnswerIndex,
        correctAnswerIndex,
        isCorrect,
        score,
      ];
}
