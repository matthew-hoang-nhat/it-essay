import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/notification/cubit/notification_cubit.dart';
import 'package:it_project/src/utils/remote/model/order_notification/m_notification.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
part '../widgets/item_notification_widget.dart';
part '../../../../utils/helpers/extensions.dart';

class NotificationTabScreen extends StatelessWidget {
  const NotificationTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thông báo')),
      body: SafeArea(
        child: BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) =>
              previous.notifications != current.notifications ||
              previous.isLoading != current.isLoading,
          builder: (context, state) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ListView.builder(
                    controller: context.read<NotificationCubit>().controller,
                    itemCount: state.notifications.length,
                    itemBuilder: (itemContext, index) {
                      final notification = state.notifications.elementAt(index);
                      return _ItemNotificationWidget(
                        notification: notification,
                      );
                    }),
                if (state.isLoading)
                  LoadingAnimationWidget.waveDots(
                      color: AppColors.primaryColor, size: 50)
              ],
            );
          },
        ),
      ),
    );
  }
}
