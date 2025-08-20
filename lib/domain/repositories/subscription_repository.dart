import 'package:dartz/dartz.dart';
import '../entities/subscription.dart';
import '../../core/error/failures.dart';

abstract class SubscriptionRepository {
  Future<Either<Failure, List<SubscriptionPlan>>> getSubscriptionPlans();
  Future<Either<Failure, UserSubscription>> getUserSubscription(String userId);
  Future<Either<Failure, UserSubscription>> createSubscription({
    required String planId,
    required String subscriptionType,
    required double amountPaid,
    required String paymentMethod,
    required String paymentReference,
  });
  Future<Either<Failure, List<UserSubscription>>> getSubscriptionHistory(String userId);
}
