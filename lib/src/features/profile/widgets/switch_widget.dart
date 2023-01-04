import 'package:flutter/material.dart';

import '../../../../main.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      onChanged: (bool value) {
        isFuture = value;
        setState(() {});
      },
      value: isFuture,
    );
  }
}
