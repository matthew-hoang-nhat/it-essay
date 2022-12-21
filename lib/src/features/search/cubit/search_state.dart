// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

class SearchState extends Equatable {
  const SearchState({
    required this.products,
    required this.contentSearches,
    required this.categories,
    required this.isLoading,
    required this.searchType,
    required this.minPrice,
    required this.categoryFilter,
    required this.typeFilter,
    required this.isLoadingMore,
    required this.sellerFilter,
  });
  final List<ContentSearch> contentSearches;
  final List<Category> categories;
  final Category? categoryFilter;

  final Map<String, String>? sellerFilter;
  final bool isLoading;
  final bool isLoadingMore;

  final SearchTypeFilterEnum typeFilter;
  final double minPrice;
  final SearchTypeEnum searchType;
  final List<Product> products;

  @override
  List<Object?> get props => [
        contentSearches,
        isLoading,
        categories,
        categoryFilter,
        sellerFilter,
        minPrice,
        typeFilter,
        products,
        isLoadingMore,
        searchType,
      ];

  SearchState copyWith({
    List<ContentSearch>? contentSearches,
    List<Category>? categories,
    Wrapped<Category?>? categoryFilter,
    Wrapped<Map<String, String>?>? sellerFilter,
    bool? isLoading,
    bool? isLoadingMore,
    SearchTypeFilterEnum? typeFilter,
    double? minPrice,
    SearchTypeEnum? searchType,
    List<Product>? products,
  }) {
    return SearchState(
      products: products ?? this.products,
      contentSearches: contentSearches ?? this.contentSearches,
      categories: categories ?? this.categories,
      minPrice: minPrice ?? this.minPrice,
      typeFilter: typeFilter ?? this.typeFilter,
      categoryFilter:
          categoryFilter != null ? categoryFilter.value : this.categoryFilter,
      sellerFilter:
          sellerFilter != null ? sellerFilter.value : this.sellerFilter,
      isLoading: isLoading ?? this.isLoading,
      searchType: searchType ?? this.searchType,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required super.contentSearches,
    required super.products,
    required super.isLoading,
    required super.typeFilter,
    required super.categories,
    required super.minPrice,
    required super.searchType,
    required super.categoryFilter,
    required super.sellerFilter,
    required super.isLoadingMore,
  });
}
