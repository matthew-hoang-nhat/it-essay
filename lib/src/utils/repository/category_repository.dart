import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/services/category/category_service.dart';
import 'package:it_project/src/utils/remote/services/fresult.dart';

abstract class CategoryRepository {
  final CategoryService categoryService;
  CategoryRepository({required this.categoryService});

  Future<FResult<List<Category>>> getCategories({required int numberPage});

  
}
