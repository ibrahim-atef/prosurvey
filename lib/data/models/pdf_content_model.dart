import '../../domain/entities/pdf_content.dart';

class PdfContentResponseModel extends PdfContentResponse {
  const PdfContentResponseModel({
    required super.content,
    super.contentTypeInfo,
    required super.pagination,
  });

  factory PdfContentResponseModel.fromJson(Map<String, dynamic> json) {
    return PdfContentResponseModel(
      content: (json['content'] as List<dynamic>)
          .map((item) => PdfContentItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      contentTypeInfo: json['content_type_info'],
      pagination: PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }
}

class PdfContentItemModel extends PdfContentItem {
  const PdfContentItemModel({
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
    required super.unitId,
    required super.unitTitle,
    required super.unitNumber,
    required super.subjectId,
    required super.subjectName,
    required super.subjectCode,
  });

  factory PdfContentItemModel.fromJson(Map<String, dynamic> json) {
    return PdfContentItemModel(
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
      unitId: json['unit_id'] as int? ?? 0,
      unitTitle: json['unit_title'] as String? ?? '',
      unitNumber: json['unit_number'] as int? ?? 0,
      subjectId: json['subject_id'] as int? ?? 0,
      subjectName: json['subject_name'] as String? ?? '',
      subjectCode: json['subject_code'] as String? ?? '',
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


