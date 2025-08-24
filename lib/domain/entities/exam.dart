import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  final int id;
  final String examTitle;
  final String description;
  final int totalQuestions;
  final int timeLimitMinutes;
  final int passingScore;

  const Exam({
    required this.id,
    required this.examTitle,
    required this.description,
    required this.totalQuestions,
    required this.timeLimitMinutes,
    required this.passingScore,
  });

  @override
  List<Object?> get props => [
        id,
        examTitle,
        description,
        totalQuestions,
        timeLimitMinutes,
        passingScore,
      ];
}

class ExamInfo extends Equatable {
  final int id;
  final String title;
  final String description;
  final String subjectName;
  final int totalQuestions;
  final int timeLimitMinutes;
  final int passingPercentage;
  final int totalQuestionsCount;
  final ExamInstructions instructions;

  const ExamInfo({
    required this.id,
    required this.title,
    required this.description,
    required this.subjectName,
    required this.totalQuestions,
    required this.timeLimitMinutes,
    required this.passingPercentage,
    required this.totalQuestionsCount,
    required this.instructions,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        subjectName,
        totalQuestions,
        timeLimitMinutes,
        passingPercentage,
        totalQuestionsCount,
        instructions,
      ];
}

class ExamInstructions extends Equatable {
  final String readAllQuestionsCarefully;
  final String manageYourTime;
  final String answerAllQuestions;
  final String checkYourAnswers;

  const ExamInstructions({
    required this.readAllQuestionsCarefully,
    required this.manageYourTime,
    required this.answerAllQuestions,
    required this.checkYourAnswers,
  });

  @override
  List<Object?> get props => [
        readAllQuestionsCarefully,
        manageYourTime,
        answerAllQuestions,
        checkYourAnswers,
      ];
}

class Question extends Equatable {
  final int id;
  final String questionText;
  final String questionType;
  final int marks;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.marks,
    required this.options,
  });

  @override
  List<Object?> get props => [
        id,
        questionText,
        questionType,
        marks,
        options,
      ];
}

class QuestionOption extends Equatable {
  final int id;
  final String text;
  final int optionOrder;

  const QuestionOption({
    required this.id,
    required this.text,
    required this.optionOrder,
  });

  @override
  List<Object?> get props => [id, text, optionOrder];
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
