import 'package:dartz/dartz.dart';
import '../entities/progress.dart';
import '../../core/error/failures.dart';

abstract class ProgressRepository {
  Future<Either<Failure, List<ProgressSummary>>> getUserProgress(String userId);
  Future<Either<Failure, ProgressSummary>> getSubjectProgress(String userId, String subjectId);
  Future<Either<Failure, void>> updateProgress({
    required String subjectId,
    String? unitId,
    String? contentId,
    required ProgressType progressType,
    required double completionPercentage,
    String? notes,
  });
}
