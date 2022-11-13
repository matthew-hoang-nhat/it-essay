import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_project/src/features/category/cubit/category_cubit.dart';
import 'package:it_project/src/widgets/category_widget.dart';

class ComponentCategoryVerticalWidget extends StatelessWidget {
  const ComponentCategoryVerticalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
        bloc: context.read<CategoryCubit>(),
        // buildWhen: (previous, current) => previous.products != current.products,
        builder: (context, state) {
          // if (state.isShowProducts == false) return Container();
          final categories = state.categories;
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Wrap(
                // alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                runSpacing: 10,
                children: categories
                    .map((e) => CategoryWidget(
                          category: e,
                          size: MediaQuery.of(context).size.width * 2 / 7,
                        ))
                    .toList(),
              ));

          //    ListView.builder(
          //       shrinkWrap: true,
          //       physics: const NeverScrollableScrollPhysics(),
          //       scrollDirection: Axis.vertical,
          //       itemCount: categories.length,
          //       itemBuilder: (context, index) {
          //         if (index % 2 != 0) return Container();
          //         final categoryOdd = categories[index];
          //         final categoryEven = (index + 1 <= categories.length - 1)
          //             ? categories[index + 1]
          //             : null;
          //         return Container(
          //           margin: const EdgeInsets.symmetric(vertical: 2.5),
          //           child: Row(
          //             children: [
          //               Flexible(
          //                 child: InkWell(
          //                     onTap: () {
          //                       context.push(Paths.productScreen,
          //                           extra: categoryOdd);
          //                     },
          //                     child: CategoryWidget(
          //                       category: categoryOdd,
          //                     )
          //                     // ProductWidget(
          //                     //   product: BriefProductModel(
          //                     //       mainCategory: productOdd.category.name,
          //                     //       name: productOdd.name,
          //                     //       price: productOdd.price,
          //                     //       productImage:
          //                     //           productOdd.productImages.first.fileLink,
          //                     //       discountPercent: productOdd.discountPercent),
          //                     //   isHeart: false,
          //                     //   isBorder: true,
          //                     // ),
          //                     ),
          //               ),
          //               const SizedBox(width: 5),
          //               categoryEven == null
          //                   ? Flexible(child: Container())
          //                   : Flexible(
          //                       child: InkWell(
          //                           onTap: () {
          //                             context.push(Paths.productScreen,
          //                                 extra: categoryEven);
          //                           },
          //                           child: CategoryWidget(
          //                             category: categoryEven,
          //                           )
          //                           //  ProductWidget(
          //                           //   product: BriefProductModel(
          //                           //       mainCategory:
          //                           //           categoryEven.category.name,
          //                           //       name: categoryEven.name,
          //                           //       price: categoryEven.price,
          //                           //       productImage: categoryEven
          //                           //           .productImages.first.fileLink,
          //                           //       discountPercent:
          //                           //           categoryEven.discountPercent),
          //                           //   isHeart: false,
          //                           //   isBorder: true,
          //                           // ),
          //                           ),
          //                     ),
          //             ],
          //           ),
          //         );
          //       }),
          // );
        });
  }
}