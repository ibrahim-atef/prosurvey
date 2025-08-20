import 'package:equatable/equatable.dart';

class Subject extends Equatable {
  final int id;
  final String name;
  final String nameArabic;
  final String icon;
  final int videoCount;
  final int pdfCount;
  final int examCount;
  final String institute;
  final String year;

  const Subject({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.icon,
    required this.videoCount,
    required this.pdfCount,
    required this.examCount,
    required this.institute,
    required this.year,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameArabic,
        icon,
        videoCount,
        pdfCount,
        examCount,
        institute,
        year,
      ];
}
