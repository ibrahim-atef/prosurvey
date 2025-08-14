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
      whatsappNumber: params.whatsappNumber,
      institute: params.institute,
      year: params.year,
      profileImage: params.profileImage,
    );
  }
}

class RegisterParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String whatsappNumber;
  final String institute;
  final String year;
  final String? profileImage;

  const RegisterParams({
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
