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
    final userJson = json['data'] != null ? json['data']['user'] ?? json : json;

    return UserModel(
      id: userJson['id']?.toString() ?? '1',
      name: userJson['full_name'] ?? userJson['name'] ?? '',
      email: userJson['email'] ?? '',
      institute: userJson['institute_name'] ?? userJson['institute'] ?? '',
      year: userJson['program_name'] ?? userJson['year'] ?? '',
      department: userJson['role_display_name'] ?? userJson['department'] ?? 'طالب',
      profileImage: userJson['profile_picture_path'], // fixed key
      subscriptionDaysLeft: userJson['days_remaining'] ?? userJson['subscription_days_left'] ?? 0,
      whatsappNumber: userJson['whatsapp_number'] ?? '',
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
