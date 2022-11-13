import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matthew'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Đơn hàng'),
          Text('Địa chỉ'),
          Text('Thẻ ngân hàng'),
          Text('Đăng xuất'),
        ],
      )),
    );
  }
}
