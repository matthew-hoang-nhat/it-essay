import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản và chính sách'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Điều khoản và chính sách',
                style: GoogleFonts.nunito(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                  """Bitini là sàn giao dịch thương mại điện tử và ứng dụng khuyến mại trực tuyến (được gọi tắt là “Sàn thương mại điện tử Bitini) cho phép tổ chức, cá nhân mua bán hàng hóa, dịch vụ trực tuyến.
        
Bitini được xây dựng nhằm đem lại cho khách hàng một tiện ích mua hàng trực tuyến tin cậy, tiết kiệm và thấu hiểu người dùng qua đó khách hàng có thể tìm kiếm thông tin trực tuyến về sách và/hoặc mua sắm hàng hoá, dịch vụ trực tuyến.
        
Sứ mệnh Bitini hướng tới là sẽ trở thành Sàn thương mại điện tử tin cậy trong thị trường Thương mại điện tử, là cầu nối thương mại giữa người bán và người mua và các sản phẩm được bán trên sàn thương mại điện tử Bitini là hàng sản xuất chính hãng."""),
              const SizedBox(height: 20),
              Text('Nguyên tắc chung', style: GoogleFonts.nunito(fontSize: 16)),
              const SizedBox(height: 10),
              const Text(
                  """1. Sàn thương mại điện tử Bitini được đăng ký hoạt động như sàn giao dịch thương mại điện tử và website khuyến mại trực tuyến do Công ty cổ phần Bitini sở hữu và vận hành. Thành viên trên sàn thương mại điện tử Bitini là các Nhà Bán Hàng và Khách Hàng mua hàng có đăng ký tài khoản sử dụng trên Bitini.

2. Nhà Bán Hàng là các tổ chức, cá nhân có hoạt động kinh doanh, thương mại hợp pháp được Bitini đồng ý cho phép đăng ký với tư cách Nhà Bán Hàng trên sàn thương mại điện tử Bitini nhằm tạo lập gian hàng giới thiệu, mua bán sản phẩm hoặc cung cấp voucher/phiếu khuyến mại trên Sàn TMĐT Bitini. Thông tin các Nhà Bán Hàng trên Bitini phải minh bạch, đầy đủ và chính xác.

3. Các Nhà Bán Hàng và Khách hàng thực hiện giao kết hợp đồng trên sàn thương mại điện tử Bitini trên cơ sở tôn trọng nguyên tắc tự do tự nguyện, tôn trọng quyền và lợi ích hợp pháp của các bên tham gia hoạt động mua bán sản phẩm, dịch vụ và không trái với qui định của pháp luật.

4. Hoạt động mua bán sản phẩm, dịch vụ qua Sàn TMĐT Bitini phải được thực hiện công khai, minh bạch, đảm bảo quyền lợi của người tiêu dùng.

5. Sản phẩm tham gia giao dịch trên Sàn TMĐT Bitini được đòi hỏi phải đáp ứng đầy đủ các quy định của pháp luật có liên quan, không thuộc các trường hợp cấm kinh doanh theo quy định của pháp luật.

6. Nhà Bán Hàng khi tham gia vào Sàn TMĐT Bitini phải tự tìm hiểu trách nhiệm pháp lý của mình đối với luật pháp hiện hành của Việt Nam, quy chế hoạt động và các chính sách, quy định khác của sàn thương mại điện tử Bitini và cam kết thực hiện đúng những quy định liên quan.""")
            ],
          ),
        ),
      )),
    );
  }
}
