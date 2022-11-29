part of 'seller_cubit.dart';

abstract class SellerState extends Equatable {
  const SellerState({
    required this.products,
    required this.isEmpty,
    required this.tabIndex,
    required this.profileSeller,
    required this.productsOfCategory,
    required this.categories,
    required this.isLoading,
  });

  final List<Product> products;
  final Map<String, List<Product>> productsOfCategory;
  final List<Category> categories;
  final bool isEmpty;
  final bool isLoading;
  final int tabIndex;

  final ProfileSeller profileSeller;

  // final Map<String, String> meLocalKey;

  @override
  List<Object> get props => [
        products,
        tabIndex,
        categories,
        isLoading,
        productsOfCategory,
        profileSeller
      ];
}

class DetailSellerInitial extends SellerState {
  const DetailSellerInitial({
    required super.products,
    required super.productsOfCategory,
    required super.categories,
    required super.tabIndex,
    required super.isEmpty,
    required super.isLoading,
    // required super.controller,
    required super.profileSeller,
  });
}

class NewSellerState extends SellerState {
  NewSellerState.fromOldSettingState(
    SellerState oldState, {
    List<Product>? products,
    List<Category>? categories,
    bool? isEmpty,
    bool? isLoading,
    Map<String, List<Product>>? productsOfCategory,
    int? tabIndex,
    ProfileSeller? profileSeller,
  }) : super(
          categories: categories ?? oldState.categories,
          productsOfCategory: productsOfCategory ?? oldState.productsOfCategory,
          products: products ?? oldState.products,
          isEmpty: isEmpty ?? oldState.isEmpty,
          isLoading: isLoading ?? oldState.isLoading,
          tabIndex: tabIndex ?? oldState.tabIndex,
          profileSeller: profileSeller ?? oldState.profileSeller,
        );
}
