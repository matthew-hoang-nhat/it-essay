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
    Logger().wtf('initPlugin');
    _setting = InitializationSettings(
      android: _settingAndroid,
    );
    await notificationPlugin.initialize(
      _setting,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        final String? payload = response.payload;
        Logger().i('Click Notification in Foregorund');
        GoRouter.of(navigatorKey.currentContext!).push(
            '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$payload');
      },
    );
  }

  getCurrentNotificationAndBackgroundTapNotification() async {
    final NotificationAppLaunchDetails? detail =
        await notificationPlugin.getNotificationAppLaunchDetails();

    if (detail != null && detail.didNotificationLaunchApp) {
      final String? orderId = detail.notificationResponse!.payload;
      GoRouter.of(navigatorKey.currentContext!).push(
          '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$orderId');
    }
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    final String? orderId = notificationResponse.payload;
    GoRouter.of(navigatorKey.currentContext!).push(
        '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}/${Paths.sDetailOrderScreen}/$orderId');
  }

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
    String title = 'T??n th??ng b??o';
    String body = 'N???i dung th??ng b??o';
    if (isAcceptOrder) {
      title = '????n h??ng ???? ???????c x??c nh???n';
      body =
          '????n h??ng m?? ${orderNotification.typeObject['orderId'] ?? ''} ???? ???????c x??c nh???n, nh???n v??o ????? xem chi ti???t';
    } else {
      title = '????n h??ng ??ang giao';
      body =
          '????n h??ng m?? ${orderNotification.typeObject['orderId'] ?? ''} ??ang giao, nh???n v??o ????? xem chi ti???t';
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
