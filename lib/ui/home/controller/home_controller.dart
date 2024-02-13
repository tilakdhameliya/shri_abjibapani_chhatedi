import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/utils.dart';

import '../../../model/calender/tithi_calender_model.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';

class HomeController extends GetxController{


  repoData repo = repoData();
  late PageController pageController =
  PageController(initialPage: 0, keepPage: true);
  int activePageIndex = 0;
  int activePage = 0;
  bool isOpenSheet = false;
  bool isAudio = false;
  bool isPhoto = true;
  bool isNews = false;
  bool isDivyaDarshan = false;
  bool isMore = false;

  onPageChangeFromBody(int i) {
    activePageIndex = i;
    activePage = i;
    update();
  }

  photoScreen(int i){
    isAudio = false;
    isDivyaDarshan = false;
    isNews = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i, duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isPhoto= true;
    update();
  }

  audioScreen(int i){
    isDivyaDarshan = false;
    isNews = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i, duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isAudio = true;
    update();
  }

  newsScreen(int i){
    isAudio = false;
    isDivyaDarshan = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i, duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isNews = true;
    update();
  }

  divyaDarshan(int i){
    isAudio = false;
    isNews = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i, duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isDivyaDarshan = true;
    update();
  }

  more(int i, BuildContext context) {
    Constant.isShowBottomSheet = !Constant.isShowBottomSheet;
    update();
  }

  getJsonData() async {
    final jsondata = await DefaultAssetBundle.of(Get.context!)
        .loadString("assets/tithi_calender.json");
    final list = jsonDecode(jsondata);
    if (list != null) {
      Constant.tithiCalender = HeaderLines.fromJson(list["HeaderLines"]);
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String currentDate = formatter.format(now);

      for (int i = 0; i < Constant.tithiCalender.headerLine!.length; i++) {
        if (currentDate == Constant.tithiCalender.headerLine![i].date) {
          Constant.dailyQuote = Constant.tithiCalender.headerLine![i].suvichar.toString();
        }
      }
    }
  }

  @override
  void onInit() {
    getJsonData();

    super.onInit();
  }

  getData() async {



  }

}