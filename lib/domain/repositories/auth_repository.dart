import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String instituteId,
    required String academicProgramId,
    String? whatsappNumber,
    String? profileImage,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> saveUser(User user);
  Future<Either<Failure, void>> clearUser();
}
