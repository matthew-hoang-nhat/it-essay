import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/ui/book_store_screen/store_viewmodel.dart';
import 'package:it_project/src/ui/home_screen/search_bar.dart';
import 'package:it_project/src/ui/widgets/ad_post.dart';
import 'package:it_project/src/ui/widgets/tag/tag.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_dimensions.dart';

class StoreScreen extends GetView<StoreViewModel> {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    searchBar(),
                  ],
                ),
              ),
              recommendation(),
              const SizedBox(
                height: 20,
              ),
              genres(),
              trendingBook(),
            ],
          ),
        ),
      ),
    );
  }

  Column genres() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Geners',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            fontSize: AppDimensions.dp20,
          ),
        ),
        Wrap(
          runSpacing: 5,
          spacing: 10,
          children: const [
            Tag(text: 'Education'),
            Tag(text: 'Education'),
            Tag(text: 'Education'),
            Tag(text: 'Education'),
          ],
        )
      ],
    );
  }

  Column recommendation() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recommendations',
                  style: GoogleFonts.nunito(
                      fontSize: AppDimensions.dp20,
                      fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('See all'))
            ],
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Column trendingBook() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trending Books',
                  style: GoogleFonts.nunito(
                      fontSize: AppDimensions.dp20,
                      fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text('See all'))
            ],
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
              AdPost(),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        )
      ],
    );
  }

  Row searchBar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SearchBar(
              textEditingController: TextEditingController(),
            ),
          ),
          const SizedBox(
            width: AppDimensions.dp20,
          ),
          Image.asset(
            AppAssets.icCart,
            width: 30,
          ),
        ],
      );
}
