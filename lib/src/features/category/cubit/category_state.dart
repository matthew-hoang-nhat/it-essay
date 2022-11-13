part of 'category_cubit.dart';

abstract class CategoryState extends Equatable {
  const CategoryState({
    required this.categories,
  });

  final List<Category> categories;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [categories];
}

class CategoryInitial extends CategoryState {
  const CategoryInitial({
    required super.categories,
  });
}

class NewCategoryState extends CategoryState {
  NewCategoryState.fromOldSettingState(
    CategoryState oldState, {
    List<Category>? categories,
    String? slugCategory,
  }) : super(
          categories: categories ?? oldState.categories,
        );
}
