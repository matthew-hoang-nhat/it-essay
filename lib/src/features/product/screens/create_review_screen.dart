import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/widgets/load_widget.dart';
import 'package:it_project/src/widgets/matt.dart';

import '../cubit/create_review_cubit.dart';

enum CreateReviewExtraEnum { onSuccess, nameProduct, idProduct }

class CreateReviewScreen extends StatelessWidget {
  const CreateReviewScreen(
      {super.key,
      this.onSuccess,
      required this.idProduct,
      required this.nameProduct});
  final String idProduct;
  final String nameProduct;
  final Function()? onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateReviewCubit(idProduct),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameProduct,
                        style: GoogleFonts.nunito(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<CreateReviewCubit, CreateReviewState>(
                        buildWhen: (previous, current) =>
                            previous.ratingNumber != current.ratingNumber,
                        builder: (context, state) {
                          return RatingBar.builder(
                            initialRating: 5,
                            minRating: 1,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppColors.yellowColor,
                            ),
                            onRatingUpdate: (rating) {
                              context.read<CreateReviewCubit>().setField(
                                  CreateReviewCubitEnum.ratingNumber,
                                  value: rating);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<CreateReviewCubit, CreateReviewState>(
                        buildWhen: (previous, current) => false,
                        builder: (context, state) {
                          return TextFormField(
                            minLines: 5,
                            maxLines: 7,
                            controller: context
                                .read<CreateReviewCubit>()
                                .bodyController,
                            decoration: InputDecoration(
                              hintText: 'Nội dung review',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.greyColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.greyColor),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('* Chọn tối đa 2 ảnh'),
                      const SizedBox(height: 20),
                      BlocBuilder<CreateReviewCubit, CreateReviewState>(
                        buildWhen: (previous, current) =>
                            previous.attaches != current.attaches,
                        builder: (context, state) {
                          return SizedBox(
                            height: 150,
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              children: state.attaches
                                  .map<Widget>((attach) => Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Matt.imageInkwell(
                                              image: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.file(
                                                  File(attach.pathLocalUrl!),
                                                  height: 100,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              context: context,
                                              imageProvider: FileImage(
                                                  File(attach.pathLocalUrl!))),
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<CreateReviewCubit>()
                                                  .removeAttach(attach);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10, right: 10),
                                              child: Icon(
                                                MaterialCommunityIcons
                                                    .close_circle,
                                                color: AppColors.greyColor,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                  .toList()
                                ..add(InkWell(
                                  onTap: context
                                      .read<CreateReviewCubit>()
                                      .addImageOnClick,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                          height: 70,
                                          width: 70,
                                          color: AppColors.greyColor,
                                          child: Icon(
                                            MaterialCommunityIcons.camera,
                                            color: AppColors.whiteColor,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                )),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<CreateReviewCubit, CreateReviewState>(
                buildWhen: (previous, current) => false,
                builder: (blocContext, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          blocContext
                              .read<CreateReviewCubit>()
                              .createNewReview(context, onSuccess);
                        },
                        child: const Text(
                          'Đánh giá sản phẩm',
                        )),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
          BlocBuilder<CreateReviewCubit, CreateReviewState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading,
            builder: (context, state) {
              if (state.isLoading) return const LoadingWidget();
              return Container();
            },
          )
        ],
      ),
    );
  }
}
