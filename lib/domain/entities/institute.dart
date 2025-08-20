import 'package:equatable/equatable.dart';
class Institute extends Equatable {
  final String id;
  final String name;
  final String location;
  final String code;
  final String? contactNumbers;
  final String createdAt;
  final String updatedAt;
  final int programsCount;

  const Institute({
    required this.id,
    required this.name,
    required this.location,
    required this.code,
    this.contactNumbers,
    required this.createdAt,
    required this.updatedAt,
    required this.programsCount,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    code,
    contactNumbers,
    createdAt,
    updatedAt,
    programsCount,
  ];
}


class AcademicProgram extends Equatable {
  final String id;
  final String name;
  final String nameArabic;
  final String instituteId;
  final String programType;
  final String? description;
  final int duration; // in months
  final bool isActive;

  const AcademicProgram({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.instituteId,
    required this.programType,
    this.description,
    required this.duration,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameArabic,
        instituteId,
        programType,
        description,
        duration,
        isActive,
      ];
}
