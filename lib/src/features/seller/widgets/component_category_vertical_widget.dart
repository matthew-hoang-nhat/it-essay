import 'package:flutter/material.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/widgets/category_widget.dart';

class ComponentCategoryVerticalWidget extends StatelessWidget {
  const ComponentCategoryVerticalWidget({
    Key? key,
    required this.categories,
  }) : super(key: key);
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: List.generate(
              categories.length,
              (index) => CategoryWidget(
                    category: categories[index],
                    height: 100,
                    width: 100,
                  )),
        )

        //  ListView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     scrollDirection: Axis.vertical,
        //     itemCount: categories.length,
        //     itemBuilder: (context, index) {
        //       if (index % 2 != 0) return Container();
        //       final categoryOdd = categories[index];
        //       final categoryEven = (index + 1 <= categories.length - 1)
        //           ? categories[index + 1]
        //           : null;
        //       return Container(
        //         margin: const EdgeInsets.symmetric(vertical: 2.5),
        //         child: Row(
        //           children: [
        //             Flexible(
        //               child: CategoryWidget(
        //                 category: categoryOdd,
        //                 height: 100,
        //                 width: 100,
        //               ),
        //             ),
        //             const SizedBox(width: 5),
        //             categoryEven == null
        //                 ? Flexible(child: Container())
        //                 : Flexible(
        //                     child: CategoryWidget(
        //                       category: categoryEven,
        //                       height: 100,
        //                       width: 100,
        //                     ),
        //                   ),
        //           ],
        //         ),
        //       );
        //     }),
        );
  }
}
