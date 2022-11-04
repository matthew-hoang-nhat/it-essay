import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:it_project/src/widgets/login_popup_widget.dart';

import '../../../features/main/me/me_viewmodel.dart';

class MeScreen extends GetView<MeViewModel> {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        LoginPopup(),
      ],
    );
  }
}
