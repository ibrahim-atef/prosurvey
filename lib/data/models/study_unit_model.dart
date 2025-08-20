import '../../domain/entities/study_unit.dart';
import '../../domain/entities/course_content.dart';

class StudyUnitModel extends StudyUnit {
  const StudyUnitModel({
    required super.id,
    required super.title,
    required super.titleArabic,
    required super.subjectId,
    super.description,
    required super.order,
    required super.isActive,
    super.createdAt,
    super.updatedAt,
  });

  factory StudyUnitModel.fromJson(Map<String, dynamic> json) {
    return StudyUnitModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      titleArabic: json['title_arabic'] ?? '',
      subjectId: json['subject_id'].toString(),
      description: json['description'],
      order: json['order'] ?? 0,
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_arabic': titleArabic,
      'subject_id': subjectId,
      'description': description,
      'order': order,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class EducationalContentModel extends EducationalContent {
  const EducationalContentModel({
    required super.id,
    required super.title,
    required super.titleArabic,
    required super.unitId,
    required super.type,
    required super.url,
    super.thumbnail,
    super.description,
    super.duration,
    super.fileSize,
    required super.isFree,
    required super.viewCount,
    super.rating,
    super.ratingCount,
    super.createdAt,
    super.updatedAt,
  });

  factory EducationalContentModel.fromJson(Map<String, dynamic> json) {
    return EducationalContentModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      titleArabic: json['title_arabic'] ?? '',
      unitId: json['unit_id'].toString(),
      type: _parseContentType(json['type']),
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'],
      description: json['description'],
      duration: json['duration'],
      fileSize: json['file_size'],
      isFree: json['is_free'] ?? false,
      viewCount: json['view_count'] ?? 0,
      rating: json['rating']?.toDouble(),
      ratingCount: json['rating_count'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  static ContentType _parseContentType(String? type) {
    switch (type?.toLowerCase()) {
      case 'video':
        return ContentType.video;
      case 'pdf':
        return ContentType.pdf;
      case 'sheet':
        return ContentType.sheet;
      default:
        return ContentType.video;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_arabic': titleArabic,
      'unit_id': unitId,
      'type': type.name,
      'url': url,
      'thumbnail': thumbnail,
      'description': description,
      'duration': duration,
      'file_size': fileSize,
      'is_free': isFree,
      'view_count': viewCount,
      'rating': rating,
      'rating_count': ratingCount,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
