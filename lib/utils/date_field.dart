import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/font.dart';

class DateField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController startController;
  final TextEditingController? endController;

  const DateField(
      {super.key,
      required this.title,
      required this.startController,
      required this.hintText, this.endController});

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: CColor.black,
              fontSize: 14,
              fontFamily: Font.poppins,
              fontWeight: FontWeight.w500,
              height: 0.09,
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
                dateTime(context);
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side:  const BorderSide(color: CColor.dividerLine,width: 2)
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: widget.startController.text == ""
                          ? Text(
                              widget.hintText,
                              style: TextStyle(
                                fontFamily: Font.poppins,
                                color: CColor.grayText,
                                fontWeight: FontWeight.w500,
                                height: 0,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              widget.startController.text,
                              style: TextStyle(
                                color: CColor.black,
                                fontFamily: Font.poppins,
                                height: 0,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/image/date.svg",
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  dateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
        keyboardType: TextInputType.datetime,
        context: context,
        initialDate: widget.startController.text.isNotEmpty
            ? DateFormat('d MMMM yyyy').parse(widget.startController.text)
            : DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.dark(
                primary: Color(0x37000000),
                onPrimary: Colors.black,
                surface: Colors.white,
                onSurface: Colors.black,
                secondary: Colors.grey,
                brightness: Brightness.dark,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
              ),
              dialogBackgroundColor: CColor.white,
            ),
            child: child!,
          );
        });
    if (selectedDate != null) {
      String formattedDate = DateFormat('d MMMM yyyy').format(selectedDate);

      widget.startController.text = formattedDate.toString();
      setState(() {});
    }
  }
}
