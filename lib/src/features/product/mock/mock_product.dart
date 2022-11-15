import 'package:it_project/src/utils/remote/model/category/category.dart';
import 'package:it_project/src/utils/remote/model/product/info_data.dart';
import 'package:it_project/src/utils/remote/model/product/logo_data.dart';
import 'package:it_project/src/utils/remote/model/product/product.dart';
import 'package:it_project/src/utils/remote/model/product/product_picture.dart';
import 'package:it_project/src/utils/remote/model/product/seller.dart';
import 'package:it_project/src/utils/remote/model/product/spec.dart';

final mockSaleProduct = Product(
    id: '6362adfb1b406f830c670f44',
    price: 200000,
    name: 'Chú dế mèn kêu sale',
    category: Category(name: 'Sách thiếu nhi', slug: ''),
    productImages: [
      ProductPicture(fileLink: ''),
      ProductPicture(fileLink: ''),
      ProductPicture(fileLink: ''),
    ],
    seller: Seller(
        infoData: InfoData(name: 'Nhà sách nhi đồng'),
        logoData: LogoData(
            fileLink:
                'https://drive.google.com/uc?id=1hJkrFBM06ECCNxnLu_FkdcCXvWBHYJ8f'),
        userId: ''),
    slug: '123',
    spec: Spec(
        author: 'Bảo trần',
        publisher: 'bao tran',
        city: 'Hồ Chí Minh',
        publicationDate: '04/12/2000'),
    discountPercent: 20,
    description:
        'Đắc nhân tâm của Dale Carnegie là quyển sách nổi tiếng nhất, bán chạy nhất và có tầm ảnh hưởng nhất của mọi thời đại. Tác phẩm đã được chuyển ngữ sang hầu hết các thứ tiếng trên thế giới và có mặt ở hàng trăm quốc gia. Đây là quyển sách duy nhất về thể loại self-help liên tục đứng đầu danh mục sách bán chạy nhất (best-selling Books) do báo The New York Times bình chọn suốt 10 năm liền.',
    summary: '');

final mockProduct = Product(
    id: '6362adfb1b406f830c670f44',
    price: 200000,
    name: 'Chú dế mèn kêu',
    category: Category(name: 'Sách thiếu nhi', slug: ''),
    productImages: [
      ProductPicture(fileLink: ''),
      ProductPicture(fileLink: ''),
      ProductPicture(fileLink: ''),
    ],
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
    discountPercent: 0,
    description: '',
    summary: '');
