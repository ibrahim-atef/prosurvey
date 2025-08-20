import '../../domain/entities/course_content.dart';

class CourseContentModel extends CourseContent {
  const CourseContentModel({
    required super.id,
    required super.title,
    required super.subjectId,
    required super.type,
    required super.url,
    super.thumbnail,
    super.description,
    super.duration,
    super.fileSize,
  });

  factory CourseContentModel.fromJson(Map<String, dynamic> json) {
    return CourseContentModel(
      id: json['id']?.toString() ?? '1',
      title: json['title'] ?? '',
      subjectId: json['subject_id']?.toString() ?? '1',
      type: ContentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type_name'] || e.toString().split('.').last == json['type'],
        orElse: () => ContentType.video,
      ),
      url: json['url'] ?? '',
      thumbnail: json['thumbnail'],
      description: json['description'] ?? '',
      duration: json['duration_minutes'] != null ? json['duration_minutes'] * 60 : json['duration'],
      fileSize: json['file_size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subject_id': subjectId,
      'type': type.toString().split('.').last,
      'url': url,
      'thumbnail': thumbnail,
      'description': description,
      'duration': duration,
      'file_size': fileSize,
    };
  }
}
