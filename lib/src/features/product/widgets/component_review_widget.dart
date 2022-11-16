import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/product/cubit/product_cubit.dart';
import 'package:it_project/src/features/product/widgets/item_review_widget.dart';
import 'package:it_project/src/widgets/start_widget.dart';

class ComponentReviewWidget extends StatelessWidget {
  const ComponentReviewWidget({
    super.key,
    this.productSlug = '',
  });
  final String productSlug;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProductCubit>();
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
                  Text(product.name,
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
              Text('(423 đánh giá)',
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
          const SizedBox(height: 20),
          reviews(),
        ],
      ),
    );
  }

  reviews() {
    final items = [
      'Mặc định',
      'Hehe',
      'hihi',
    ];

    var value = items.first;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('SẮP XẾP THEO'),
            DropdownButton<String>(
                items: items
                    .map((String e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                value: value,
                onChanged: (value) {
                  print(value);
                }),
            // Container(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(100),
            //       color: AppColors.greyColor.withOpacity(0.5)),
            //   child: const Text('Default'),
            // ),
          ],
        ),
        const ItemReviewWidget(),
        const ItemReviewWidget(),
      ],
    );
  }
}
