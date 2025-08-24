import '../../domain/entities/exam.dart';

class ExamModel extends Exam {
  const ExamModel({
    required super.id,
    required super.examTitle,
    required super.description,
    required super.totalQuestions,
    required super.timeLimitMinutes,
    required super.passingScore,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'],
      examTitle: json['exam_title'],
      description: json['description'],
      totalQuestions: json['total_questions'],
      timeLimitMinutes: json['time_limit_minutes'],
      passingScore: json['passing_score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exam_title': examTitle,
      'description': description,
      'total_questions': totalQuestions,
      'time_limit_minutes': timeLimitMinutes,
      'passing_score': passingScore,
    };
  }
}

class ExamInfoModel extends ExamInfo {
  const ExamInfoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.subjectName,
    required super.totalQuestions,
    required super.timeLimitMinutes,
    required super.passingPercentage,
    required super.totalQuestionsCount,
    required super.instructions,
  });

  factory ExamInfoModel.fromJson(Map<String, dynamic> json) {
    return ExamInfoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      subjectName: json['subject_name'],
      totalQuestions: json['total_questions'],
      timeLimitMinutes: json['time_limit_minutes'],
      passingPercentage: json['passing_percentage'],
      totalQuestionsCount: json['total_questions_count'],
      instructions: ExamInstructionsModel.fromJson(json['instructions']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'subject_name': subjectName,
      'total_questions': totalQuestions,
      'time_limit_minutes': timeLimitMinutes,
      'passing_percentage': passingPercentage,
      'total_questions_count': totalQuestionsCount,
      'instructions': (instructions as ExamInstructionsModel).toJson(),
    };
  }
}

class ExamInstructionsModel extends ExamInstructions {
  const ExamInstructionsModel({
    required super.readAllQuestionsCarefully,
    required super.manageYourTime,
    required super.answerAllQuestions,
    required super.checkYourAnswers,
  });

  factory ExamInstructionsModel.fromJson(Map<String, dynamic> json) {
    return ExamInstructionsModel(
      readAllQuestionsCarefully: json['read_all_questions_carefully'],
      manageYourTime: json['manage_your_time'],
      answerAllQuestions: json['answer_all_questions'],
      checkYourAnswers: json['check_your_answers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'read_all_questions_carefully': readAllQuestionsCarefully,
      'manage_your_time': manageYourTime,
      'answer_all_questions': answerAllQuestions,
      'check_your_answers': checkYourAnswers,
    };
  }
}

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.questionText,
    required super.questionType,
    required super.marks,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      questionText: json['question_text'],
      questionType: json['question_type'],
      marks: json['marks'],
      options: (json['options'] as List)
          .map((option) => QuestionOptionModel.fromJson(option))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_text': questionText,
      'question_type': questionType,
      'marks': marks,
      'options': options.map((o) => (o as QuestionOptionModel).toJson()).toList(),
    };
  }
}

class QuestionOptionModel extends QuestionOption {
  const QuestionOptionModel({
    required super.id,
    required super.text,
    required super.optionOrder,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionModel(
      id: json['id'],
      text: json['text'],
      optionOrder: json['option_order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'option_order': optionOrder,
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
