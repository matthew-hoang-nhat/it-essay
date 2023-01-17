import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/services/f_result.dart';
import 'package:it_project/src/utils/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl({
    required super.categoryService,
  });
  final limitSProduct = 5;
  final limitLProduct = 10;

  @override
  Future<FResult<List<Category>>> getCategories() async {
    try {
      final dataResponse = await categoryService.getCategoriesPage();
      final List<dynamic> dataItems = dataResponse.data;
      List<Category> categories = List.generate(dataItems.length,
          (index) => Category.fromJson(dataItems.elementAt(index)));
      return FResult.success(categories);
    } catch (ex) {
      if (ex is DioError) {
        log('getCategories: ${ex.error}');
      }
      return FResult.error(ex.toString());
    }
  }
}
