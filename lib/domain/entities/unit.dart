import 'package:equatable/equatable.dart';

class StudyUnit extends Equatable {
  final int id;
  final String unitTitle;
  final int unitNumber;
  final String description;
  final String? learningObjectives;
  final int estimatedDurationHours;
  final int displayOrder;
  final int subjectId;
  final String subjectName;
  final String subjectCode;
  final int contentCount;

  const StudyUnit({
    required this.id,
    required this.unitTitle,
    required this.unitNumber,
    required this.description,
    this.learningObjectives,
    required this.estimatedDurationHours,
    required this.displayOrder,
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
    required this.contentCount,
  });

  @override
  List<Object?> get props => [
        id,
        unitTitle,
        unitNumber,
        description,
        learningObjectives,
        estimatedDurationHours,
        displayOrder,
        subjectId,
        subjectName,
        subjectCode,
        contentCount,
      ];
}
