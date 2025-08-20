import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String institute;
  final String year;
  final String department;
  final String? instituteId;
  final String? academicProgramId;
  final String? profileImage;
  final int subscriptionDaysLeft;
  final String? whatsappNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.institute,
    required this.year,
    required this.department,
    this.instituteId,
    this.academicProgramId,
    this.profileImage,
    required this.subscriptionDaysLeft,
    this.whatsappNumber,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        institute,
        year,
        department,
        instituteId,
        academicProgramId,
        profileImage,
        subscriptionDaysLeft,
        whatsappNumber,
      ];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? institute,
    String? year,
    String? department,
    String? profileImage,
    int? subscriptionDaysLeft,
    String? whatsappNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      institute: institute ?? this.institute,
      year: year ?? this.year,
      department: department ?? this.department,
      profileImage: profileImage ?? this.profileImage,
      subscriptionDaysLeft: subscriptionDaysLeft ?? this.subscriptionDaysLeft,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
    );
  }
}
