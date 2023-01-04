import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/cubit/pre_search_cubit.dart';
import 'package:it_project/src/features/search/screens/detail_search_screen.dart';

import '../../../configs/constants/app_colors.dart';

class SearchBarPreWidget extends StatelessWidget {
  const SearchBarPreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final outLine = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5),
    );
    return BlocBuilder<PreSearchCubit, PreSearchState>(
      builder: (contextCubit, state) {
        return TextField(
            // focusNode: context.read<SearchCubit>().focusNode,
            controller: contextCubit.read<PreSearchCubit>().searchController,
            onChanged: (value) {
              contextCubit.read<PreSearchCubit>().onSearchChanged();
            },
            onSubmitted: (value) {
              context.push(
                  '${Paths.preSearchScreen}/${Paths.sDetailSearchScreen}',
                  extra: {
                    DetailSearchExtraEnum.searchText: value,
                  });
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(),
              filled: true,
              fillColor: AppColors.whiteColor,
              alignLabelWithHint: true,
              border: outLine,
              enabledBorder: outLine,
              focusedBorder: outLine,
              labelStyle: GoogleFonts.nunito(color: AppColors.brownColor),
              hintText:
                  'Warren Buffett: 22 thương vụ đầu tiên và bài học đắt giá từ những sai lầm',
              prefixIcon: Icon(
                MaterialCommunityIcons.crosshairs,
                color: AppColors.greyColor,
              ),
            ));
      },
    );
  }
}
