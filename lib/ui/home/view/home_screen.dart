// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/daily_satsang/view/daily_satsang_screen.dart';
import 'package:satsang/ui/divya_darshan/view/divya_darshan_screen.dart';
import 'package:satsang/ui/home/controller/home_controller.dart';
import 'package:satsang/ui/news/view/news_screen.dart';
import 'package:satsang/ui/photo/view/photo_screen.dart';
import 'package:satsang/ui/tithi_calender/view/tithi_calender_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/font.dart';
import '../../audio/view/audio_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeController>(
        builder: (logic) {
          return AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: (Constant.isShowBottomSheet)
                    ? Colors.black.withOpacity(0.3)
                    : CColor.white,
                systemNavigationBarColor: CColor.white,
                statusBarIconBrightness: (Constant.isShowBottomSheet)
                  ? Brightness.light:Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark),
            child: Scaffold(
              backgroundColor: Colors.white,
              bottomSheet: (Constant.isShowBottomSheet)
                  ? _bottomSheet(logic, context)
                  : const SizedBox(),
              resizeToAvoidBottomInset: true,
              bottomNavigationBar: _bottomNavigation(context),
              body: SafeArea(
                child: Stack(
                  children: [
                    _centerView(logic),
                    _header(logic),
                    (Constant.isShowBottomSheet)
                        ? Opacity(
                            opacity: 0.3,
                            child: ModalBarrier(
                                color: Colors.black,
                                onDismiss: () {
                                  Constant.isShowBottomSheet = false;
                                  setState(() {});
                                }),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ));
      },
    );
  }

  _header(HomeController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 65,
      alignment: Alignment.center,
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
      child: Center(
        child: Text(
          (logic.activePageIndex == 1)
              ? "Audio"
              : (logic.activePageIndex == 2)
                  ? "Photo"
                  : (logic.activePageIndex == 3)
                      ? "Calender"
                      : "Daily Satsung",
          style: TextStyle(
            fontFamily: Font.poppins,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),
        ),
      ),
    );
  }

  Widget _centerView(HomeController logic) {
    return GetBuilder<HomeController>(
      builder: (logic) {
        return PageView(
          controller: logic.pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            logic.onPageChangeFromBody(index);
          },
          children: [
            DailySatsangScreen(),
            AudioViewScreen(),
            PhotosScreen(),
            TithiCalenderScreen(),
          ],
        );
      },
    );
  }

  _bottomNavigation(BuildContext context) {
    double screenWidthSize = Get.width;
    bool isSmallDeviceWidth = screenWidthSize <= 350;
    return GetBuilder<HomeController>(builder: (logic) {
      return SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
            color: CColor.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  offset: const Offset(
                    0.0,
                    1.2,
                  ),
                  blurRadius: 5,
                  spreadRadius: 0.7),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  logic.dailySatsung(0);
                },
                child: SizedBox(
                  // width: 80,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/satsang.svg",
                            height: 24),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Daily Satsung",
                        style: TextStyle(
                          decoration: (logic.isPhoto)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: (logic.isPhoto)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: (isSmallDeviceWidth) ? 9 : 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  logic.audioScreen(1);
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/audio.svg",
                            height: 24),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Audio",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          decoration: (logic.isAudio)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: (logic.isAudio)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: (isSmallDeviceWidth) ? 9 : 11,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  logic.photoScreen(2);
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/image.svg",
                            height: 24),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Photo",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          decoration: (logic.isNews)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: (logic.isNews)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: (isSmallDeviceWidth) ? 9 : 11,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  logic.divyaDarshan(3);
                },
                child: SizedBox(
                  width: 55,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/calender.svg",
                            height: 24),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Calender",
                        style: TextStyle(
                          decoration: (logic.isDivyaDarshan)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: (logic.isDivyaDarshan)
                              ? FontWeight.w600
                              : FontWeight.w400,
                          fontSize: (isSmallDeviceWidth) ? 9 : 10,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  logic.more(4, context);
                  setState(() {});
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                            (Constant.isShowBottomSheet)
                                ? "assets/image/close.svg"
                                : "assets/image/more.svg",
                            height: 25),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        (Constant.isShowBottomSheet) ? "Close" : "More",
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: (isSmallDeviceWidth) ? 9 : 11,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _bottomSheet(HomeController logic, BuildContext context) {
    return Container(
      height: 230,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            "Abjibapani Chhatedi",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: Font.poppins,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.newsScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/news.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "News",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              /*InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  Get.toNamed(AppRoutes.loginScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/audio.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Registration",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),*/
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  Get.toNamed(AppRoutes.contactScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:
                          SvgPicture.asset("assets/image/cell-phone.svg", height: 25),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Contact Us",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  Get.toNamed(AppRoutes.nityaNiyamScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/nitya_niyam.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Nitya Niyam",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: ()  {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  Get.toNamed(AppRoutes.magazineScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:
                          SvgPicture.asset("assets/image/book.svg", height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Magazine",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  Get.toNamed(AppRoutes.eBooks);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/essay.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "E-Books",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Get.back();
                  Get.toNamed(AppRoutes.divyaDarshanScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/darshan.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Darshan",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () async {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  String url =
                      'https://youtube.com/@AbjibapaniChhatedi?si=REwY4mPKMgLfHjs_';
                  await launch(url);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/video.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Videos",
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  Constant.isShowBottomSheet = false;
                  setState(() {});
                  String url =
                      'https://www.facebook.com/abjibapanichhatedi?mibextid=ZbWKwL';
                  await launch(url);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/facebook.svg",
                          height: 25),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Facebook",
                      style: TextStyle(
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
