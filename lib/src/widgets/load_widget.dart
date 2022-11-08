import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54,
        constraints: const BoxConstraints.expand(),
        child: const Center(child: CircularProgressIndicator()));
  }
}
