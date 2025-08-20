import '../../domain/entities/institute.dart';

import '../../domain/entities/institute.dart';

class InstituteModel extends Institute {
  const InstituteModel({
    required super.id,
    required super.name,
    required super.location,
    required super.code,
    super.contactNumbers,
    required super.createdAt,
    required super.updatedAt,
    required super.programsCount,
  });

  factory InstituteModel.fromJson(Map<String, dynamic> json) {
    return InstituteModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      code: json['code']?.toString() ?? '',
      contactNumbers: json['contact_numbers'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      programsCount: json['programs_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'code': code,
      'contact_numbers': contactNumbers,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'programs_count': programsCount,
    };
  }
}

class AcademicProgramModel extends AcademicProgram {
  const AcademicProgramModel({
    required super.id,
    required super.name,
    required super.nameArabic,
    required super.instituteId,
    required super.programType,
    super.description,
    required super.duration,
    required super.isActive,
  });

  factory AcademicProgramModel.fromJson(Map<String, dynamic> json) {
    return AcademicProgramModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      nameArabic: json['name_arabic'] ?? '',
      instituteId: json['institute_id'].toString(),
      programType: json['program_type'] ?? '',
      description: json['description'],
      duration: json['duration'] ?? 0,
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_arabic': nameArabic,
      'institute_id': instituteId,
      'program_type': programType,
      'description': description,
      'duration': duration,
      'is_active': isActive,
    };
  }
}
