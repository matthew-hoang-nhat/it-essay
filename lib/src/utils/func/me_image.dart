import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:photo_view/photo_view.dart';

class MeImage extends StatelessWidget {
  const MeImage(
      {super.key,
      required this.image,
      required this.context,
      required this.imageProvider});
  final BuildContext context;
  final Widget image;
  final ImageProvider<Object> imageProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          pushImageAndZoom();
        },
        child: image);
  }

  void pushImageAndZoom() {
    Navigator.of(context).push(
      PageRouteBuilder(
          opaque: false, // set to false
          pageBuilder: (_, __, ___) => Scaffold(
                  // backgroundColor: Colors.black.withOpacity(0.2),
                  body: Center(
                      child: Stack(
                alignment: Alignment.topRight,
                children: [
                  PhotoView(
                      minScale: 0.2,
                      maxScale: 1.0,
                      // initialScale: 0.5,

                      imageProvider: imageProvider),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 50),
                      child: Icon(
                        MaterialCommunityIcons.close_circle,
                        color: AppColors.greyColor,
                        size: 30,
                      ),
                    ),
                  )
                ],
              )))),
    );
  }
}
