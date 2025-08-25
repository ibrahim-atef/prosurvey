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
    print('🔍 SubjectModel.fromJson: $json');
    final subject = SubjectModel(
      id: json['id'] as int? ?? 1,
      name: json['subject_code'] ?? json['subject_name'] ?? json['name'] ?? '',
      nameArabic: json['subject_name'] ?? json['name_arabic'] ?? '',
      icon: json['icon'] ?? 'book',
      videoCount: json['video_count'] ?? 0,
      pdfCount: json['pdf_count'] ?? 0,
      examCount: json['exam_count'] ?? 0,
      institute: json['academic_program_name'] ?? json['institute'] ?? 'المطرية',
      year: json['academic_program_name'] ?? json['program_name'] ?? json['year'] ?? 'سنة أولى',
    );
    print('✅ Created Subject: ${subject.nameArabic} (${subject.name})');
    return subject;
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
