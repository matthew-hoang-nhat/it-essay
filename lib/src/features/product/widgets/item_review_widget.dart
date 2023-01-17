// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/features/app/fuser_local.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';

import 'package:it_project/src/utils/remote/model/review/review.dart';
import 'package:it_project/src/widgets/matt.dart';
import 'package:it_project/src/widgets/me_alert_dialog.dart';
import 'package:it_project/src/widgets/start_widget.dart';

import '../../../configs/constants/app_colors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';

enum LikeReviewEnum { like, dislike, nothing }

class ItemReviewWidget extends StatelessWidget {
  const ItemReviewWidget({Key? key, required this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    final name = review.user?['info']['firstName'] +
        ' ' +
        review.user?['info']['lastName'];
    final avatarUrl = review.user?['info']['avatar'];
    String dateTimeStr = '';

    if (review.dateTime != null) {
      final DateTime dateTime = DateTime.parse(review.dateTime!);
      dateTimeStr = DateFormat('yyyy-MM-dd | kk:mm').format(dateTime);
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: PhotoView(
                      imageProvider: CachedNetworkImageProvider(
                        avatarUrl,
                      ),
                    ),
                  )),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            style:
                                GoogleFonts.nunito(color: AppColors.greyColor),
                            children: [
                          TextSpan(text: name),
                        ])),
                    Row(
                      children: starWidget(review.ratingNumber.toInt(), 5),
                    ),
                    Text(review.text,
                        style: GoogleFonts.nunito(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        )),
                    if (review.attaches?.isNotEmpty == true)
                      SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: review.attaches?.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = review.attaches![index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Matt.imageInkwell(
                                  image: CachedNetworkImage(
                                    imageUrl: item['fileLink'] ?? '',
                                    width: 100,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Container(),
                                  ),
                                  context: context,
                                  imageProvider: CachedNetworkImageProvider(
                                    item['fileLink'] ?? '',
                                  )),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(dateTimeStr,
                        style: GoogleFonts.nunito(color: AppColors.greyColor)),
                  ],
                ),
              ),
              if (review.user?['_id'] == getIt<FUserLocal>().userId)
                BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) => false,
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (dialogContext) => MeAlertDialog(
                                  notificationTitle:
                                      const Text('Bạn muốn xóa đánh giá này?'),
                                  redActionTexts: {
                                    'Xóa': () {
                                      BlocProvider.of<ProductCubit>(context)
                                          .deleteReview(review);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  normalActionTexts: {
                                    'Không': Navigator.of(dialogContext).pop
                                  },
                                ));
                      },
                      child: Icon(
                        MaterialCommunityIcons.delete,
                        color: AppColors.greyColor,
                      ),
                    );
                  },
                ),
            ],
          ),
          const SizedBox(height: 10),
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
