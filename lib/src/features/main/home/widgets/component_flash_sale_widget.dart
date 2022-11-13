import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';
import 'package:it_project/src/features/main/home/widgets/flash_sale_widget.dart';

class ComponentFlashSaleWidget extends StatelessWidget {
  const ComponentFlashSaleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeCubit>();
    bloc.getFlashSaleProducts();

    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.7) {
        bloc.loadPage(HomeEnum.flashSaleProducts);
      }
    });

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.flashSaleProducts != current.flashSaleProducts,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: AppColors.whiteColor,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Giá sốc HÔM NAY',
                      style: GoogleFonts.nunito(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('XEM THÊM',
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor))
                  ],
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.flashSaleProducts.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = state.flashSaleProducts.elementAt(index);
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: FlashSaleWidget(product: product),
                        );
                      }
                      return FlashSaleWidget(product: product);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
