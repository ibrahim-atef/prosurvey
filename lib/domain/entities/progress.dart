import 'package:equatable/equatable.dart';

class UserProgress extends Equatable {
  final String id;
  final String userId;
  final String subjectId;
  final String? unitId;
  final String? contentId;
  final ProgressType type;
  final double completionPercentage;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserProgress({
    required this.id,
    required this.userId,
    required this.subjectId,
    this.unitId,
    this.contentId,
    required this.type,
    required this.completionPercentage,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        subjectId,
        unitId,
        contentId,
        type,
        completionPercentage,
        notes,
        createdAt,
        updatedAt,
      ];
}

enum ProgressType {
  contentView,
  examCompletion,
  unitCompletion,
  subjectCompletion,
}

class ProgressSummary extends Equatable {
  final String subjectId;
  final String subjectName;
  final double overallProgress;
  final int completedUnits;
  final int totalUnits;
  final int completedContent;
  final int totalContent;
  final int completedExams;
  final int totalExams;
  final double averageExamScore;

  const ProgressSummary({
    required this.subjectId,
    required this.subjectName,
    required this.overallProgress,
    required this.completedUnits,
    required this.totalUnits,
    required this.completedContent,
    required this.totalContent,
    required this.completedExams,
    required this.totalExams,
    required this.averageExamScore,
  });

  @override
  List<Object?> get props => [
        subjectId,
        subjectName,
        overallProgress,
        completedUnits,
        totalUnits,
        completedContent,
        totalContent,
        completedExams,
        totalExams,
        averageExamScore,
      ];
}
