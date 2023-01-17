part of '../screens/notification_tab_screen.dart';

enum NotificationDropDownItemValueEnums {
  read,
  report;

  @override
  String toString() {
    switch (this) {
      case NotificationDropDownItemValueEnums.read:
        return 'Đánh dấu đã đọc';
      case NotificationDropDownItemValueEnums.report:
        return 'Báo cáo';
    }
  }
}

class _ItemNotificationWidget extends StatelessWidget {
  const _ItemNotificationWidget({Key? key, required this.notification})
      : super(key: key);
  final MNotification notification;
  @override
  Widget build(BuildContext context) {
    final isRead = notification.status;
    return InkWell(
      onTap: () => context
          .read<NotificationCubit>()
          .itemNotificationOnCLick(context, notification: notification),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        color: isRead ? null : AppColors.primaryColor.withOpacity(0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconNotificationWidget(),
            const SizedBox(width: 20),
            Expanded(child: contextNotificationWidget()),
            Builder(
                builder: (context) => InkWell(
                    onTap: () => context
                        .read<NotificationCubit>()
                        .showDropDownOnClick(context,
                            notification: notification),
                    child: const Icon(MaterialCommunityIcons.dots_horizontal)))
          ],
        ),
      ),
    );
  }

  Column contextNotificationWidget() {
    final String orderId = notification.typeObject['orderId']!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notification.title,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        RichText(
            text: TextSpan(
                style: GoogleFonts.nunito(color: AppColors.blackColor),
                children: [
              TextSpan(text: notification.content),
              const TextSpan(text: ' '),
              TextSpan(text: orderId),
            ])),
        const SizedBox(height: 5),
        Text(notification.createdAt.toDateTimeStr,
            style: GoogleFonts.nunito(color: AppColors.greyColor)),
      ],
    );
  }

  Widget iconNotificationWidget() {
    final isConfirmOrder = (notification.typeObject['type'] == 'order');
    return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
            padding: const EdgeInsets.all(10),
            child: Icon(isConfirmOrder
                ? MaterialCommunityIcons.account_check
                : MaterialCommunityIcons.bike_fast)));
  }
}
