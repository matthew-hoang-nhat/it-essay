import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class MeAlertDialog extends StatelessWidget {
  const MeAlertDialog({
    super.key,
    required this.notificationTitle,
    required this.redActionTexts,
    required this.normalActionTexts,
  });
  final Widget notificationTitle;
  final Map<String, Function()> normalActionTexts;
  final Map<String, Function()> redActionTexts;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: notificationTitle,
        actions: [
          ...redActionTexts.entries.map((e) => redActionWidget(e.key, e.value)),
          ...normalActionTexts.entries
              .map((e) => normalActionWidget(e.key, e.value))
        ],
        actionsAlignment: MainAxisAlignment.end);
  }

  redActionWidget(String text, Function() func) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.redColor),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20)),
      ),
      onPressed: func,
      child: Text(text),
    );
  }

  normalActionWidget(String text, Function() func) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.greyColor),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 20)),
      ),
      onPressed: func,
      child: Text(text),
    );
  }
}
