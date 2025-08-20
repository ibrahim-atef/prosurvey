import 'package:dartz/dartz.dart';
import '../entities/notification.dart';
import '../../core/error/failures.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getUserNotifications({
    bool? isRead,
  });
  Future<Either<Failure, void>> markNotificationAsRead(String notificationId);
  Future<Either<Failure, void>> markAllNotificationsAsRead();
  Future<Either<Failure, int>> getUnreadNotificationCount();
}
