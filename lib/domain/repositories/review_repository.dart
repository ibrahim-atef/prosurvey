import 'package:dartz/dartz.dart';
import '../entities/review.dart';
import '../../core/error/failures.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<Review>>> getContentReviews(String contentId);
  Future<Either<Failure, List<Review>>> getSubjectReviews(String subjectId);
  Future<Either<Failure, Review>> submitReview({
    required String contentId,
    required int rating,
    String? reviewText,
  });
  Future<Either<Failure, ReviewSummary>> getReviewSummary(String contentId);
}
