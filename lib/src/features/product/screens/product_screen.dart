import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/features/product/mock/mock_product.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _controller = ScrollController();
  final bloc = ProductCubit(superSlug: '04560210');

  @override
  void initState() {
    settingController();
    super.initState();
  }

  settingController() {
    _controller.addListener(() {
      double maxScroll = _controller.position.maxScrollExtent;
      double currentScroll = _controller.position.pixels;
      double delta = 200.0; // or something else..
      if (maxScroll - currentScroll >= 0) {
        if (bloc.state.isTop != true) {
          bloc.addNewEvent(ProductEnum.isTop, true);
        }
      } else {
        if (bloc.state.isTop != false) {
          bloc.addNewEvent(ProductEnum.isTop, false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // bloc.getDetailProduct();
    bloc.emit(
        NewProductState.fromOldSettingState(bloc.state, product: mockProduct));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: topBar(),
        body: BlocBuilder<ProductCubit, ProductState>(
          bloc: bloc,
          buildWhen: (previous, current) => previous.product != current.product,
          builder: (context, state) {
            if (bloc.state.product == null) return Container();
            final Product product = bloc.state.product!;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SingleChildScrollView(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Nike'),
                                Icon(MaterialCommunityIcons.heart_outline),
                              ],
                            ),
                            Text(
                              product.name,
                              style: GoogleFonts.nunito(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            starAndReviewWidget(3, 128),
                            priceProduct(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // meDivider(),
                      // moreInfo(product),
                      meDivider(),
                      // describeProduct(),
                      reviewProduct(),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
                bottomBar(),
              ],
            );
          },
        ));
  }

  priceProduct() {
    return Row(
      children: [
        Text(
          '₫81.000đ',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            // color: AppColors.redColor,
            color: AppColors.redColor,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '₫108.000đ',
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
            '-25%',
            style: GoogleFonts.nunito(color: AppColors.redColor),
          ),
        )
      ],
    );
  }

  topBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: BlocBuilder<ProductCubit, ProductState>(
        bloc: bloc,
        buildWhen: (previous, current) => previous.isTop != current.isTop,
        builder: (context, state) {
          return bloc.state.isTop
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.brownColor,
                  actions: [
                    borderIcon(MaterialCommunityIcons.cart_outline, () {
                      context.pop();
                    }),
                    const SizedBox(width: 10),
                    borderIcon(MaterialCommunityIcons.dots_horizontal, () {}),
                    const SizedBox(width: 20),
                  ],
                  leading: borderIcon(
                      MaterialCommunityIcons.arrow_left, context.pop),
                )
              : AppBar(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.brownColor,
                  actions: [
                    noBorderIcon(MaterialCommunityIcons.cart_outline, () {}),
                    const SizedBox(width: 10),
                    noBorderIcon(MaterialCommunityIcons.dots_horizontal, () {}),
                    const SizedBox(width: 20),
                  ],
                  leading: noBorderIcon(
                      MaterialCommunityIcons.arrow_left, context.pop),
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

  reviewProduct() {
    final product = bloc.state.product;
    final sizeImage = MediaQuery.of(context).size.width * 0.2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 200),
                height: sizeImage,
                width: sizeImage,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyColor),
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        AppAssets.fkImHarryPotter2,
                      )),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nike',
                      style: GoogleFonts.nunito(color: AppColors.greyColor)),
                  Text(product!.name,
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [...starWidget(3, 5, sizeStar: 20)],
              ),
              Text('(423 reviews)',
                  style: GoogleFonts.nunito(color: AppColors.greyColor))
            ],
          ),
          const SizedBox(height: 20),
          RichText(
              text: TextSpan(
                  style: GoogleFonts.nunito(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                  children: [
                TextSpan(
                    text: '92% ',
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const TextSpan(
                  text: 'người mua khuyên dùng sản phẩm này',
                ),
              ])),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ...List.generate(
                5,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text('${5 - index} Stars'),
                      const SizedBox(width: 20),
                      Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: LinearProgressIndicator(
                          minHeight: 5,
                          value: 0.7,
                          color: AppColors.brownColor,
                          backgroundColor: AppColors.greyColor.withOpacity(0.2),
                        ),
                      ),
                      const SizedBox(width: 20),
                      const Text('205')
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('SẮP XẾP THEO'),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.greyColor.withOpacity(0.5)),
                child: const Text('Default'),
              ),
            ],
          ),
          reviewWidget(),
        ],
      ),
    );
  }

  reviewWidget() {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Matthew'),
              const Text('|'),
              const Text('Jul 29, 2020'),
              const Spacer(),
              ...starWidget(4, 5)
            ],
          ),
          const Text('Cool design, too tight'),
          const Text(
              'Sau mấy ngày trông ngóng thì cuối cùng em ấy cũng đã về với mình. Mở ra phải nói là rất ưng cái bụng luôn. Giầy đẹp đi êm chân cực ý .Về size giày thì chuẩn nha mn. Khoản đóng gói shop cũng chu đáo để thêm 2 miếng giữ fom giày. Ncl giày đẹp giá rẻ mn nên mua nh'),
          Row(
            children: const [
              Icon(MaterialCommunityIcons.linkedin),
              Icon(MaterialCommunityIcons.linkedin),
            ],
          )
        ],
      ),
    );
  }

  // appBar() {
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

  meDivider() {
    return Container(height: 10, color: AppColors.whiteGreyColor);
  }

  moreInfo(Product product) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Thông tin chi tiết',
              style: GoogleFonts.nunito(fontSize: 16),
            ),
          ),
          rowContent('Danh mục', 'Kỹ năng sống', 0),
          rowContent('Tác giả', product.spec.author, 1),
          rowContent('Nhà xuất bản', product.spec.publisher, 2),
          rowContent('Ngày xuất bản', product.spec.publicationDate, 3),
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

  rowContent(leading, title, index) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: index % 2 == 0 ? AppColors.whiteGreyColor : AppColors.whiteColor,
      child: Row(
        children: [
          SizedBox(
              width: 100,
              child: Text(
                leading,
                style: GoogleFonts.nunito(color: AppColors.greyColor),
              )),
          const SizedBox(width: 10),
          Text(title)
        ],
      ),
    );
  }

  Container bottomBar() {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('830.00'),
                Text('819.19 QR'),
              ],
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.brownColor),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(horizontal: 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ))),
                onPressed: () {},
                child: const Text('Add to Cart')),
          ],
        ),
      ),
    );
  }

  starWidget(int numberStar, int numberReview, {double? sizeStar}) {
    const maxStar = 5;
    return [
      ...List.generate(
          numberStar,
          (index) => Icon(
                MaterialCommunityIcons.star,
                color: AppColors.yellowColor,
                size: sizeStar ?? 15,
              )),
      ...List.generate(
          maxStar - numberStar,
          (index) => Icon(
                MaterialCommunityIcons.star_outline,
                color: AppColors.yellowColor,
                size: sizeStar ?? 15,
              )),
    ];
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
}
