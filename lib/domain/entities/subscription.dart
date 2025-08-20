import 'package:equatable/equatable.dart';

class SubscriptionPlan extends Equatable {
  final String id;
  final String name;
  final String nameArabic;
  final String? description;
  final double price;
  final int duration; // in days
  final List<String> features;
  final bool isActive;
  final bool isPopular;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.nameArabic,
    this.description,
    required this.price,
    required this.duration,
    required this.features,
    required this.isActive,
    required this.isPopular,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        nameArabic,
        description,
        price,
        duration,
        features,
        isActive,
        isPopular,
      ];
}

class UserSubscription extends Equatable {
  final String id;
  final String userId;
  final String planId;
  final String planName;
  final DateTime startDate;
  final DateTime endDate;
  final double amountPaid;
  final String paymentMethod;
  final String paymentReference;
  final SubscriptionStatus status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserSubscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.planName,
    required this.startDate,
    required this.endDate,
    required this.amountPaid,
    required this.paymentMethod,
    required this.paymentReference,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  bool get isActive => status == SubscriptionStatus.active;
  bool get isExpired => DateTime.now().isAfter(endDate);
  int get daysLeft => endDate.difference(DateTime.now()).inDays;

  @override
  List<Object?> get props => [
        id,
        userId,
        planId,
        planName,
        startDate,
        endDate,
        amountPaid,
        paymentMethod,
        paymentReference,
        status,
        createdAt,
        updatedAt,
      ];
}

enum SubscriptionStatus {
  active,
  expired,
  cancelled,
  pending,
}
