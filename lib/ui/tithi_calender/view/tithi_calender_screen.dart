import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/font.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../controller/tithi_calender_controller.dart';

class TithiCalenderScreen extends StatefulWidget {
  TithiCalenderScreen({super.key});

  final TithiCalenderController tithiCalenderController =
      Get.put(TithiCalenderController());

  @override
  State<TithiCalenderScreen> createState() => _TithiCalenderScreenState();
}

class _TithiCalenderScreenState extends State<TithiCalenderScreen> {
  @override

  void initState() {
    widget.tithiCalenderController.calenderController = ItemScrollController();
    widget.tithiCalenderController.gotoIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.arrow_back_rounded)),
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
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.transparent)),
        ],
      ),
    );
  }


  _centerView(TithiCalenderController logic) {
    var todayIndex = Constant.tithiCalender.headerLine!
        .indexWhere((element) =>
    element.date == DateFormat('yyyy-MM-dd').format(DateTime.now()));
    var yearIndex = todayIndex;
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              Constant.tithiCalender.headerLine![(logic.yearIndex == 0)?yearIndex:logic.yearIndex].year.toString(),
              style: TextStyle(
                  color: CColor.theme,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  fontFamily: Font.poppins),
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemCount: Constant.tithiCalender.headerLine!.length,
              shrinkWrap: true,
              itemScrollController: logic.calenderController,
              itemBuilder: (BuildContext context, int index) {
                return VisibilityDetector(
                  key: Key(index.toString()),
                  onVisibilityChanged: (VisibilityInfo info) {
                    if (info.visibleFraction == 1) {
                      setState(() {
                        logic.yearIndex = index;
                      });
                    }
                  },
                  child: Column(
                    children: [
                      (logic.yearBool(index))
                          ? Container(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                Constant.tithiCalender.headerLine![index].year
                                    .toString(),
                                style: TextStyle(
                                    color: CColor.theme,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    fontFamily: Font.poppins),
                              ),
                            )
                          : const SizedBox(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            child: Text(
                              logic.tithiDate(index),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: (logic.isNow(index))
                                      ? CColor.theme
                                      : CColor.grayText.withOpacity(0.8),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  fontFamily: Font.poppins),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Card(
                                  margin: const EdgeInsets.only(
                                      top: 2, bottom: 5, left: 2, right: 5),
                                  color: (logic.isNow(index))
                                      ? CColor.theme
                                      : CColor.viewGray,
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    width: Get.width,
                                    child: Text(
                                      Constant
                                          .tithiCalender.headerLine![index].tithi
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:(logic.isNow(index))
                                              ?Colors.white: Colors.black,
                                          fontSize: 18,
                                          fontFamily: Font.poppins),
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  itemCount: Constant.tithiCalender
                                      .headerLine![index].subTithi!.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int i) {
                                    return (Constant
                                            .tithiCalender
                                            .headerLine![index]
                                            .subTithi![i]
                                            .isNotEmpty)
                                        ? Card(
                                            margin: const EdgeInsets.only(
                                                top: 2,
                                                bottom: 5,
                                                left: 2,
                                                right: 5),
                                            color: logic.isNow(index)
                                                ? CColor.theme
                                                : CColor.viewGray,
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              child: Text(
                                                Constant
                                                    .tithiCalender
                                                    .headerLine![index]
                                                    .subTithi![i]
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: (logic.isNow(index))
                                                        ?Colors.white: Colors.black,
                                                    fontSize: 18,
                                                    fontFamily: Font.poppins),
                                              ),
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

/*  _centerView(TithiCalenderController logic) {
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
  }*/
}
