import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../model/calender/tithi_calender_model.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../../utils/loader.dart';
import '../../../utils/network_connectivity.dart';

class HomeController extends GetxController {
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
  bool isOffline = false;
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';



  onPageChangeFromBody(int i) {
    activePageIndex = i;
    activePage = i;
    update();
  }

  dailySatsung(int i) {
    isAudio = false;
    isDivyaDarshan = false;
    isNews = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isPhoto = true;
    update();
  }

  audioScreen(int i) {
    isDivyaDarshan = false;
    isNews = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isAudio = true;
    update();
  }

  photoScreen(int i) {
    isAudio = false;
    isDivyaDarshan = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isNews = true;
    update();
  }

  divyaDarshan(int i) {
    isAudio = false;
    isNews = false;
    isPhoto = false;
    isMore = false;
    activePageIndex = i;
    pageController.animateToPage(i,
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
    isDivyaDarshan = true;
    update();
  }

  checkConnection(bool bool) async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      isOffline = true;
      update();
    } else {
      isOffline = false;
      if(bool) {
        webViewPreLoad();
      }
    }
  }

  more(int i, BuildContext context) {
    Constant.isShowBottomSheet = !Constant.isShowBottomSheet;
    checkConnection(true);
  }

  webViewPreLoad() {
    Constant.darshanController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse("https://www.abjibapanichhatedi.org/life-story/"),
      );
  }

}
