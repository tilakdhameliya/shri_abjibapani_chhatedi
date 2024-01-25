import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/utils.dart';

import '../../../utils/color.dart';
import '../../../utils/font.dart';

class HomeController extends GetxController{
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
}