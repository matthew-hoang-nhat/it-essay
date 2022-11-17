// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:it_project/main.dart';
// import 'package:it_project/src/features/login_register/cubit/parent_cubit.dart';
// import 'package:it_project/src/utils/remote/model/product/product.dart';
// import 'package:it_project/src/utils/repository/product_repository.dart';
// import 'package:it_project/src/utils/repository/product_repository_impl.dart';

// part 'seller_state.dart';

// enum SellerEnum { products, isEmpty }

// class SellerCubit extends Cubit<SellerState>
//     implements ParentCubit<SellerEnum> {
//   SellerCubit({required String sellerId})
//       : super(DetailSellerInitial(
//           products: const [],
//           sellerId: sellerId,
//           isEmpty: false,
//           controller: ScrollController(),
//         ));
//   // ProductRepository productRepository = getIt<ProductRepositoryImpl>();
//   int _currentPageProducts = 0;
//   bool isLoadingProducts = false;

//   settingController() {
//     state.controller.addListener(() {
//       if (state.controller.position.pixels >=
//           state.controller.position.maxScrollExtent * 0.7) {
//         loadProducts();
//       }
//     });
//   }

//   void loadProducts() {
//     if (isLoadingProducts) return;
//     _currentPageProducts++;
//     _getProducts();
//   }

//   void _getProducts() async {
//     isLoadingProducts = true;
//     final productsResponse = await productRepository.getProductsOfSeller(
//       numberPage: _currentPageProducts,
//       sellerId: state.sellerId,
//     );

//     if (productsResponse.isSuccess) {
//       addNewEvent(
//           SellerEnum.products, [...state.products, ...productsResponse.data!]);
//     }

//     if (productsResponse.isError) {
//       _currentPageProducts--;
//     }

//     isLoadingProducts = false;
//   }

//   @override
//   void addNewEvent(SellerEnum key, value) {
//     if (isClosed) return;
//     switch (key) {
//       case SellerEnum.products:
//         emit(NewSellerState.fromOldSettingState(state, products: value));
//         break;
//       case SellerEnum.isEmpty:
//         emit(NewSellerState.fromOldSettingState(state, isEmpty: value));
//         break;
//       default:
//     }
//   }
// }
