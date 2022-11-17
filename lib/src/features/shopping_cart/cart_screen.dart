import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/shopping_cart/cubit/cart_cubit.dart';
import 'package:it_project/src/features/shopping_cart/widgets/component_cart_widget.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartCubit>().loadLocal();
    return Scaffold(
        appBar: AppBar(
          foregroundColor: AppColors.whiteColor,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            'Giỏ hàng',
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            // Center(
            //     child: Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Text(
            //     'Edit',
            //     style: GoogleFonts.nunito(
            //         fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const ComponentCartWidget(),
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
                    BlocBuilder<CartCubit, CartState>(
                      bloc: bloc,
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  formatCurrency
                                      .format(state.priceAfterSaleOff),
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.redColor),
                                ),
                                const SizedBox(width: 10),
                                if (state.price != state.priceAfterSaleOff)
                                  Text(
                                    formatCurrency.format(state.price),
                                    style: GoogleFonts.nunito(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                      color: AppColors.greyColor,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
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
                        onPressed: () {
                          context.push(Paths.payment);
                        },
                        child: const Text('Thanh toán')),
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
            Text('Chăm sóc khách hàng',
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold, fontSize: 20)),
            Text('QSOUQ SKU ID: 1430312',
                style: GoogleFonts.nunito(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      const Icon(MaterialCommunityIcons.phone_outline,
                          size: 30),
                      Text('Gọi cho chúng tôi',
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                      const Text(
                        'Hỗ trợ 24/7',
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
                      Text('Giữ liên lạc',
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.bold)),
                      const Text("Khi cần hỗ trợ"),
                      const SizedBox(height: 20),
                      Text('mattheuhtn@gmail',
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
}
