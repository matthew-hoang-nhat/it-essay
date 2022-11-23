import 'package:flutter/material.dart';

class MeDropDown extends StatefulWidget {
  const MeDropDown(
      {super.key,
      required this.value,
      required this.items,
      required this.func});
  final String value;
  final List<String> items;
  final Function(String) func;
  @override
  State<MeDropDown> createState() => _MeDropDownState();
}

class _MeDropDownState extends State<MeDropDown> {
  late String genderValue = widget.value;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        items: widget.items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e == 'male' ? 'Nam' : 'Nữ'),
                ))
            .toList(),
        value: genderValue,
        onChanged: ((value) {
          setState(() {
            genderValue = value!;
          });
          widget.func(value!);
        }));
  }
}
