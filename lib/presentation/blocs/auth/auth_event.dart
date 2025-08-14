part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  final String whatsappNumber;
  final String institute;
  final String year;
  final String? profileImage;

  const RegisterRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.whatsappNumber,
    required this.institute,
    required this.year,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        whatsappNumber,
        institute,
        year,
        profileImage,
      ];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
