import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_project/main.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/features/product/models/attach.dart';

import 'package:it_project/src/utils/repository/review_repository_impl.dart';
import 'package:it_project/src/utils/repository/up_file_repository_impl.dart';

part 'create_review_state.dart';

enum CreateReviewCubitEnum {
  attaches,
  ratingNumber,
}

class CreateReviewCubit extends Cubit<CreateReviewState> {
  CreateReviewCubit(String productId)
      : super(CreateReviewInitial(
          productId: productId,
          isLoading: false,
          ratingNumber: 5,
          attaches: const [],
        ));
  final reviewRepo = getIt<ReviewRepositoryImpl>();

  final bodyController = TextEditingController();

  addImageOnClick() async {
    final ImagePicker picker = ImagePicker();
    await picker.pickMultiImage().then((xFiles) {
      if (xFiles.isNotEmpty) {
        final filePaths = [
          for (var i = 0; i < xFiles.length && i < 2; i++) xFiles[i].path
        ];
        emit(state.copyWith(
            attaches: filePaths.map((e) => Attach(pathLocalUrl: e)).toList()));
      }
      return null;
    });
  }

  removeAttach(attach) {
    final newAttaches = List<Attach>.from(state.attaches);
    newAttaches.remove(attach);
    emit(state.copyWith(attaches: newAttaches));
  }

  final upFileRepo = getIt<UpFileRepositoryImpl>();

  bool isInvalid() {
    if (bodyController.text.isEmpty) return true;
    return false;
  }

  checkValidate() {
    if (bodyController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Bạn chưa nhập nội dung đánh giá',
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor);
    }
  }

  createNewReview(context, onSuccess) async {
    if (isInvalid()) {
      checkValidate();
      return;
    }

    emit(state.copyWith(isLoading: true));

    final resultImageLinks = await Future.wait(state.attaches
        .map((e) => upFileRepo.uploadFile(XFile(e.pathLocalUrl!)))
        .toList());

    final result = await reviewRepo.createNewReview(
        body: bodyController.text,
        attaches: resultImageLinks.map((e) => e.data!).toList(),
        ratingNumber: state.ratingNumber,
        productId: state.productId);

    // await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
    if (result.isSuccess) {
      Fluttertoast.showToast(msg: 'Đánh giá của bạn đã được ghi nhận');
      onSuccess();
      Navigator.of(context).pop();

      // GoRouter.of(context).pop();
    }

    if (result.isError) {
      Fluttertoast.showToast(
          msg: 'Thêm review thất bại',
          backgroundColor: AppColors.redColor,
          textColor: AppColors.whiteColor);
      return false;
    }

    return false;
  }

  setField(CreateReviewCubitEnum key, {required value}) {
    switch (key) {
      case CreateReviewCubitEnum.attaches:
        emit(state.copyWith(attaches: value));
        break;
      case CreateReviewCubitEnum.ratingNumber:
        emit(state.copyWith(ratingNumber: value));

        break;
      default:
    }
  }

  @override
  void emit(CreateReviewState state) {
    if (isClosed) return;
    super.emit(state);
  }
}
