import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/seller/cubit/seller_cubit.dart';
import 'package:it_project/src/features/seller/widgets/component_product_vertial_widget.dart';
import 'package:it_project/src/widgets/load_widget.dart';

class SellerTabProduct extends StatelessWidget {
  const SellerTabProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      bloc: context.read<SellerCubit>(),
      buildWhen: (previous, current) => previous.products != current.products,
      builder: (context, state) {
        return Container(
          color: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ComponentProductVerticalWidget(
                products: state.products,
              ),
              BlocBuilder<SellerCubit, SellerState>(
                buildWhen: (previous, current) =>
                    previous.isLoadingProducts != current.isLoadingProducts,
                builder: (context, state) {
                  if (state.isLoadingProducts) {
                    return const SizedBox(height: 50, child: LoadingWidget());
                  }
                  return Container();
                },
              )
            ],
          ),
        );
      },
    );
  }
}
