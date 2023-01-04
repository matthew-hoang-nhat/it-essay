import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const nhatAvatarLink =
        'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/154563106_419115496057324_1972804520664458492_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=8bfeb9&_nc_ohc=7xoaDPzzoJwAX-Y3dCo&_nc_ht=scontent-hkg4-1.xx&oh=00_AfDLHOMMUmwhgcoSFN8UDj9_mb6qJ-DUomtACy5WEN2qRw&oe=63C23396';
    const baoAvatarLink =
        'https://scontent-hkg4-1.xx.fbcdn.net/v/t1.6435-9/81010388_885978891799156_5746613624403656704_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=UenATLo3azoAX9Lp2oe&_nc_ht=scontent-hkg4-1.xx&oh=00_AfCQceIEL2-xIElz9j-YS30CdBznlMSJv6uXSpEvkQdwZA&oe=63C26746';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Về chúng tôi'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            const SizedBox(height: 20),
            const SizedBox(height: 50),
            cartWidget(nhatAvatarLink, 'Hoàng Trung Nhật',
                'mattheuhtn@gmail.com', 'Mobile'),
            const SizedBox(height: 20),
            cartWidget(baoAvatarLink, 'Trần Đình Bảo', 'trandinhbao@gmail.com',
                'Backend'),
          ],
        ),
      )),
    );
  }

  Widget cartWidget(avatarLink, String name, email, position) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor),
      child: Row(
        children: [
          Text('BITINI',
              style: GoogleFonts.nunito(
                  color: AppColors.whiteColor, fontSize: 50)),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl: avatarLink,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Icon(
                  MaterialCommunityIcons.wallet_membership,
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(name.toUpperCase(),
                style: GoogleFonts.nunito(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
            Text(email, style: GoogleFonts.nunito(color: AppColors.whiteColor)),
            Text(position,
                style: GoogleFonts.nunito(color: AppColors.whiteColor))
          ]),
        ],
      ),
    );
  }
}
