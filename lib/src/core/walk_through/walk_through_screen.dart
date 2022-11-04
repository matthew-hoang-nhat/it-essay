import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        children: [
          firstScreen(),
          firstScreen(),
          firstScreen(),
        ],
      )),
    );
  }

  firstScreen() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          const SizedBox(height: 50),
          Text(
            'Welcome to',
            style:
                GoogleFonts.nunito(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          const SizedBox(height: 50),
          ListTile(
            leading: const Icon(
              MaterialCommunityIcons.hand_back_left,
              size: 40,
            ),
            title: Text(
              'Product Availability',
              style:
                  GoogleFonts.nunito(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(lorem(words: 20, paragraphs: 1)),
          ),
          const SizedBox(height: 20),
          ListTile(
              leading: const Icon(
                MaterialCommunityIcons.cart_check,
                size: 40,
              ),
              title: Text(
                'Fast & Easy Checkout',
                style: GoogleFonts.nunito(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(lorem(words: 20, paragraphs: 1))),
          const SizedBox(height: 20),
          ListTile(
              leading: const Icon(
                MaterialCommunityIcons.timelapse,
                size: 40,
              ),
              title: Text(
                'Fast & Cheap Delivery',
                style: GoogleFonts.nunito(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(lorem(words: 20, paragraphs: 1))),
        ]));
  }
}
