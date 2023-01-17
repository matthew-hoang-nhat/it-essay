import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/features/product/screens/create_review_screen.dart';
import 'package:it_project/src/features/product/widgets/item_review_widget.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/widgets/matt.dart';
import 'package:it_project/src/widgets/me_button.dart';

class ReviewComponentWidget extends StatelessWidget {
  const ReviewComponentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          introduceReviewWidget(),
          reviewsWidget(),
          seeMoreButton(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  BlocBuilder<ProductCubit, ProductState> seeMoreButton() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.isEndReviews != current.isEndReviews,
      builder: (context, state) {
        if (state.isEndReviews == false) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: MeButton(
                text: 'Xem thêm',
                onTap: () =>
                    context.read<ProductCubit>().loadReviews(TypeLoad.loadMore),
                textColor: AppColors.primaryColor,
                backgroundColor: AppColors.whiteColor,
                borderColor: AppColors.primaryColor,
              ));
        }

        return Container();
      },
    );
  }

  BlocBuilder<ProductCubit, ProductState> introduceReviewWidget() {
    const sizeImage = 200.0;
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        if (state.product == null) return Container();
        final product = state.product!;

        if (product.productImages == null) return Container();
        final firstImage = (product.productImages as List)
            .map((e) => ProductPicture.fromJson(e))
            .first
            .fileLink;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: sizeImage,
                        width: sizeImage,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(imageUrl: firstImage),
                        ),
                      ),
                      // Row(
                      //   children: [...starWidget(3, 5, sizeStar: 20)],
                      // ),
                      // Text('(423 đánh giá)',
                      //     style:
                      //         GoogleFonts.nunito(color: AppColors.greyColor)),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.category!.name,
                            style:
                                GoogleFonts.nunito(color: AppColors.greyColor)),
                        Text(product.name,
                            style: GoogleFonts.nunito(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.isBoughtProduct != current.isBoughtProduct,
                builder: (context, state) {
                  if (state.isBoughtProduct == false) return Container();
                  return InkWell(
                    onTap: () {
                      Matt.showBottom(context,
                          title: 'Đánh giá sản phẩm',
                          widget: CreateReviewScreen(
                              idProduct: state.product!.id,
                              nameProduct: product.name,
                              onSuccess: () {
                                context
                                    .read<ProductCubit>()
                                    .loadReviews(TypeLoad.refresh);
                              }));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.primaryColor)),
                      alignment: Alignment.center,
                      child: Text(
                        'Đánh giá sản phẩm',
                        style: GoogleFonts.nunito(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  reviewsWidget() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => previous.reviews != current.reviews,
      builder: (context, state) {
        return Column(
            children:
                state.reviews.map((e) => ItemReviewWidget(review: e)).toList());
      },
    );
  }
}
