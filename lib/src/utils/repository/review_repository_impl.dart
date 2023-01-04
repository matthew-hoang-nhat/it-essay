import 'package:it_project/src/utils/remote/model/review/comment_review.dart';
import 'package:it_project/src/utils/remote/model/review/review.dart';
import 'package:it_project/src/utils/remote/model/review/review_request.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';

import 'package:it_project/src/utils/repository/review_repository.dart';
import 'package:logger/logger.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  ReviewRepositoryImpl({required super.reviewService});

  @override
  Future<FResult<String>> createNewReview(
      {required String productId,
      required String body,
      required List<String> attaches,
      required double ratingNumber}) async {
    // mockReviews.add(Review(id: title, ratingNumber: ratingNumber,  body));
    try {
      bool isHadReviews = true;
      final getReviewsResponse =
          await reviewService.getReviews(productId: productId, page: 1);
      if (getReviewsResponse.data == null) isHadReviews = false;

      final page = (isHadReviews == true) ? 1 : 0;
      final createReviewResponse = await reviewService.addReview(
          review: ReviewRequest(
              page: page,
              productId: productId,
              comment: CommentReview(
                ratingNumber: ratingNumber,
                text: body,
                attaches: attaches
                    .map((e) => {
                          "fileLink": e,
                          "fileId": e.substring(e.length - 5, e.length),
                        })
                    .toList(),
              )));
      return FResult.success('Thêm Review thành công');
    } catch (ex) {
      Logger().i(ex);
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<List<Review>>> getReviewsOfAProduct(
      {required String idProduct, required int numberPage}) async {
    try {
      final response = await reviewService.getReviews(
          productId: idProduct, page: numberPage);

      final List<Review> reviews = (response.data['comments'] as List)
          .map((e) => Review.fromJson(e))
          .toList();
      Logger().i(reviews);
      return FResult.success(reviews);
    } catch (ex) {
      return FResult.error(ex.toString());
    }
  }

  @override
  Future<FResult<bool>> isBoughtProduct({required String idProduct}) async {
    try {
      final response = await reviewService
          .checkPermission(orderIdObject: {"productId": idProduct});
      if (response.data != null) return FResult.success(true);
      return FResult.success(false);
    } catch (ex) {
      return FResult.success(false);
    }
  }

  @override
  Future<FResult<String>> deleteReview(
      {required int discussId,
      required int page,
      required String productId}) async {
    // try {
    await reviewService.deleteReview(deleteReviewRequest: {
      "page": page,
      "productId": productId,
      "discuss_id": discussId
    });
    return FResult.success('Xóa thành công');
    // } catch (ex) {
    //   return FResult.error('Xóa thất bại');
    // }
  }
}
