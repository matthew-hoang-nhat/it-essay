// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/features/product/widgets/component_review_widget.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/start_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductCubit>(
        create: (context) => ProductCubit(product: product)..initCubit(),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: topBar(),
            body: Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    BlocBuilder<ProductCubit, ProductState>(
                      buildWhen: (previous, current) => false,
                      builder: (context, state) {
                        return SingleChildScrollView(
                          controller: context.read<ProductCubit>().controller,
                          // physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              imgPoster(),
                              topProductInfo(),
                              const SizedBox(height: 20),
                              meDivider(),
                              sellerInfo(),
                              meDivider(),
                              moreInfo(product),
                              meDivider(),
                              describeProduct(),
                              meDivider(),
                              const ComponentReviewWidget(),
                              const SizedBox(height: 70),
                            ],
                          ),
                        );
                      },
                    ),
                    addCartButton()
                  ],
                ),
                BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: LoadingWidget());
                    }
                    return Container();
                  },
                )
              ],
            )));
  }

  Container addCartButton() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),

        child: BlocBuilder<ProductCubit, ProductState>(
          buildWhen: (previous, current) => false,
          builder: (context, state) {
            return ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ))),
                onPressed: () {
                  context
                      .read<ProductCubit>()
                      .actionCart(ProductCartActionEnum.addItem);
                  context.read<AppCubit>().reGetItemCartQuantity();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MaterialCommunityIcons.cart_plus,
                      color: AppColors.whiteColor,
                    ),
                    const Text('Thêm vào giỏ hàng'),
                  ],
                ));
          },
        ),
        // ],
      ),
      // ),
    );
  }

  Widget topProductInfo() {
    return BlocBuilder<ProductCubit, ProductState>(
      // bloc: bloc,
      buildWhen: (previous, current) => false,
      builder: (context, state) => Container(
        constraints: const BoxConstraints(minHeight: 140),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.product.category.name),
                const Icon(MaterialCommunityIcons.heart_outline),
              ],
            ),
            Text(
              product.name,
              maxLines: 2,
              style:
                  GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            starAndReviewWidget(3, 128),
            priceProduct(),
          ],
        ),
      ),
    );
  }

  contentSellerInfo(title, sub) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        Text(
          sub,
          style: GoogleFonts.nunito(color: AppColors.greyColor),
        ),
      ],
    );
  }

  sellerInfo() {
    return BlocBuilder<ProductCubit, ProductState>(
      // bloc: bloc,
      buildWhen: (previous, current) => previous.product != current.product,
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.push(Paths.sellerScreen, extra: state.product.seller);
          },
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: state.product.seller?.logo?.fileLink == null
                        ? Container(
                            color: AppColors.whiteGreyColor,
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                state.product.seller?.logo?.fileLink ?? '',
                            errorWidget: (context, url, error) => Image.asset(
                              AppAssets.fkImHarryPotter2,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.product.seller?.info.name ?? '',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.dp16),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          color: AppColors.primaryColor,
                          child: Row(
                            children: [
                              Icon(
                                MaterialCommunityIcons.check,
                                color: AppColors.whiteColor,
                              ),
                              Text(
                                'Official',
                                style: GoogleFonts.nunito(
                                    color: AppColors.whiteColor),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const Spacer(),
                  const Icon(MaterialCommunityIcons.chevron_right),
                ]),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: contentSellerInfo('4.9 / 5', '3k+ đánh giá'),
                    ),
                    Flexible(
                      child: contentSellerInfo('1.9k+', 'Người theo dõi'),
                    ),
                    // Flexible(
                    //   child: contentSellerInfo('70%', 'Phản hồi Chat'),
                    // ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  imgPoster() {
    return BlocBuilder<ProductCubit, ProductState>(
      // bloc: bloc,
      buildWhen: ((previous, current) => previous.product != current.product),
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                  controller: context.read<ProductCubit>().pageController,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: product.productImages.length,
                  // itemCount: 3,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: state.product.productImages
                                    .elementAt(index)
                                    .fileLink,
                                width: double.infinity,
                                height: 300,
                                fit: BoxFit.fitHeight,
                              )),
                        ],
                      );
                      // return Stack(
                      //   alignment: Alignment.bottomRight,
                      //   children: [
                      //     ClipRRect(
                      //         borderRadius: const BorderRadius.only(
                      //           topLeft: Radius.circular(5),
                      //           topRight: Radius.circular(5),
                      //         ),
                      //         child: CachedNetworkImage(
                      //           imageUrl: state.product.productImages
                      //               .elementAt(index)
                      //               .fileLink,
                      //           width: double.infinity,
                      //           height: 300,
                      //           fit: BoxFit.cover,
                      //         )),
                      //   ],
                      // );
                    }
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: state.product.productImages
                                  .elementAt(index)
                                  .fileLink,
                              width: double.infinity,
                              height: 300,
                              fit: BoxFit.fitHeight,
                            )),
                      ],
                    );
                  }),
            ),
            // ),
            BlocBuilder<ProductCubit, ProductState>(
              // bloc: bloc,
              buildWhen: (previous, current) =>
                  previous.indexImage != current.indexImage,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(state.product.productImages.length,
                      (index) {
                    return Container(
                      height: 10,
                      width: 10,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: state.indexImage == index
                            ? AppColors.blueColor
                            : AppColors.whiteColor,
                      ),
                    );
                  }),
                );
              },
            )
          ],
        );
      },
    );
  }

  priceProduct() {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final priceAfterSaleOff =
            state.product.price * (100 - (state.product.discountPercent)) / 100;

        final isDiscount = state.product.discountPercent != 0;
        return Row(
          children: [
            Text(
              formatCurrency.format(priceAfterSaleOff),
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isDiscount ? AppColors.redColor : null,
              ),
            ),
            const SizedBox(width: 10),
            if (isDiscount)
              Row(
                children: [
                  Text(
                    state.product.price.toString(),
                    style: GoogleFonts.nunito(
                      color: AppColors.greyColor,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppColors.redColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(1),
                        border: Border.all(color: AppColors.redColor)),
                    child: Text(
                      '-${state.product.discountPercent.toString()}%',
                      style: GoogleFonts.nunito(color: AppColors.redColor),
                    ),
                  )
                ],
              )
          ],
        );
      },
    );
  }

  topBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: BlocBuilder<ProductCubit, ProductState>(
        buildWhen: (previous, current) => previous.isTop != current.isTop,
        builder: (context, state) {
          return state.isTop
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.brownColor,
                  actions: [
                    borderIcon(MaterialCommunityIcons.cart_outline, () {
                      context.push(Paths.cartScreen);
                    }),
                    const SizedBox(width: 10),
                    borderIcon(MaterialCommunityIcons.dots_horizontal, () {}),
                    const SizedBox(width: 20),
                  ],
                  leading: borderIcon(MaterialCommunityIcons.arrow_left, () {
                    context.pop();
                  }),
                )
              : AppBar(
                  elevation: 1,
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.brownColor,
                  actions: [
                    noBorderIcon(MaterialCommunityIcons.cart_outline, () {
                      context.push(Paths.cartScreen);
                    }),
                    const SizedBox(width: 10),
                    noBorderIcon(MaterialCommunityIcons.dots_horizontal, () {}),
                    const SizedBox(width: 20),
                  ],
                  leading: noBorderIcon(MaterialCommunityIcons.arrow_left, () {
                    context.pop();
                  }),
                );
        },
      ),
    );
  }

  noBorderIcon(IconData iconData, func) {
    const sizeIcon = 30.0;

    return InkWell(
      onTap: func,
      child: Center(
        child: SizedBox(
            height: sizeIcon,
            width: sizeIcon,
            child: Icon(
              iconData,
              size: sizeIcon - 5,
            )),
      ),
    );
  }

  borderIcon(IconData iconData, func) {
    const sizeIcon = 30.0;

    return InkWell(
      onTap: func,
      child: Center(
        child: Container(
            height: sizeIcon,
            width: sizeIcon,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.greyColor.withOpacity(0.5),
            ),
            child: Icon(
              iconData,
              color: AppColors.whiteColor,
              size: sizeIcon - 5,
            )),
      ),
    );
  }

  describeProduct() {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) =>
          previous.isDescribeShowAll != current.isDescribeShowAll,
      builder: (context, state) {
        return state.isDescribeShowAll == true
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mô tả sản phẩm',
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.product.description,
                    ),
                  ],
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mô tả sản phẩm',
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      state.product.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Stack(children: <Widget>[
                      SizedBox(
                          height: 180,
                          child: CachedNetworkImage(
                            imageUrl:
                                state.product.productImages.first.fileLink,
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                          )),
                      Container(
                        height: 185.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                                  Colors.grey.withOpacity(0.0),
                                  AppColors.whiteColor,
                                  AppColors.whiteColor,
                                ],
                                stops: const [
                                  0.0,
                                  1.0,
                                  1.0
                                ])),
                      )
                    ]),
                    Center(
                        child: InkWell(
                            onTap: () {
                              context.read<ProductCubit>().addNewEvent(
                                  ProductEnum.isDescribeShowAll, true);
                            },
                            child: Container(
                                height: 30,
                                width: 100,
                                alignment: Alignment.center,
                                child: Text(
                                  'Xem tất cả',
                                  style: GoogleFonts.nunito(
                                      color: AppColors.blueColor,
                                      fontWeight: FontWeight.bold),
                                )))),
                  ],
                ),
              );
      },
    );
  }

  moreInfo(Product? product) {
    rowContent(String? leading, String? title, int index) {
      return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: index % 2 == 0
            ? AppColors.whiteGreyColor.withOpacity(0.1)
            : AppColors.whiteColor,
        child: Row(
          children: [
            SizedBox(
                width: 100,
                child: Text(
                  leading ?? '',
                  style: GoogleFonts.nunito(color: AppColors.greyColor),
                )),
            const SizedBox(width: 10),
            Text(title ?? '')
          ],
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Thông tin chi tiết',
              style:
                  GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          rowContent('Danh mục', 'Kỹ năng sống', 0),
          rowContent('Tác giả', product?.spec.author, 1),
          rowContent('Nhà xuất bản', product?.spec.publisher, 2),
          rowContent('Ngày xuất bản', product?.spec.publicationDate, 3),
          // Center(
          //     child: InkWell(
          //         onTap: () {},
          //         child: Container(
          //             height: 30,
          //             width: 100,
          //             alignment: Alignment.center,
          //             child: Text(
          //               'Xem tất cả',
          //               style: GoogleFonts.nunito(
          //                   color: AppColors.blueColor,
          //                   fontWeight: FontWeight.bold),
          //             )))),
        ],
      ),
    );
  }

  starAndReviewWidget(int numberStar, int numberReview) {
    return Row(
      children: [
        ...starWidget(3, 5),
        const SizedBox(width: 10),
        numberReview == 0
            ? const Text('(Chưa có đánh giá nào)')
            : Text(
                '($numberReview)',
                style: GoogleFonts.nunito(color: AppColors.brownColor),
              ),
      ],
    );
  }

  meDivider() {
    return Container(height: 10, color: AppColors.whiteGreyColor);
  }
}
