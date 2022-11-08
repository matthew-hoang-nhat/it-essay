part of 'otp_cubit.dart';

abstract class OtpState extends Equatable {
  const OtpState({
    required this.time,
    required this.announcement,
    required this.isLoading,
  });

  final String announcement;
  final String time;
  final bool isLoading;

  @override
  List<Object> get props => [announcement, time, isLoading];
}

class OtpInitial extends OtpState {
  const OtpInitial({
    required super.announcement,
    required super.time,
    required super.isLoading,
  });
}

class NewOtpState extends OtpState {
  NewOtpState.fromOldSettingState(
    OtpState oldState, {
    String? announcement,
    String? time,
    bool? isLoading,
  }) : super(
          announcement: announcement ?? oldState.announcement,
          time: time ?? oldState.time,
          isLoading: isLoading ?? oldState.isLoading,
        );
}
