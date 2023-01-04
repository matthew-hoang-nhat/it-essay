import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/order/cubit/cart_to_order_cubit.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phương thức thanh toán')),
      body: SafeArea(
        child: Column(children: [
          ListTile(
            onTap: () {
              context.read<CartToOrderCubit>().setPaymentMethod('paypal');

              context.pop();
            },
            leading: const Icon(MaterialCommunityIcons.card),
            title: const Text('Thẻ Paypal'),
            subtitle: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(AppAssets.imgLogoPaypal)),
            ),
          ),
          ListTile(
            onTap: () {
              context.read<CartToOrderCubit>().setPaymentMethod('cod');
              context.pop();
            },
            leading: const Icon(MaterialCommunityIcons.gift),
            title: const Text('Thanh toán khi nhận hàng'),
            subtitle: const Text(
                'Phí thu hộ: 0đ VNĐ. Ưu đãi về phí vận chuyển (nếu có) áp dụng cả với phí thu hộ'),
          ),
        ]),
      ),
    );
  }
}
