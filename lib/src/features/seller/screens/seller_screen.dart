// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/search/widgets/concrete_search_bar.dart';
import 'package:it_project/src/features/seller/cubit/seller_cubit.dart';
import 'package:it_project/src/features/seller/screens/seller_tab_category.dart';
import 'package:it_project/src/features/seller/screens/seller_tab_product.dart';
import 'package:it_project/src/features/seller/screens/seller_tab_shop.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';
import 'package:it_project/src/widgets/cart_button.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/start_widget.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({
    Key? key,
    required this.profileSeller,
  }) : super(key: key);
  final ProfileSeller profileSeller;

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen>
    with TickerProviderStateMixin {
  final tabViews = [
    const SellerTabShop(),
    const SellerTabProduct(),
    const SellerTabCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>[
      'Shop',
      'Sản phẩm',
      'Danh mục',
    ];

    return BlocProvider(
        create: (context) =>
            SellerCubit(profileSeller: widget.profileSeller)..initCubit(),
        child: Stack(
          children: [
            BlocBuilder<SellerCubit, SellerState>(
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: AppColors.whiteGreyColor,
                  body: CustomScrollView(
                      controller: context.read<SellerCubit>().controller,
                      slivers: [
                        SliverAppBar(
                          backgroundColor: AppColors.primaryColor,
                          expandedHeight: 300.0,
                          stretch: true,
                          pinned: true,
                          // centerTitle: true,
                          title: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                      onTap: () {
                                        context.push(Paths.searchScreen);
                                      },
                                      child: concreteSearchBar(context))),
                              const CartButton()
                            ],
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: briefInfoSeller(500.0),
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.blurBackground,
                              StretchMode.fadeTitle
                            ],
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate.fixed([
                            tabBar(context, tabs),
                            contentPage(context),
                          ]),
                        ),
                      ]),
                );
              },
            ),
            BlocBuilder<SellerCubit, SellerState>(
              builder: (context, state) {
                if (state.isLoading) return const LoadingWidget();
                return Container();
              },
            )
          ],
        ));
  }

  BlocBuilder<SellerCubit, SellerState> contentPage(BuildContext context) {
    return BlocBuilder<SellerCubit, SellerState>(
      bloc: context.read<SellerCubit>(),
      buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
      builder: (context, state) {
        return tabViews[state.tabIndex];
      },
    );
  }

  Container tabBar(BuildContext context, List<String> tabs) {
    return Container(
      color: AppColors.whiteColor,
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 1,
        indicatorPadding:
            const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.black87,
        onTap: (value) {
          context.read<SellerCubit>().setTabIndex(value);
        },
        tabs: tabs
            .map((e) => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      color: AppColors.brownColor,
                    ),
                  ),
                ))
            .toList(),
        controller: TabController(length: 3, vsync: this),
      ),
    );
  }

  briefInfoSeller(double height) {
    return BlocBuilder<SellerCubit, SellerState>(
      buildWhen: (previous, current) =>
          previous.profileSeller != current.profileSeller,
      builder: (context, state) {
        final profileSeller = state.profileSeller;
        return Stack(
          children: [
            Stack(children: <Widget>[
              SizedBox(
                  height: height,
                  child: profileSeller.logo?.fileLink == null
                      ? Container()
                      : CachedNetworkImage(
                          imageUrl: profileSeller.logo!.fileLink,
                          height: height,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
              Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          AppColors.blackColor.withOpacity(0.8),
                          AppColors.blackColor.withOpacity(0.2),
                          // Colors.grey.withOpacity(0.0),
                        ],
                        stops: const [
                          0.2,
                          1.0,
                        ])),
              )
            ]),
            Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(100)),
                            padding: const EdgeInsets.all(3),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: profileSeller.logo?.fileLink == null
                                    ? Container(
                                        color: AppColors.whiteColor,
                                        height: 100,
                                        width: 100,
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: profileSeller.logo!.fileLink,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                        Container(
                          color: AppColors.redColor,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'STORE',
                            style:
                                GoogleFonts.nunito(color: AppColors.whiteColor),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileSeller.info.name.toUpperCase(),
                            style: GoogleFonts.nunito(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          if (profileSeller.meta?.totalEvaluation != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  profileSeller.slogan == null
                                      ? ''
                                      : '"${profileSeller.slogan}"',
                                  style: GoogleFonts.nunito(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                    children: starWidget(
                                        profileSeller.meta!.ranking, 5,
                                        sizeStar: 20)),
                                Text(
                                  profileSeller.meta!.totalEvaluation == 0
                                      ? 'Chưa có đánh giá'
                                      : '${profileSeller.meta?.totalEvaluation.toString() ?? ''}+ lượt đánh giá',
                                  style: GoogleFonts.nunito(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
