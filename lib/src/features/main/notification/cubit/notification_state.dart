// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    required this.isLoading,
    required this.notifications,
  });
  final bool isLoading;

  final List<MNotification> notifications;

  @override
  List<Object> get props =>
      [isLoading, notifications, notifications.map((e) => e.status).toList()];

  NotificationState copyWith({
    bool? isLoading,
    List<MNotification>? notifications,
  }) {
    return NotificationState(
      isLoading: isLoading ?? this.isLoading,
      notifications: notifications ?? this.notifications,
    );
  }
}

class NotificationInitial extends NotificationState {
  const NotificationInitial({
    required super.isLoading,
    required super.notifications,
  });
}
