import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String id;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final String contentId;
  final String? subjectId;
  final int rating;
  final String? reviewText;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Review({
    required this.id,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.contentId,
    this.subjectId,
    required this.rating,
    this.reviewText,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        userName,
        userProfileImage,
        contentId,
        subjectId,
        rating,
        reviewText,
        createdAt,
        updatedAt,
      ];
}

class ReviewSummary extends Equatable {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution; // rating -> count

  const ReviewSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });

  @override
  List<Object?> get props => [
        averageRating,
        totalReviews,
        ratingDistribution,
      ];
}
