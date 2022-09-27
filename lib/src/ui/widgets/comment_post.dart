import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:it_project/src/utils/app_assets.dart';

import '../../utils/app_colors.dart';

class CommentPost extends StatefulWidget {
  const CommentPost({Key? key}) : super(key: key);

  @override
  State<CommentPost> createState() => _CommentPostState();
}

class _CommentPostState extends State<CommentPost> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              AppAssets.imgHarryJpg,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Miranda',
                style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ...List.generate(
                      4,
                      (index) => Icon(
                            Icons.star,
                            size: 15,
                            color: AppColors.redColor,
                          )),
                  ...List.generate(
                      1,
                      (index) => Icon(
                            size: 15,
                            Icons.star_border_outlined,
                            color: AppColors.redColor,
                          )),
                ],
              ),
            ],
          ),
        ],
      ),
      Row(
        children: [
          Flexible(
            child: Text(
              lorem(
                paragraphs: 1,
                words: 50,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: isMore ? 100 : 5,
            ),
          ),
        ],
      ),
      InkWell(
        onTap: () {
          isMore = !isMore;
          setState(() {});
        },
        child: Text(isMore ? 'less' : 'more',
            style: GoogleFonts.nunito(
                color: AppColors.blueColor, fontWeight: FontWeight.bold)),
      )
    ]);
  }
}
