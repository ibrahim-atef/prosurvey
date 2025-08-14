import '../../domain/entities/subject.dart';

class SubjectModel extends Subject {
  const SubjectModel({
    required super.id,
    required super.name,
    required super.nameArabic,
    required super.icon,
    required super.videoCount,
    required super.pdfCount,
    required super.examCount,
    required super.institute,
    required super.year,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name'],
      nameArabic: json['name_arabic'],
      icon: json['icon'],
      videoCount: json['video_count'],
      pdfCount: json['pdf_count'],
      examCount: json['exam_count'],
      institute: json['institute'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_arabic': nameArabic,
      'icon': icon,
      'video_count': videoCount,
      'pdf_count': pdfCount,
      'exam_count': examCount,
      'institute': institute,
      'year': year,
    };
  }
}
