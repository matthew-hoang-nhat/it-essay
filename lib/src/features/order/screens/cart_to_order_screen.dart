// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/app/cubit/app_cubit.dart';
import 'package:it_project/src/features/order/cubit/cart_to_order_cubit.dart';
import 'package:it_project/src/local/dao/item_cart_dao.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class CartToOrderScreen extends StatelessWidget {
  const CartToOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 10.0;
    return BlocBuilder<CartToOrderCubit, CartToOrderState>(
      buildWhen: (previous, current) => false,
      builder: (context, state) {
        return Stack(
          children: [
            BlocBuilder<CartToOrderCubit, CartToOrderState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return Scaffold(
                    appBar: AppBar(title: const Text('Thanh toán')),
                    bottomNavigationBar: bottomAppBar(state.totalPrice),
                    body: SafeArea(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Container(
                            color: AppColors.greyColor,
                            child: BlocBuilder<AppCubit, AppState>(
                              buildWhen: (previous, current) =>
                                  previous.address != current.address,
                              builder: (context, state) {
                                return InkWell(
                                  onTap: () {
                                    context.push(Paths.addressScreen,
                                        extra: true);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: padding),
                                      color: AppColors.whiteColor,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(MaterialCommunityIcons
                                              .map_outline),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Địa chỉ nhận hàng'),
                                                Text(state.address?.name ?? ''),
                                                Text(state.address?.address ??
                                                    ''),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                              MaterialCommunityIcons
                                                  .chevron_right,
                                              color: AppColors.greyColor),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            color: AppColors.whiteColor,
                            child: Column(
                              children: state.itemCarts
                                  .map((e) => Column(
                                        children: [
                                          _InlineItemCartToOrder(itemCart: e),
                                          const Divider(),
                                        ],
                                      ))
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: padding),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tổng số tiền (3 sản phẩm)'),
                                Text(
                                  state.totalPrice,
                                  style: GoogleFonts.nunito(
                                      color: AppColors.redColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          meDivider(),
                          paymentMethodWidget(context),
                          meDivider(),
                          Container(
                              color: AppColors.whiteColor,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: componentDetailPrice(
                                  context,
                                  state.subTotalPrice,
                                  state.totalPrice,
                                  state.shippingPrice)),
                          meDivider(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: padding, vertical: 20),
                            color: AppColors.whiteColor,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(MaterialCommunityIcons.note_outline),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                          style: GoogleFonts.nunito(
                                              color: AppColors.blackColor),
                                          children: [
                                        const TextSpan(
                                            text:
                                                'Nhấn "Đặt hàng" đồng nghĩa với việc bạn đồng ý tuân theo '),
                                        TextSpan(
                                            text: 'Điều khoản BOOKECOMMERCE.',
                                            style: GoogleFonts.nunito(
                                                color: AppColors.primaryColor)),
                                      ])),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )));
              },
            ),
            BlocBuilder<CartToOrderCubit, CartToOrderState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingWidget(isBlurScreen: true);
                }
                return Container();
              },
            )
          ],
        );
      },
    );
  }

  Widget paymentMethodWidget(context) {
    return InkWell(
      onTap: () {
        GoRouter.of(context).push(
            '${Paths.cartScreen}/${Paths.cartToOrderScreen}/${Paths.paymentMethodScreen}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(MaterialCommunityIcons.cash),
                SizedBox(width: 10),
                Text('Phương thức thanh toán'),
              ],
            ),
            Row(
              children: [
                const SizedBox(width: 30),
                BlocBuilder<CartToOrderCubit, CartToOrderState>(
                  buildWhen: (previous, current) =>
                      previous.paymentMethod != current.paymentMethod,
                  builder: (context, state) {
                    // Logger().i(state.paymentMethod);
                    if (state.paymentMethod == 'cod') {
                      return const Text('Thanh toán khi nhận hàng');
                    } else {
                      return const Text('Thanh toán qua Paypal');
                    }
                  },
                ),
                Icon(MaterialCommunityIcons.chevron_right,
                    color: AppColors.greyColor),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container bottomAppBar(String price) {
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
              children: [
                Column(
                  children: [
                    Text(price,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.redColor)),
                  ],
                ),
              ],
            ),
            BlocBuilder<CartToOrderCubit, CartToOrderState>(
              buildWhen: (previous, current) =>
                  previous.paymentMethod != current.paymentMethod,
              builder: (context, state) {
                return ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.blueColor),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ))),
                    onPressed: () =>
                        context.read<CartToOrderCubit>().paymentClick(context),
                    child: const Text('Thanh toán'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget componentDetailPrice(
      context, String subTotalPrice, String totalPrice, String shippingPrice) {
    return Column(
      children: [
        Row(
          children: const [
            Icon(MaterialCommunityIcons.note_text_outline),
            SizedBox(width: 10),
            Text('Chi tiết thanh toán'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tổng tiền hàng'),
            Text(subTotalPrice),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Tổng tiền phí vận chuyển'),
            Text(shippingPrice),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng thanh toán', style: GoogleFonts.nunito(fontSize: 16)),
            Text(
              totalPrice,
              style:
                  GoogleFonts.nunito(fontSize: 16, color: AppColors.redColor),
            )
          ],
        ),
      ],
    );
  }

  Widget meDivider() {
    return Container(height: 5, color: AppColors.whiteGreyColor);
  }
}

class _InlineItemCartToOrder extends StatelessWidget {
  final ItemCart itemCart;
  const _InlineItemCartToOrder({required this.itemCart});

  @override
  Widget build(BuildContext context) {
    const padding = 10.0;
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    final String nameSeller = itemCart.sellerName;
    final String productImageUrl = itemCart.productImage;
    final String productPrice = formatCurrency
        .format(itemCart.price * (100 - itemCart.discountPercent) / 100);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 5),
          child: Row(
            children: [
              const Icon(MaterialCommunityIcons.store_outline),
              const SizedBox(width: 10),
              Text(
                nameSeller,
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          // color: AppColors.whiteGreyColor,
          padding:
              const EdgeInsets.symmetric(horizontal: padding, vertical: 10),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: productImageUrl,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemCart.name,
                      style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productPrice),
                        Text('x${itemCart.quantity}'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
