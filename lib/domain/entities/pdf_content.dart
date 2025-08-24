import 'package:equatable/equatable.dart';
import 'base_content.dart';

class PdfContentResponse extends Equatable {
  final List<PdfContentItem> content;
  final dynamic contentTypeInfo; // null in current response
  final Pagination pagination;

  const PdfContentResponse({
    required this.content,
    this.contentTypeInfo,
    required this.pagination,
  });

  @override
  List<Object?> get props => [content, contentTypeInfo, pagination];
}

class PdfContentItem extends Equatable implements BaseContent {
  final int id;
  final String title;
  final String description;
  final String filePath;
  final String fileSizeMb;
  final int? durationMinutes;
  final String? thumbnailPath;
  final int isFree;
  final int displayOrder;
  final int downloadCount;
  final int viewCount;
  final String uploadDate;
  final int contentTypeId;
  final String typeName;
  final int unitId;
  final String unitTitle;
  final int unitNumber;
  final int subjectId;
  final String subjectName;
  final String subjectCode;

  const PdfContentItem({
    required this.id,
    required this.title,
    required this.description,
    required this.filePath,
    required this.fileSizeMb,
    this.durationMinutes,
    this.thumbnailPath,
    required this.isFree,
    required this.displayOrder,
    required this.downloadCount,
    required this.viewCount,
    required this.uploadDate,
    required this.contentTypeId,
    required this.typeName,
    required this.unitId,
    required this.unitTitle,
    required this.unitNumber,
    required this.subjectId,
    required this.subjectName,
    required this.subjectCode,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        filePath,
        fileSizeMb,
        durationMinutes,
        thumbnailPath,
        isFree,
        displayOrder,
        downloadCount,
        viewCount,
        uploadDate,
        contentTypeId,
        typeName,
        unitId,
        unitTitle,
        unitNumber,
        subjectId,
        subjectName,
        subjectCode,
      ];
}

class Pagination extends Equatable {
  final int total;
  final int limit;
  final int offset;
  final bool hasMore;

  const Pagination({
    required this.total,
    required this.limit,
    required this.offset,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [total, limit, offset, hasMore];
}
