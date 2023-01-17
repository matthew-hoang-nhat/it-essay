import 'package:it_project/src/utils/remote/model/review/review.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/services/review/review_service.dart';

abstract class ReviewRepository {
  final ReviewService reviewService;
  ReviewRepository({required this.reviewService});

  Future<FResult<String>> createNewReview(
      {required String productId,
      required String body,
      required List<String> attaches,
      required double ratingNumber});

  Future<FResult<List<Review>>> getReviewsOfAProduct(
      {required String idProduct, required int numberPage});

  Future<FResult<bool>> isBoughtProduct({required String idProduct});
  Future<FResult<String>> deleteReview(
      {required int discussId, required int page, required String productId});
}
