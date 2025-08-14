import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.institute,
    required super.year,
    required super.department,
    super.profileImage,
    required super.subscriptionDaysLeft,
    super.whatsappNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      institute: json['institute'],
      year: json['year'],
      department: json['department'],
      profileImage: json['profile_image'],
      subscriptionDaysLeft: json['subscription_days_left'],
      whatsappNumber: json['whatsapp_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'institute': institute,
      'year': year,
      'department': department,
      'profile_image': profileImage,
      'subscription_days_left': subscriptionDaysLeft,
      'whatsapp_number': whatsappNumber,
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      institute: user.institute,
      year: user.year,
      department: user.department,
      profileImage: user.profileImage,
      subscriptionDaysLeft: user.subscriptionDaysLeft,
      whatsappNumber: user.whatsappNumber,
    );
  }
}
