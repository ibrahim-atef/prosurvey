import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../../../core/error/failures.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      instituteId: params.instituteId,
      academicProgramId: params.academicProgramId,
      whatsappNumber: params.whatsappNumber,
      profileImage: params.profileImage,
    );
  }
}

class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String instituteId;
  final String academicProgramId;
  final String? whatsappNumber;
  final String? profileImage;

  const RegisterParams({
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
