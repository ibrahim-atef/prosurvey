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
  final String passwordConfirmation;
  final String instituteId;
  final String academicProgramId;
  final String? whatsappNumber;
  final String? profileImage;

  const RegisterRequested({
    required this.fullName,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.instituteId,
    required this.academicProgramId,
    this.whatsappNumber,
    this.profileImage,
  });

  @override
  List<Object?> get props => [
        fullName,
        email,
        password,
        passwordConfirmation,
        instituteId,
        academicProgramId,
        whatsappNumber,
        profileImage,
      ];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}
