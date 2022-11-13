import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/locates/lang_vi.dart';
import 'package:it_project/src/features/shopping_cart/cubit/cart_cubit.dart';
import 'package:it_project/src/features/shopping_cart/widgets/item_cart_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final meLocalKey = viVN;
  final bloc = CartCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Giỏ hàng',
            style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
          ),
          actions: [
            Center(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Edit',
                style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: AppColors.blueColor,
                    fontWeight: FontWeight.bold),
              ),
            ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    itemCartsComponent(),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    moreInformation(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
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
                                AppColors.blueColor),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(horizontal: 20)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ))),
                        onPressed: () {},
                        child: const Text('Thanh toán')),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  itemCartsComponent() {
    return BlocBuilder<CartCubit, CartState>(
      bloc: bloc..loadLocal(),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteColor,
          ),
          child: Column(
            children: state.itemCards
                .map(
                  (e) => ItemCartWidget(
                    // isHeart: isHearts[0],
                    product: e,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
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
