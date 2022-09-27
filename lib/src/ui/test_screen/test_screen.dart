import 'package:flutter/material.dart';
import 'package:it_project/src/ui/widgets/ad_post.dart';
import 'package:it_project/src/ui/widgets/big_post.dart';
import 'package:it_project/src/ui/widgets/button.dart';
import 'package:it_project/src/ui/widgets/short_post.dart';
import 'package:it_project/src/ui/widgets/state_post.dart';
import 'package:it_project/src/ui/widgets/tag/tag_component.dart';

import '../widgets/comment_post.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 20),
            MeButton(
              func: () {},
              text: 'Button',
            ),
            const Divider(),
            const SizedBox(height: 20),
            const TagComponent(),
            const Divider(),
            const Text('Comment Post'),
            const CommentPost(),
            const Divider(),
            const Text('State Post'),
            const StatePost(),
            const Divider(),
            const Text('Ad Post'),
            const AdPost(),
            const Divider(),
            const Text('Short Post'),
            const Padding(
              padding: EdgeInsets.all(20),
              child: ShortPost(),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text('Big Post'),
            const Padding(
              padding: EdgeInsets.all(20),
              child: BigPost(),
            ),
          ]),
        ),
      ),
    );
  }
}
