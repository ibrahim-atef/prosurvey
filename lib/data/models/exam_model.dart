import '../../domain/entities/exam.dart';

class ExamModel extends Exam {
  const ExamModel({
    required super.id,
    required super.title,
    required super.subjectId,
    required super.questions,
    required super.timeLimit,
    required super.totalScore,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      title: json['title'],
      subjectId: json['subject_id'],
      questions: (json['questions'] as List)
          .map((question) => QuestionModel.fromJson(question))
          .toList(),
      timeLimit: json['time_limit'],
      totalScore: json['total_score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject_id': subjectId,
      'questions': questions.map((q) => (q as QuestionModel).toJson()).toList(),
      'time_limit': timeLimit,
      'total_score': totalScore,
    };
  }
}

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.text,
    required super.options,
    required super.correctAnswerIndex,
    required super.score,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      text: json['text'],
      options: List<String>.from(json['options']),
      correctAnswerIndex: json['correct_answer_index'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options,
      'correct_answer_index': correctAnswerIndex,
      'score': score,
    };
  }
}

class ExamResultModel extends ExamResult {
  const ExamResultModel({
    required super.examId,
    required super.score,
    required super.totalScore,
    required super.questionResults,
    required super.submittedAt,
  });

  factory ExamResultModel.fromJson(Map<String, dynamic> json) {
    return ExamResultModel(
      examId: json['exam_id'],
      score: json['score'],
      totalScore: json['total_score'],
      questionResults: (json['question_results'] as List)
          .map((result) => QuestionResultModel.fromJson(result))
          .toList(),
      submittedAt: DateTime.parse(json['submitted_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exam_id': examId,
      'score': score,
      'total_score': totalScore,
      'question_results': questionResults.map((r) => (r as QuestionResultModel).toJson()).toList(),
      'submitted_at': submittedAt.toIso8601String(),
    };
  }
}

class QuestionResultModel extends QuestionResult {
  const QuestionResultModel({
    required super.questionId,
    required super.selectedAnswerIndex,
    required super.correctAnswerIndex,
    required super.isCorrect,
    required super.score,
  });

  factory QuestionResultModel.fromJson(Map<String, dynamic> json) {
    return QuestionResultModel(
      questionId: json['question_id'],
      selectedAnswerIndex: json['selected_answer_index'],
      correctAnswerIndex: json['correct_answer_index'],
      isCorrect: json['is_correct'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'selected_answer_index': selectedAnswerIndex,
      'correct_answer_index': correctAnswerIndex,
      'is_correct': isCorrect,
      'score': score,
    };
  }
}
