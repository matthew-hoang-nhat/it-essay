// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_search_cubit.dart';

class DetailSearchState extends Equatable {
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

  DetailSearchState copyWith({
    List<Product>? products,
    bool? isLoading,
  }) {
    return DetailSearchState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }
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
