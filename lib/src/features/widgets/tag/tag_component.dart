import 'package:flutter/cupertino.dart';
import 'package:it_project/src/features/widgets/tag/tag.dart';

class TagComponent extends StatelessWidget {
  const TagComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Genres'),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: const [
            Tag(text: 'Education'),
            Tag(text: 'Self-development'),
            Tag(text: 'Psychology'),
            Tag(text: 'Fantasy'),
            Tag(text: 'Adventures'),
            Tag(text: 'Scince-fiction'),
          ],
        )
      ],
    );
  }
}
