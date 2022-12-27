// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_cubit.dart';

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

class SearchState extends Equatable {
  const SearchState({
    required this.products,
    required this.isLoading,
    required this.isLoadingMore,
    required this.typeFilters,
    required this.typeSearch,
    required this.onTypeFilter,
    required this.valueTypeFilters,
    required this.valuesTypeFilters,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<Product> products;
  final TypeSearchEnum typeSearch;
  final List<TypeSearchFilterEnum> typeFilters;
  final TypeSearchFilterEnum? onTypeFilter;
  final Map<TypeSearchFilterEnum, dynamic> valuesTypeFilters;
  final Map<TypeSearchFilterEnum, dynamic> valueTypeFilters;

  @override
  List<Object?> get props => [
        isLoading,
        products,
        isLoadingMore,
        typeFilters,
        typeSearch,
        onTypeFilter,
        valueTypeFilters,
        valuesTypeFilters,
      ];

  SearchState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<Product>? products,
    TypeSearchEnum? typeSearch,
    List<TypeSearchFilterEnum>? typeFilters,
    Wrapped<TypeSearchFilterEnum?>? onTypeFilter,
    Map<TypeSearchFilterEnum, dynamic>? valuesTypeFilters,
    Map<TypeSearchFilterEnum, dynamic>? valueTypeFilters,
  }) {
    return SearchState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      typeFilters: typeFilters ?? this.typeFilters,
      typeSearch: typeSearch ?? this.typeSearch,
      onTypeFilter:
          onTypeFilter != null ? onTypeFilter.value : this.onTypeFilter,
      valueTypeFilters: valueTypeFilters ?? this.valueTypeFilters,
      valuesTypeFilters: valuesTypeFilters ?? this.valuesTypeFilters,
    );
  }
}

class SearchInitial extends SearchState {
  const SearchInitial({
    required super.products,
    required super.isLoading,
    required super.onTypeFilter,
    required super.isLoadingMore,
    required super.typeFilters,
    required super.typeSearch,
    required super.valueTypeFilters,
    required super.valuesTypeFilters,
  });
}
