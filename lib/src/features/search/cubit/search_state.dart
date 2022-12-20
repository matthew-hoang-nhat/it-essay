// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    required this.contentSearches,
    // required this.products,
    required this.categories,
    required this.isLoading,
    // required this.isEmpty,
    // required this.isShowProducts,
  });
  final List<ContentSearch> contentSearches;
  // final List<Product> products;
  final List<Category> categories;
  final bool isLoading;
  // final bool isEmpty;
  // final bool isShowProducts;
  @override
  List<Object> get props => [
        contentSearches,
        isLoading,
        // isEmpty,
        categories,
        // products,
        // isShowProducts,
      ];

  SearchState copyWith({
    List<ContentSearch>? contentSearches,
    List<Category>? categories,
    bool? isLoading,
  }) {
    return SearchState(
      contentSearches: contentSearches ?? this.contentSearches,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required super.contentSearches,
    // required super.products,
    required super.isLoading,
    // required super.isEmpty,
    required super.categories,
    // required super.isShowProducts,
  });
}
