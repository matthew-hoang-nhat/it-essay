import 'package:flutter/material.dart';
import 'package:it_project/src/configs/constants/app_assets.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: SizedBox(
              height: 30,
              width: 30,
              child: Image.asset(
                AppAssets.icSearch,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            suffixIcon: Image.asset(
              AppAssets.icNext,
              height: 30,
              fit: BoxFit.cover,
            ),
            enabledBorder: styleBorder(),
            focusedBorder: styleBorder()),
      ),
    );
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
        borderSide: const BorderSide(),
        borderRadius: BorderRadius.circular(100));
  }
}
