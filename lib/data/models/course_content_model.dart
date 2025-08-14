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
      id: json['id'],
      title: json['title'],
      subjectId: json['subject_id'],
      type: ContentType.values.firstWhere(
        (e) => e.toString().split('.').last == json['type'],
      ),
      url: json['url'],
      thumbnail: json['thumbnail'],
      description: json['description'],
      duration: json['duration'],
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
