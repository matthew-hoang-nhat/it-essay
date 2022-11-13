var mockProductGeneralModel = BriefProductModel(
    mainCategory: 'Sách thiếu nhi',
    name: 'Chú dế mèn kêu phiêu lưu kí',
    price: 29000,
    discountPercent: 20,
    productImage: null);

class BriefProductModel {
  BriefProductModel({
    required this.name,
    required this.mainCategory,
    required this.price,
    required this.discountPercent,
    required this.productImage,
  });
  String name;
  String mainCategory;
  int price;
  int discountPercent;
  String? productImage;
}
