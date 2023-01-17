import 'package:it_project/src/utils/remote/model/order_notification/m_notification.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/remote/services/notification/notification_service.dart';

abstract class NotificationRepository {
  NotificationRepository(this.notificationService);
  final NotificationService notificationService;

  Future<FResult<List<MNotification>>> getNotifications(
      {required int currentPage});
  Future<FResult<String>> updateNotification(
      {required String notificationId, required bool status});
}
