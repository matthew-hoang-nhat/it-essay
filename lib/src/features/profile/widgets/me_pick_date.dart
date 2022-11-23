import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:it_project/src/configs/constants/app_colors.dart';

class MePickDate extends StatefulWidget {
  const MePickDate({
    super.key,
    required this.func,
    required this.initDateTime,
  });
  final Function(DateTime?) func;
  final DateTime? initDateTime;

  @override
  State<MePickDate> createState() => _MePickDateState();
}

class _MePickDateState extends State<MePickDate> {
  DateTime? dateTime;
  final f = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: widget.initDateTime ?? DateTime.now(),
            initialEntryMode: DatePickerEntryMode.input,
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
            fieldLabelText: 'Ngày sinh nhật',
            fieldHintText: 'Tháng/Ngày/Năm',
            errorFormatText: 'Ngày không phù hợp',
            errorInvalidText: 'Ngày vượt ngoài',
          ).then((value) {
            dateTime = value;
            widget.func(value);
            setState(() {});
          });
        },
        child: Text(
          getDateTime(),
          style: GoogleFonts.nunito(color: AppColors.blueColor),
        ));
  }

  String getDateTime() {
    if ((widget.initDateTime == null) && dateTime == null) return 'Chưa có';

    if (dateTime != null) {
      return f.format(dateTime!);
    }

    return f.format(widget.initDateTime!);
  }
}
