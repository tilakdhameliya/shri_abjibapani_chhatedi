import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/font.dart';
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
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.arrow_back_rounded)
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Tithi Calender",
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.arrow_back_rounded
                  ,color: Colors.transparent)
          ),
        ],
      ),
    );
  }

  _centerView(TithiCalenderController logic) {
    List<String> string = [];
    List<String> stringDate = [];
    for (int i = 0; i < Constant.tithiCalender.headerLine!.length; i++) {
      var tithi = Constant.tithiCalender.headerLine![i].tithi.toString();
      string.add(tithi);
      var date = Constant.tithiCalender.headerLine![i].date.toString();
      stringDate.add(date);
    }
    final List<NeatCleanCalendarEvent> eventList = [];
    for(int i = 0; i < string.length; i++) {
      var element = NeatCleanCalendarEvent(
        string[i],
        startTime: DateFormat("yyyy-MM-dd").parse(stringDate[i]),
        endTime: DateFormat("yyyy-MM-dd").parse(stringDate[i]),
        color: Colors.transparent,
      );
      eventList.add(element);
    }

    return Expanded(
      child: Calendar(
        weekDays: const ['Sun', 'Sat', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        eventsList: eventList,
        isExpandable: true,
        isExpanded: true,
        selectedColor: CColor.theme,
        selectedTodayColor: CColor.theme,
        todayColor: Colors.blue,
        hideTodayIcon: true,
        displayMonthTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 13,fontFamily: Font.poppins),
        bottomBarTextStyle:  TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 13,fontFamily: Font.poppins),
        locale: 'en_US',
        expandableDateFormat: 'EEEE, MMMM dd, yyyy',
        bottomBarArrowColor: Colors.transparent,
        eventTileHeight: 250,
        eventDoneColor: Colors.transparent,
        dayOfWeekStyle:  TextStyle(
            color: Colors.black.withOpacity(0.5), fontWeight: FontWeight.w800, fontSize: 12,fontFamily: Font.poppins),
      ),
    );
  }
}
