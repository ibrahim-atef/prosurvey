import 'package:equatable/equatable.dart';

class CourseContent extends Equatable {
  final String id;
  final String title;
  final String subjectId;
  final ContentType type;
  final String url;
  final String? thumbnail;
  final String? description;
  final int? duration; // for videos in seconds
  final int? fileSize; // for files in bytes

  const CourseContent({
    required this.id,
    required this.title,
    required this.subjectId,
    required this.type,
    required this.url,
    this.thumbnail,
    this.description,
    this.duration,
    this.fileSize,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subjectId,
        type,
        url,
        thumbnail,
        description,
        duration,
        fileSize,
      ];
}

enum ContentType {
  video,
  pdf,
  sheet,
}
