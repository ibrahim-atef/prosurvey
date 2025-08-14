import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../../core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register({
    required String fullName,
    required String email,
    required String password,
    required String whatsappNumber,
    required String institute,
    required String year,
    String? profileImage,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCurrentUser();
  Future<Either<Failure, void>> saveUser(User user);
  Future<Either<Failure, void>> clearUser();
}
