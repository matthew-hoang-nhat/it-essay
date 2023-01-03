import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/utils/remote/model/order_notification/order_notification.dart';
import 'package:logger/logger.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();
  final _settingAndroid =
      const AndroidInitializationSettings('@mipmap/launcher_icon');
  late final InitializationSettings _setting;

  NotificationManager() {
    initPlugin();
  }

  Future<void> initPlugin() async {
    _setting = InitializationSettings(
      android: _settingAndroid,
    );
    await notificationPlugin.initialize(
      _setting,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final String? orderId = response.payload;
        GoRouter.of(navigatorKey.currentContext!).push(
            '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$orderId');
      },
    );
  }

  getCurrentNotificationAndBackgroundTapNotification() async {
    final NotificationAppLaunchDetails? detail =
        await notificationPlugin.getNotificationAppLaunchDetails();

    Logger().i(['detail:', detail]);

    // if (detail != null && detail.didNotificationLaunchApp) {
    if (detail?.notificationResponse != null) {
      final String? orderId = detail?.notificationResponse!.payload;
      Logger().i(orderId);
      GoRouter.of(navigatorKey.currentContext!).push(
          '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$orderId');
    }
  }

  // @pragma('vm:entry-point')
  // static void notificationTapBackground(
  //     NotificationResponse notificationResponse) {
  //   Logger().i('Background Notification');
  //   final String? orderId = notificationResponse.payload;
  //   GoRouter.of(navigatorKey.currentContext!).push(
  //       '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$orderId');
  // }

  final Map<String, int> _notificationCount = {};

  pushOrderNotification({required OrderNotification orderNotification}) async {
    // if (orderNotification == null) {
    //   final response = {
    //     "title": "The order confirmation",
    //     "content": "The seller confirmed your order",
    // "type": {"type": "order", "orderId": "63abc03a87290075d41c895b"}
    //   };

    //   orderNotification = OrderNotification.fromJson(response);
    // }

    final isAcceptOrder = orderNotification.typeObject['type'] == 'order';
    String title = 'Tên thông báo';
    String body = 'Nội dung thông báo';
    if (isAcceptOrder) {
      title = 'Đơn hàng đã được xác nhận';
      body =
          'Đơn hàng mã ${orderNotification.typeObject['orderId'] ?? ''} đã được xác nhận, nhấn vào để xem chi tiết';
    } else {
      title = 'Đơn hàng đang giao';
      body =
          'Đơn hàng mã ${orderNotification.typeObject['orderId'] ?? ''} đang giao, nhấn vào để xem chi tiết';
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    final orderId = orderNotification.typeObject['orderId'] as String;

    if (_notificationCount[orderId] == null) {
      _notificationCount[orderId] = _notificationCount.length + 1;
    }

    final int idNotification = _notificationCount[orderId]!;

    await notificationPlugin.show(
        idNotification, title, body, notificationDetails,
        payload: orderId);
  }
}
