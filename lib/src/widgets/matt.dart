import 'package:flutter/material.dart';
import 'package:it_project/src/utils/func/me_image.dart';
import 'package:it_project/src/widgets/me_bottom_modal.dart';

class Matt {
  static MeImage imageInkwell(
          {required image, required context, required imageProvider}) =>
      MeImage(image: image, context: context, imageProvider: imageProvider);

  static void showBottom(context,
          {required String title, required Widget widget, Widget? bottom}) =>
      MeBottomModal.showMeModalBottomSheet(context,
          title: title, widget: widget, bottom: bottom);
}
