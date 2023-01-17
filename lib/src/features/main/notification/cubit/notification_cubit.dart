import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/notification/screens/notification_tab_screen.dart';
import 'package:it_project/src/features/order/screens/detail_order_screen.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/utils/remote/model/order_notification/m_notification.dart';
import 'package:it_project/src/utils/repository/notification_repository_impl.dart';
import 'package:it_project/src/widgets/matt.dart';
import 'package:logger/logger.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit()
      : super(const NotificationInitial(
          isLoading: false,
          notifications: [],
        ));

  initCubit() {
    _getNotification(TypeLoad.refresh);
    _addListenerController();
  }

  _addListenerController() {
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.7) {
        loadNotification(TypeLoad.loadMore);
      }
    });
  }

  int currentPage = 1;

  bool isLoadingData = false;
  loadNotification(TypeLoad type) async {
    if (isLoadingData) return;
    isLoadingData = true;
    switch (type) {
      case TypeLoad.loadMore:
        emit(state.copyWith(isLoading: true));
        currentPage++;
        await _getNotification(type);
        emit(state.copyWith(isLoading: false));
        break;
      case TypeLoad.refresh:
        emit(state.copyWith(isLoading: true));
        currentPage = 1;
        await _getNotification(type);
        emit(state.copyWith(isLoading: false));
        break;
      default:
    }

    isLoadingData = false;
  }

  final ScrollController controller = ScrollController();

  final notificationRepo = getIt<NotificationRepositoryImpl>();

  _getNotification(TypeLoad type) async {
    final result =
        await notificationRepo.getNotifications(currentPage: currentPage);

    if (result.isSuccess) {
      switch (type) {
        case TypeLoad.loadMore:
          Logger().i('load more #$currentPage');
          emit(state.copyWith(
              notifications: [...state.notifications, ...result.data!]));
          break;
        case TypeLoad.refresh:
          emit(state.copyWith(notifications: result.data));
          break;
        default:
      }
    }
  }

  updateNotificationOnClick(String notificationId,
      {required bool status}) async {
    notificationRepo.updateNotification(
        notificationId: notificationId, status: status);
    final newNotification = List<MNotification>.from(state.notifications);
    final indexNotification =
        newNotification.indexWhere((element) => element.id == notificationId);

    newNotification[indexNotification] =
        newNotification[indexNotification].copyWith(status: status);

    emit(state.copyWith(notifications: newNotification));
  }

  itemNotificationOnCLick(context, {required MNotification notification}) {
    final String orderId = notification.typeObject['orderId']!;
    Matt.showBottom(context,
        title: 'Chi tiết đơn hàng',
        widget: DetailOrderScreen(orderId: orderId));

    final isRead = notification.status;
    if (isRead == false) {
      updateNotificationOnClick(notification.id, status: true);
    }
  }

  Offset _dropdownOffset(Offset offset, Size size,
      {required double heightDropDown, required double widthDropDown}) {
    const bottomApBarHeight = 50;
    const padding = 20.0;
    if (MediaQuery.of(navigatorKey.currentContext!).size.height <
        offset.dy + size.height + heightDropDown + bottomApBarHeight) {
      return Offset(offset.dx, offset.dy - size.height - heightDropDown);
    }
    return Offset(offset.dx, offset.dy - padding - 20);
  }

  showDropDownOnClick(context, {required MNotification notification}) async {
    var dropDownItems = NotificationDropDownItemValueEnums.values;
    double heightDropDown = (50.0) * dropDownItems.length;
    const double widthDropDown = 150.0;
    SmartDialog.showAttach(
      targetContext: context,
      targetBuilder: (offset, size) => _dropdownOffset(offset, size,
          heightDropDown: heightDropDown, widthDropDown: widthDropDown),
      usePenetrate: false,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(color: AppColors.whiteColor),
          child: Column(
            children: List.generate(dropDownItems.length, (index) {
              String textInkwell = dropDownItems.elementAt(index).toString();

              if (dropDownItems.elementAt(index) ==
                      NotificationDropDownItemValueEnums.read &&
                  notification.status == true) {
                textInkwell = 'Đánh dấu chưa đọc';
              }

              return Material(
                child: InkWell(
                  highlightColor: AppColors.primaryColor,
                  onTap: () {
                    if (index == 0) {
                      final disStatus = !notification.status;
                      BlocProvider.of<NotificationCubit>(context)
                          .updateNotificationOnClick(notification.id,
                              status: disStatus);
                      SmartDialog.dismiss();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      textInkwell,
                      style: GoogleFonts.nunito(),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  @override
  void emit(NotificationState state) {
    if (isClosed) return;
    super.emit(state);
  }
}
