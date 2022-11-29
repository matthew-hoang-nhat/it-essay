import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/seller/profile_seller.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';
import 'package:it_project/src/utils/remote/services/seller/seller_service.dart';

abstract class SellerRepository {
  final SellerService sellerService;
  SellerRepository({required this.sellerService});

  Future<FResult<List<Category>>> getCategories({required String sellerId});
  Future<FResult<List<Product>>> getProducts({
    required String sellerId,
    required int currentPage,
    String? categoryId,
    int? limit,
  });
  Future<FResult<ProfileSeller>> getInfo({required String sellerId});
}
