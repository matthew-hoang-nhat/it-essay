part of 'detail_search_cubit.dart';

abstract class DetailSearchState extends Equatable {
  const DetailSearchState({
    // required this.contentSearches,
    required this.products,
    // required this.categories,
    required this.isLoading,
    // required this.isEmpty,
    // required this.isShowProducts,
  });
  // final List<ContentSearch> contentSearches;
  final List<Product> products;
  // final List<Category> categories;
  final bool isLoading;
  // final bool isEmpty;
  // final bool isShowProducts;
  @override
  List<Object> get props => [
        // contentSearches,
        isLoading,
        // isEmpty,
        // categories,
        products,
        // isShowProducts,
      ];
}

class DetailSearchInitial extends DetailSearchState {
  const DetailSearchInitial({
    // required super.contentSearches,
    required super.products,
    required super.isLoading,
    // required super.isLoading,
    // required super.isEmpty,
    // required super.categories,
    // required super.isShowProducts,
  });
}

class NewDetailSearchState extends DetailSearchState {
  NewDetailSearchState.fromOldSettingState(
    DetailSearchState oldState, {
    // List<ContentSearch>? contentSearches,
    List<Product>? products,
    // List<Category>? categories,
    bool? isLoading,
    // bool? isShowProducts,
    // bool? isEmpty,
  }) : super(
          // contentSearches: contentSearches ?? oldState.contentSearches,
          products: products ?? oldState.products,
          isLoading: isLoading ?? oldState.isLoading,
          // isEmpty: isEmpty ?? oldState.isEmpty,
          // categories: categories ?? oldState.categories,
          // isShowProducts: isShowProducts ?? oldState.isShowProducts,
        );
}
