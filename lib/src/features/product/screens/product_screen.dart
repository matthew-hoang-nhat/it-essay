import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/constants/app_dimensions.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/features/product/widgets/component_review_widget.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/widgets/start_widget.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key, required this.product});
  final Product product;
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
  late final bloc = ProductCubit(product: product);
  // final bloc = ProductCubit();

  @override
  Widget build(BuildContext context) {
    // bloc.getDetailProduct();
    bloc.settingController();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: topBar(),
        body: BlocProvider(
          create: (context) => bloc,
          child: BlocBuilder<ProductCubit, ProductState>(
            bloc: bloc,
            builder: (context, state) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SingleChildScrollView(
                    controller: state.controller,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imgPoster(),
                        Container(
                          height: 140,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(state.product.category.name),
                                  const Icon(
                                      MaterialCommunityIcons.heart_outline),
                                ],
                              ),
                              Text(
                                product.name,
                                maxLines: 2,
                                style: GoogleFonts.nunito(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              starAndReviewWidget(3, 128),
                              priceProduct(),
                            ],
                          ),
                        ),
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
                  ),
                  bottomBar(),
                ],
              );
            },
          ),
        ));
  }

  sellerInfo() {
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

    return Container(
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
                child: Image.asset(
                  AppAssets.fkImHarryPotter2,
                  fit: BoxFit.cover,
                )),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bloc.state.product.seller?.infoData.name ?? 'unknown',
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
                          style:
                              GoogleFonts.nunito(color: AppColors.whiteColor),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: contentSellerInfo('4.9 / 5', '3k+ đánh giá'),
              ),
              Flexible(
                child: contentSellerInfo('1.9k+', 'Người theo dõi'),
              ),
              Flexible(
                child: contentSellerInfo('70%', 'Phản hồi Chat'),
              ),
            ],
          )
        ],
      ),
    );
  }

  imgPoster() {
    return Stack(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: PageView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              // itemCount: product.productImages.length,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child:
                      // Image.network(
                      //   product.productImages.elementAt(index).fileLink,
                      //   height: 300,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // )
                      Image.asset(
                    AppAssets.fkImHarryPotter1,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ),
      ],
    );
  }

  priceProduct() {
    final priceAfterSaleOff = bloc.state.product.price *
        (100 - (bloc.state.product.discountPercent)) /
        100;

    final isDiscount = bloc.state.product.discountPercent != 0;
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
                bloc.state.product.price.toString(),
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
                  '-${bloc.state.product.discountPercent.toString()}%',
                  style: GoogleFonts.nunito(color: AppColors.redColor),
                ),
              )
            ],
          )
      ],
    );
    return Container();
  }

  topBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: BlocBuilder<ProductCubit, ProductState>(
        bloc: bloc,
        // buildWhen: (previous, current) => previous.isTop != current.isTop,
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mô tả sản phẩm',
            style:
                GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Đắc nhân tâm của Dale Carnegie là quyển sách nổi tiếng nhất, bán chạy nhất và có tầm ảnh hưởng nhất của mọi thời đại. Tác phẩm đã được chuyển ngữ sang hầu hết các thứ tiếng trên thế giới và có mặt ở hàng trăm quốc gia. Đây là quyển sách duy nhất về thể loại self-help liên tục đứng đầu danh mục sách bán chạy nhất (best-selling Books) do báo The New York Times bình chọn suốt 10 năm liền.',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Stack(children: <Widget>[
            SizedBox(
              height: 180,
              child: Image.asset(
                AppAssets.fkImHarryPotter2,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
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
                  onTap: () {},
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
  }

  moreInfo(Product? product) {
    rowContent(String? leading, String? title, int index) {
      return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: index % 2 == 0 ? AppColors.whiteGreyColor : AppColors.whiteColor,
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
          Center(
              child: InkWell(
                  onTap: () {},
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
  }

  Widget bottomBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2,
          ),
        ],
        color: AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Text('830.00'),
            //     Text('819.19 QR'),
            //   ],
            // ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.whiteColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ))),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      MaterialCommunityIcons.cart,
                      color: AppColors.brownColor,
                    ),
                    Text(
                      'Thêm vào giỏ hàng',
                      style: GoogleFonts.nunito(
                        color: AppColors.brownColor,
                        fontSize: 12,
                      ),
                    )
                  ],
                )),
            const SizedBox(width: 20),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.redColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ))),
                onPressed: () {},
                child: const Text('Mua ngay')),
          ],
        ),
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
