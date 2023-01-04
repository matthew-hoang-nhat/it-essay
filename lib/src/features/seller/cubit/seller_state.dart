// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'seller_cubit.dart';

class SellerState extends Equatable {
  const SellerState({
    required this.products,
    required this.isEmpty,
    required this.tabIndex,
    required this.profileSeller,
    required this.productsOfCategory,
    required this.categories,
    required this.isLoadingProducts,
    required this.isLoading,
  });

  final List<Product> products;
  final Map<String, List<Product>> productsOfCategory;
  final List<Category> categories;
  final bool isEmpty;
  final bool isLoading;
  final bool isLoadingProducts;
  final int tabIndex;

  final ProfileSeller profileSeller;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [
        products,
        tabIndex,
        categories,
        isLoading,
        isLoadingProducts,
        productsOfCategory,
        profileSeller
      ];

  SellerState copyWith({
    List<Product>? products,
    Map<String, List<Product>>? productsOfCategory,
    List<Category>? categories,
    bool? isEmpty,
    bool? isLoading,
    bool? isLoadingProducts,
    int? tabIndex,
    ProfileSeller? profileSeller,
  }) {
    return SellerState(
      products: products ?? this.products,
      productsOfCategory: productsOfCategory ?? this.productsOfCategory,
      categories: categories ?? this.categories,
      isEmpty: isEmpty ?? this.isEmpty,
      isLoading: isLoading ?? this.isLoading,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      tabIndex: tabIndex ?? this.tabIndex,
      profileSeller: profileSeller ?? this.profileSeller,
    );
  }
}

class DetailSellerInitial extends SellerState {
  const DetailSellerInitial({
    required super.products,
    required super.productsOfCategory,
    required super.categories,
    required super.isLoadingProducts,
    required super.tabIndex,
    required super.isEmpty,
    required super.isLoading,
    // required super.controller,
    required super.profileSeller,
  });
}
