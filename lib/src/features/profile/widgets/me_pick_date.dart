import 'dart:io';

import 'package:flutter/cupertino.dart';
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
          _showPickDate(context);
        },
        child: Text(
          getDateTime(),
          style: GoogleFonts.nunito(color: AppColors.blueColor),
        ));
  }

  _showPickDate(context) {
    const minYear = 1950;
    final maxDateTime = DateTime.now();
    if (Platform.isAndroid) {
      showDatePicker(
        context: context,
        initialDate: widget.initDateTime ?? DateTime.now(),
        initialEntryMode: DatePickerEntryMode.input,
        firstDate: DateTime(minYear),
        lastDate: maxDateTime,
        fieldLabelText: 'Ngày sinh nhật',
        fieldHintText: 'Tháng/Ngày/Năm',
        errorFormatText: 'Ngày không phù hợp',
        errorInvalidText: 'Ngày vượt ngoài',
      ).then((value) {
        dateTime = value;
        widget.func(value);
        setState(() {});
      });
    } else if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => CupertinoTheme(
                data: CupertinoTheme.of(context),
                child: _BottomPicker(
                  child: CupertinoDatePicker(
                    backgroundColor:
                        CupertinoColors.systemBackground.resolveFrom(context),
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime:
                        dateTime ?? widget.initDateTime ?? DateTime.now(),
                    minimumYear: minYear,
                    maximumYear: maxDateTime.year,
                    maximumDate: maxDateTime,
                    onDateTimeChanged: (value) {
                      dateTime = value;
                      widget.func(value);
                      setState(() {});
                    },
                  ),
                ),
              ));
    }
  }

  String getDateTime() {
    if ((widget.initDateTime == null) && dateTime == null) return 'Chưa có';

    if (dateTime != null) {
      return f.format(dateTime!);
    }

    return f.format(widget.initDateTime!);
  }
}

class _BottomPicker extends StatelessWidget {
  const _BottomPicker({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      padding: const EdgeInsets.only(top: 6),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 22,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: child,
          ),
        ),
      ),
    );
  }
}
