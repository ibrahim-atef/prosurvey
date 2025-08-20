import 'package:equatable/equatable.dart';
import 'unit.dart';

class UnitContent extends Equatable {
  final StudyUnit unit;
  final List<ContentItem> content;
  final List<ContentTypeBreakdown> contentTypeBreakdown;
  final Pagination pagination;

  const UnitContent({
    required this.unit,
    required this.content,
    required this.contentTypeBreakdown,
    required this.pagination,
  });

  @override
  List<Object?> get props => [
        unit,
        content,
        contentTypeBreakdown,
        pagination,
      ];
}

class ContentItem extends Equatable {
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

  const ContentItem({
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
      ];
}

class ContentTypeBreakdown extends Equatable {
  final int id;
  final String typeName;
  final int count;

  const ContentTypeBreakdown({
    required this.id,
    required this.typeName,
    required this.count,
  });

  @override
  List<Object?> get props => [id, typeName, count];
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
