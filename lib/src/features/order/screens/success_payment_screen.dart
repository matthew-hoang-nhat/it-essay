import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';
import 'package:it_project/src/configs/routes/routes_name_app.dart';
import 'package:it_project/src/features/main/home/widgets/component_product_vertical.dart';

class SuccessPaymentScreen extends StatelessWidget {
  const SuccessPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                componentNotificationSuccessful(context),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child:
                            Container(height: 0.5, color: AppColors.greyColor)),
                    const SizedBox(width: 20),
                    const Text('Có thể bạn sẽ thích'),
                    const SizedBox(width: 20),
                    Flexible(
                        child:
                            Container(height: 0.5, color: AppColors.greyColor)),
                  ],
                ),
                const SizedBox(height: 20),
                const ComponentProductVertical()
              ],
            ),
          )),
    );
  }

  Container componentNotificationSuccessful(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MaterialCommunityIcons.alert_circle,
                color: AppColors.whiteColor,
              ),
              Text(
                'Chờ thanh toán',
                style: GoogleFonts.nunito(
                    color: AppColors.whiteColor, fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Cùng BOOKECOMMERCE bảo vệ quyền lợi của bạn - chỉ nhận hàng & thanh toán khi đơn mua ở trạng thái "Đang giao hàng',
              style: GoogleFonts.nunito(color: AppColors.whiteColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(Paths.mainScreen);
                  },
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          AppColors.whiteColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: const BorderSide(color: Colors.white)))),
                  child: const Text('Trang chủ'),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(
                        '${Paths.mainScreen}/${Paths.subHistoryOrderScreen}');
                  },
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              side: BorderSide(color: AppColors.whiteColor)))),
                  child: const Text('Đơn hàng'),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
