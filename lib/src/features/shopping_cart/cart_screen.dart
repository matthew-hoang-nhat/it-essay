import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/shopping_cart/widgets/product_cart.dart';
import 'package:it_project/src/widgets/product_general/product_general_model.dart';
import '../../configs/locates/translation_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.product});

  final ProductGeneralModel product;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final meLocalKey = Get.find<TranslationManager>().keys['vi_VN'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 100,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      'Shopping Cart',
                      textScaleFactor: 1,
                      style: GoogleFonts.nunito(
                          color: AppColors.brownColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor,
                        ),
                        child: Column(
                          children: [
                            ProductCart(
                                isHeart: isHearts[0],
                                product: mockProductGeneralModel),
                            ProductCart(
                                isHeart: isHearts[1],
                                product: mockProductGeneralModel),
                            ProductCart(
                                isHeart: isHearts[2],
                                product: mockProductGeneralModel),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      moreInformation(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ]),
        ),
        Container(
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
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.brownColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))),
                    onPressed: () {},
                    child: const Text('Checkout')),
              ],
            ),
          ),
        )
      ],
    ));
  }

  moreInformation() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            Text('Help Advice',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 20)),
            Text('QSOUQ SKU ID: 1430312',
                style: GoogleFonts.nunito(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      const Icon(MaterialCommunityIcons.phone_outline,
                          size: 30),
                      Text('Order with us',
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                      const Text(
                        'We speak Arabic and English',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text('+84935638415',
                          style: GoogleFonts.nunito(
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      const Icon(MaterialCommunityIcons.email_outline,
                          size: 30),
                      Text('Get in Touch',
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                      const Text("We're here to help"),
                      const SizedBox(height: 20),
                      Text('Email us',
                          style: GoogleFonts.nunito(
                            color: AppColors.blueColor,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );

  final countProduct = 3;
  late final isHearts = List.generate(countProduct, (index) => false);

  // Container(
  //   margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //   height: 35,
  //   width: 35,
  //   decoration: BoxDecoration(
  //       color: AppColors.whiteBrownColor,
  //       borderRadius: BorderRadius.circular(100)),
  //   child: const Center(
  //     child: Icon(Icons.close),
  //     // child: Image.asset(
  //     //   AppAssets.icHeartFilled,
  //     //   height: 25,
  //     //   width: 25,
  //     //   color: AppColors.redColor,
  //     //   fit: BoxFit.cover,
  //     // ),
  //   ),
  // );
}
