part of '../../features/main/notification/screens/notification_tab_screen.dart';

extension DateTimeX on String {
  String get toDateTimeStr {
    final dateTime = DateTime.parse(this);
    String date = DateFormat('dd-MM-yyyy').format(dateTime);
    return date;
  }
}
