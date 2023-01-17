import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/services/notification_manager.dart';
import 'package:it_project/src/utils/remote/model/order_notification/order_notification.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketManager {
  Socket? _socket;
  final urlServer = 'https://external-server-v1.onrender.com';

  void connect() async {
    if (_socket?.connected == true) disconnect();
    final token = getIt<FUserLocal>().acceptToken;
    if (token == null) return;

    _socket = io(
        urlServer,
        OptionBuilder().setTransports(['websocket']).setExtraHeaders(
            {'token': 'Bearer $token'}).build());

    if (_socket == null) return;
    _socket?.onConnect((_) {
      Logger().i('Connected Socket');
    });

    _socket?.on('send-noti-confirm-order', (data) async {
      Logger().i(data);
      final orderNotification = OrderNotification.fromJson(data);

      getIt<NotificationManager>()
          .pushOrderNotification(orderNotification: orderNotification);
    });
    _socket?.on('send-noti-confirm-shipping', (data) async {
      Logger().i(data);
      final orderNotification = OrderNotification.fromJson(data);
      getIt<NotificationManager>()
          .pushOrderNotification(orderNotification: orderNotification);
    });
  }

  void disconnect() {
    Logger().i('disconnect Socket');
    _socket?.disconnect();
  }
}
