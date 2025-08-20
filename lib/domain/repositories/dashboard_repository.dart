import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';

abstract class DashboardRepository {
  Future<Either<Failure, Map<String, dynamic>>> getDashboardData();
}
