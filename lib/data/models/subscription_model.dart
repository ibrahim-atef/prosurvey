import '../../domain/entities/subscription.dart';

class SubscriptionPlanModel extends SubscriptionPlan {
  const SubscriptionPlanModel({
    required super.id,
    required super.name,
    required super.nameArabic,
    super.description,
    required super.price,
    required super.duration,
    required super.features,
    required super.isActive,
    required super.isPopular,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      nameArabic: json['name_arabic'] ?? '',
      description: json['description'],
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? 0,
      features: List<String>.from(json['features'] ?? []),
      isActive: json['is_active'] ?? true,
      isPopular: json['is_popular'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'name_arabic': nameArabic,
      'description': description,
      'price': price,
      'duration': duration,
      'features': features,
      'is_active': isActive,
      'is_popular': isPopular,
    };
  }
}

class UserSubscriptionModel extends UserSubscription {
  const UserSubscriptionModel({
    required super.id,
    required super.userId,
    required super.planId,
    required super.planName,
    required super.startDate,
    required super.endDate,
    required super.amountPaid,
    required super.paymentMethod,
    required super.paymentReference,
    required super.status,
    super.createdAt,
    super.updatedAt,
  });

  factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return UserSubscriptionModel(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      planId: json['plan_id'].toString(),
      planName: json['plan_name'] ?? '',
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      amountPaid: (json['amount_paid'] ?? 0).toDouble(),
      paymentMethod: json['payment_method'] ?? '',
      paymentReference: json['payment_reference'] ?? '',
      status: _parseSubscriptionStatus(json['status']),
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : null,
    );
  }

  static SubscriptionStatus _parseSubscriptionStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'active':
        return SubscriptionStatus.active;
      case 'expired':
        return SubscriptionStatus.expired;
      case 'cancelled':
        return SubscriptionStatus.cancelled;
      case 'pending':
        return SubscriptionStatus.pending;
      default:
        return SubscriptionStatus.active;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan_id': planId,
      'plan_name': planName,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'amount_paid': amountPaid,
      'payment_method': paymentMethod,
      'payment_reference': paymentReference,
      'status': status.name,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
