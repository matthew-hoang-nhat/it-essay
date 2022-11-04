import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/main/home/search/search_viewmodel.dart';
import 'package:it_project/src/features/main/search_bar.dart';

import '../../../../utils/app_pages.dart';
import '../../../../widgets/category_widget.dart';
import '../../../../widgets/product_general/product_general_model.dart';

class SearchScreen extends GetView<SearchViewModel> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      // appBar: AppBar(
      //   title: const Text('Search'),
      //   actions: [

      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  color: AppColors.greyColor,
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage(AppAssets.fkImHarryPotter1),
                  //         opacity: 0.5,
                  //         fit: BoxFit.cover)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search',
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  Get.toNamed(AppPages.cartScreen,
                                      arguments: mockProductGeneralModel);
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: const Icon(
                                    MaterialCommunityIcons.cart,
                                    size: 20,
                                  ),
                                ))
                          ],
                        ),
                        SearchBar(
                            textEditingController: TextEditingController()),
                        const SizedBox(height: 20),
                        Text('MEGASALE',
                            style: GoogleFonts.shrikhand(
                                fontSize: 30, color: Colors.orange)),
                        Text('FASHION',
                            style: GoogleFonts.nunito(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColors.brownColor),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.symmetric(horizontal: 50)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ))),
                            child: const Text('See All'),
                            onPressed: () {})
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Image.asset(
                    AppAssets.imgPersonBook,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  // Icon(
                  //   MaterialCommunityIcons.book,
                  //   size: 100,
                  //   color: AppColors.whiteColor,
                  // ),
                )
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  categoryWidget('hehe'),
                  const SizedBox(width: 10),
                  categoryWidget('hehe'),
                  const SizedBox(width: 10),
                  categoryWidget('hehe'),
                  const SizedBox(width: 10),
                  categoryWidget('hehe'),
                  const SizedBox(width: 10),
                  categoryWidget('hehe'),
                  const SizedBox(width: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text('SALE',
                      style: GoogleFonts.nunito(color: AppColors.redColor)),
                  const Divider(),
                  lineText('NEW IN'),
                  lineText('Clothes'),
                  lineText('Shoe'),
                  lineText('Accessories & Bags'),
                  lineText('Beach Wear'),
                  lineText('Cosmetics & Personal Care'),
                  lineText('BEST DEAL'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  lineText(title) {
    final whiteGrey = AppColors.greyColor.withOpacity(0.2);
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title),
        Icon(
          MaterialCommunityIcons.chevron_right,
          color: whiteGrey,
        )
      ]),
      Divider(
        color: whiteGrey,
      ),
    ]);
  }
}
