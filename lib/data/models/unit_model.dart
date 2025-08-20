import '../../domain/entities/unit.dart';

class UnitModel extends StudyUnit {
  const UnitModel({
    required super.id,
    required super.unitTitle,
    required super.unitNumber,
    required super.description,
    super.learningObjectives,
    required super.estimatedDurationHours,
    required super.displayOrder,
    required super.subjectId,
    required super.subjectName,
    required super.subjectCode,
    required super.contentCount,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int? ?? 0,
      unitTitle: json['unit_title'] as String? ?? '',
      unitNumber: json['unit_number'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      learningObjectives: json['learning_objectives'] as String?,
      estimatedDurationHours: json['estimated_duration_hours'] as int? ?? 0,
      displayOrder: json['display_order'] as int? ?? 0,
      subjectId: json['subject_id'] as int? ?? 0,
      subjectName: json['subject_name'] as String? ?? '',
      subjectCode: json['subject_code'] as String? ?? '',
      contentCount: json['content_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'unit_title': unitTitle,
      'unit_number': unitNumber,
      'description': description,
      'learning_objectives': learningObjectives,
      'estimated_duration_hours': estimatedDurationHours,
      'display_order': displayOrder,
      'subject_id': subjectId,
      'subject_name': subjectName,
      'subject_code': subjectCode,
      'content_count': contentCount,
    };
  }
}
