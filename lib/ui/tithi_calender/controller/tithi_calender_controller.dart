import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/constant.dart';

class TithiCalenderController extends GetxController{
  ItemScrollController? calenderController;
  String year = "";
 int  yearIndex = 0;


  gotoIndex() async {
    var todayIndex = Constant.tithiCalender.headerLine!
        .indexWhere((element) =>
    element.date == DateFormat('yyyy-MM-dd').format(DateTime.now()));
    if (todayIndex != -1) {
      await Future.delayed(const Duration(milliseconds: 5));
      calenderController!.jumpTo(index: todayIndex);
    }
  }

  bool isNow(int index) {
    return DateFormat('yyyy-MM-dd').format(DateTime.parse(
            Constant.tithiCalender.headerLine![index].date.toString())) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  String tithiDate(int index) {
    return DateFormat('dd EEE')
        .format(DateTime.parse(
            Constant.tithiCalender.headerLine![index].date.toString()))
        .toUpperCase();
  }

  bool yearBool(int index) {
    return index > 0 &&
        DateTime.parse(Constant.tithiCalender.headerLine![index - 1].date
                    .toString())
                .month !=
            DateTime.parse(
                    Constant.tithiCalender.headerLine![index].date.toString())
                .month;
  }


}