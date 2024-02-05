import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/color.dart';
import '../../../utils/font.dart';
import '../controller/tithi_calender_controller.dart';

class TithiCalenderScreen extends StatefulWidget {
  const TithiCalenderScreen({super.key});

  @override
  State<TithiCalenderScreen> createState() => _TithiCalenderScreenState();
}

class _TithiCalenderScreenState extends State<TithiCalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GetBuilder<TithiCalenderController>(
          builder: (logic) {
            return Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            );
          },
        ),
      ),
    );
  }

  _header(TithiCalenderController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 65,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              offset: const Offset(0.0, 1.5),
              blurRadius: 1,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            // highlightColor: Colors.transparent,
            // splashColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Daily Satsang",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _centerView(TithiCalenderController logic) {
    return Expanded(
      child: Calendar(
        weekDays: ['Sun', 'Sat', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        eventsList: [
        ],
        isExpandable: true,
        eventDoneColor: Colors.green,
        selectedColor: CColor.theme,
        selectedTodayColor: CColor.theme,
        todayColor: Colors.blue,
        hideTodayIcon: true,
        eventColor: Colors.red,
        locale: 'en_US',
        expandableDateFormat: 'EEEE, MMMM dd, yyyy',
        onDateSelected: (value) {
          var now = DateTime.now();
          var formatter = DateFormat('yyyy-MM-dd');
          String currentDate = formatter.format(now);
          String selectedDate = formatter.format(value);
          if (selectedDate == currentDate) {}
        },

        dayOfWeekStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
      ),
    );
  }
}
