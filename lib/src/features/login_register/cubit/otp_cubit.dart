import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
import 'package:it_project/src/features/login_register/repositories/auth_repository.dart';
import 'package:it_project/src/features/login_register/repositories/auth_repository_impl.dart';

part 'otp_state.dart';

enum OtpEnum { announcement, time, isLoading }

class OtpCubit extends Cubit<OtpState> implements ParentCubit<OtpEnum> {
  OtpCubit()
      : super(const OtpInitial(
          announcement: '',
          time: '',
          isLoading: false,
        ));
  AuthRepository authRepository = getIt<AuthRepositoryImpl>();
  final meLocalKey = viVN;

  Timer? _timer;
  final int maxCount = 5;
  late int start = maxCount;

  Future<bool> sendButtonClick(String otpCode, String emailUser) async {
    bool isLoading = true;
    addNewEvent(OtpEnum.isLoading, isLoading);

    final result = await _callApiOtpSend(int.parse(otpCode), emailUser);

    isLoading = false;
    addNewEvent(OtpEnum.isLoading, isLoading);

    if (result) {
      return true;
    }
    return false;
  }

  Future<bool> _callApiOtpSend(int otp, userId) async {
    final responseOtpRegister =
        await authRepository.otpRegister(userId: userId, otpCode: otp);

    final result = responseOtpRegister.keys.first;
    if (result) return true;

    const announcement = 'OTP sai rồi bạn ơi';
    addNewEvent(OtpEnum.announcement, announcement);

    return false;
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  void startTimer() {
    _cancelTimer();
    start = maxCount;
    addNewEvent(OtpEnum.time, start.toString());

    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          addNewEvent(OtpEnum.time, start.toString());
        } else {
          start--;
          addNewEvent(OtpEnum.time, start.toString());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  @override
  void addNewEvent(OtpEnum key, value) {
    switch (key) {
      case OtpEnum.announcement:
        emit(NewOtpState.fromOldSettingState(state, announcement: value));
        break;
      case OtpEnum.isLoading:
        emit(NewOtpState.fromOldSettingState(state, isLoading: value));
        break;
      case OtpEnum.time:
        emit(NewOtpState.fromOldSettingState(state, time: value));
        break;
    }
  }
}
