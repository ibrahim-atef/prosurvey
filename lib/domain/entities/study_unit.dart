import 'package:equatable/equatable.dart';
import 'course_content.dart';

class StudyUnit extends Equatable {
  final String id;
  final String title;
  final String titleArabic;
  final String subjectId;
  final String? description;
  final int order;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const StudyUnit({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.subjectId,
    this.description,
    required this.order,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        titleArabic,
        subjectId,
        description,
        order,
        isActive,
        createdAt,
        updatedAt,
      ];
}

class EducationalContent extends Equatable {
  final String id;
  final String title;
  final String titleArabic;
  final String unitId;
  final ContentType type;
  final String url;
  final String? thumbnail;
  final String? description;
  final int? duration; // for videos in seconds
  final int? fileSize; // for files in bytes
  final bool isFree;
  final int viewCount;
  final double? rating;
  final int? ratingCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const EducationalContent({
    required this.id,
    required this.title,
    required this.titleArabic,
    required this.unitId,
    required this.type,
    required this.url,
    this.thumbnail,
    this.description,
    this.duration,
    this.fileSize,
    required this.isFree,
    required this.viewCount,
    this.rating,
    this.ratingCount,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        titleArabic,
        unitId,
        type,
        url,
        thumbnail,
        description,
        duration,
        fileSize,
        isFree,
        viewCount,
        rating,
        ratingCount,
        createdAt,
        updatedAt,
      ];
}
