import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/info_data.dart';
import 'package:it_project/src/utils/remote/model/product/logo_data.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/seller.dart';
import 'package:it_project/src/utils/remote/model/product/spec.dart';

final mockProduct = Product(
    id: '6362adfb1b406f830c670f44',
    price: 200000,
    name: 'Chú dế mèn kêu chú dế mèn kêu Chú dế mèn kêu',
    category: Category(id: '12', name: 'Sách thiếu nhi', slug: ''),
    productImages: [],
    seller: Seller(
        infoData: InfoData(name: 'Nhà sách nhi đồng'),
        logoData: LogoData(fileLink: ''),
        userId: ''),
    slug: '123',
    spec: Spec(
        author: 'Bảo trần',
        publisher: 'bao tran',
        city: 'Hồ Chí Minh',
        publicationDate: '04/12/2000'),
    discountPercent: 20);
