import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/widgets/start_widget.dart';

import '../../../configs/constants/app_colors.dart';

enum LikeReviewEnum { like, dislike, nothing }

class ItemReviewWidget extends StatefulWidget {
  const ItemReviewWidget({super.key});

  @override
  State<ItemReviewWidget> createState() => _ItemReviewWidgetState();
}

class _ItemReviewWidgetState extends State<ItemReviewWidget> {
  var likeReviewState = LikeReviewEnum.nothing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.nunito(color: AppColors.greyColor),
                      children: const [
                    TextSpan(text: 'Matthew'),
                    TextSpan(text: ' | '),
                    TextSpan(text: 'Jul 29, 2020'),
                  ])),
              const Spacer(),
              ...starWidget(4, 5)
            ],
          ),
          Text('Cool design, too tight',
              style: GoogleFonts.nunito(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            labelContent('Mua thôi'),
            labelContent('Khuyên dùng')
          ]),
          const SizedBox(height: 10),
          Text(
            'Sau mấy ngày trông ngóng thì cuối cùng em ấy cũng đã về với mình. Mở ra phải nói là rất ưng cái bụng luôn. Giầy đẹp đi êm chân cực ý .Về size giày thì chuẩn nha mn. Khoản đóng gói shop cũng chu đáo để thêm 2 miếng giữ fom giày. Ncl giày đẹp giá rẻ mn nên mua nh',
            style: GoogleFonts.nunito(color: AppColors.greyColor, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(children: [
                InkWell(
                  onTap: () {
                    switch (likeReviewState) {
                      case LikeReviewEnum.like:
                        likeReviewState = LikeReviewEnum.nothing;
                        break;

                      case LikeReviewEnum.nothing:
                      case LikeReviewEnum.dislike:
                        likeReviewState = LikeReviewEnum.like;
                        break;
                    }
                    setState(() {});
                  },
                  child: likeReviewState == LikeReviewEnum.like
                      ? Icon(MaterialCommunityIcons.thumb_up,
                          color: AppColors.blueColor)
                      : Icon(MaterialCommunityIcons.thumb_up_outline,
                          color: AppColors.blueColor),
                ),
                const SizedBox(width: 10),
                Text('16',
                    style: GoogleFonts.nunito(color: AppColors.blueColor)),
              ]),
              const SizedBox(width: 10),
              Row(children: [
                InkWell(
                    onTap: () {
                      switch (likeReviewState) {
                        case LikeReviewEnum.like:
                        case LikeReviewEnum.nothing:
                          likeReviewState = LikeReviewEnum.dislike;
                          break;

                        case LikeReviewEnum.dislike:
                          likeReviewState = LikeReviewEnum.nothing;
                          break;
                      }
                      setState(() {});
                    },
                    child: likeReviewState == LikeReviewEnum.dislike
                        ? const Icon(MaterialCommunityIcons.thumb_down)
                        : const Icon(
                            MaterialCommunityIcons.thumb_down_outline)),
                const SizedBox(width: 10),
                const Text('3'),
              ]),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget labelContent(content) {
    return Container(
      // width: 120,
      height: 30,

      padding: const EdgeInsets.symmetric(horizontal: 5),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: AppColors.greenColor, borderRadius: BorderRadius.circular(5)),
      child: Row(children: [
        Icon(
          MaterialCommunityIcons.check,
          color: AppColors.whiteColor,
        ),
        Text(
          content,
          style: GoogleFonts.nunito(color: AppColors.whiteColor),
        ),
      ]),
    );
  }
}
