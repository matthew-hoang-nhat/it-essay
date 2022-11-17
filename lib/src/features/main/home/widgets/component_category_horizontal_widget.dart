import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home/cubit/home_cubit.dart';

import 'package:it_project/src/widgets/category_widget.dart';

class ComponentCategoryHorizontalWidget extends StatelessWidget {
  const ComponentCategoryHorizontalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeCubit>()..getCategories();

    final controller = ScrollController();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent * 0.7) {
        bloc.loadPage(HomeEnum.categories);
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Danh mục',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                InkWell(
                  onTap: () {
                    context.push(Paths.categoryScreen);
                  },
                  child: Container(
                    child: Text('XEM THÊM',
                        style: GoogleFonts.nunito(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<HomeCubit, HomeState>(
              bloc: bloc,
              builder: (context, state) {
                if (state.categories.isEmpty) return Container();
                final categories = state.categories;
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                      controller: controller,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CategoryWidget(
                              category: categories.elementAt(index),
                            ),
                          );
                        }
                        return CategoryWidget(
                          category: categories.elementAt(index),
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }
}
