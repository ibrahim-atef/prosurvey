import '../../domain/entities/unit_content.dart';

class UnitContentModel extends UnitContent {
  const UnitContentModel({
    required super.unit,
    required super.content,
    required super.contentTypeBreakdown,
    required super.pagination,
  });

  factory UnitContentModel.fromJson(Map<String, dynamic> json) {
    return UnitContentModel(
      unit: UnitInfoModel.fromJson(json['unit'] as Map<String, dynamic>),
      content: (json['content'] as List<dynamic>)
          .map((item) => ContentItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      contentTypeBreakdown: (json['content_type_breakdown'] as List<dynamic>)
          .map((item) => ContentTypeBreakdownModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}

class UnitInfoModel extends UnitInfo {
  const UnitInfoModel({
    required super.id,
    required super.unitTitle,
    required super.unitNumber,
    required super.description,
    super.learningObjectives,
    required super.estimatedDurationHours,
    required super.subjectId,
    required super.subjectName,
    required super.subjectCode,
  });

  factory UnitInfoModel.fromJson(Map<String, dynamic> json) {
    return UnitInfoModel(
      id: json['id'] as int? ?? 0,
      unitTitle: json['unit_title'] as String? ?? '',
      unitNumber: json['unit_number'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      learningObjectives: json['learning_objectives'] as String?,
      estimatedDurationHours: json['estimated_duration_hours'] as int? ?? 0,
      subjectId: json['subject_id'] as int? ?? 0,
      subjectName: json['subject_name'] as String? ?? '',
      subjectCode: json['subject_code'] as String? ?? '',
    );
  }
}

class ContentItemModel extends ContentItem {
  const ContentItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.filePath,
    required super.fileSizeMb,
    super.durationMinutes,
    super.thumbnailPath,
    required super.isFree,
    required super.displayOrder,
    required super.downloadCount,
    required super.viewCount,
    required super.uploadDate,
    required super.contentTypeId,
    required super.typeName,
  });

  factory ContentItemModel.fromJson(Map<String, dynamic> json) {
    return ContentItemModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      filePath: json['file_path'] as String? ?? '',
      fileSizeMb: json['file_size_mb'] as String? ?? '0',
      durationMinutes: json['duration_minutes'] as int?,
      thumbnailPath: json['thumbnail_path'] as String?,
      isFree: json['is_free'] as int? ?? 0,
      displayOrder: json['display_order'] as int? ?? 0,
      downloadCount: json['download_count'] as int? ?? 0,
      viewCount: json['view_count'] as int? ?? 0,
      uploadDate: json['upload_date'] as String? ?? '',
      contentTypeId: json['content_type_id'] as int? ?? 0,
      typeName: json['type_name'] as String? ?? '',
    );
  }
}

class ContentTypeBreakdownModel extends ContentTypeBreakdown {
  const ContentTypeBreakdownModel({
    required super.id,
    required super.typeName,
    required super.count,
  });

  factory ContentTypeBreakdownModel.fromJson(Map<String, dynamic> json) {
    return ContentTypeBreakdownModel(
      id: json['id'] as int? ?? 0,
      typeName: json['type_name'] as String? ?? '',
      count: json['count'] as int? ?? 0,
    );
  }
}

class PaginationModel extends Pagination {
  const PaginationModel({
    required super.total,
    required super.limit,
    required super.offset,
    required super.hasMore,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      total: json['total'] as int? ?? 0,
      limit: json['limit'] as int? ?? 20,
      offset: json['offset'] as int? ?? 0,
      hasMore: json['has_more'] as bool? ?? false,
    );
  }
}
