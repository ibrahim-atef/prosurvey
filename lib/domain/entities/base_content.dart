import 'package:equatable/equatable.dart';

abstract class BaseContent extends Equatable {
  int get id;
  String get title;
  String get description;
  String get filePath;
  String get fileSizeMb;
  int? get durationMinutes;
  String? get thumbnailPath;
  int get isFree;
  int get displayOrder;
  int get downloadCount;
  int get viewCount;
  String get uploadDate;
  int get contentTypeId;
  String get typeName;
}


