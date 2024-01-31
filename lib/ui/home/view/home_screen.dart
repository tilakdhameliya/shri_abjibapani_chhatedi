import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/divya_darshan/view/divya_darshan_screen.dart';
import 'package:satsang/ui/home/controller/home_controller.dart';
import 'package:satsang/ui/news/view/news_screen.dart';
import 'package:satsang/ui/photo/view/photo_screen.dart';
import 'package:satsang/utils/utils.dart';

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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarColor:
              (Constant.isShowBottomSheet) ? Colors.transparent : CColor.white,
          systemNavigationBarColor: CColor.white,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: (Constant.isShowBottomSheet)
            ? Utils.customBottomSheet(context)
            : const SizedBox(),
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: _bottomNavigation(context),
        body: GetBuilder<HomeController>(
          builder: (logic) {
            return SafeArea(
              child: Stack(
                children: [
                  _centerView(logic),
                  _header(logic),
                  (Constant.isShowBottomSheet)
                      ? Opacity(
                          opacity: 0.6,
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
            );
          },
        ),
      ),
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
                  ? "News"
                  : (logic.activePageIndex == 3)
                      ? "Divya Darshan"
                      : "Photo",
          style: TextStyle(
            fontFamily: Font.poppins,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
      ),
    );
  }

  Widget _centerView(HomeController logic) {
    return GetBuilder<HomeController>(
      builder: (logic) {
        return Expanded(
          child: PageView(
            controller: logic.pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              logic.onPageChangeFromBody(index);
            },
            children: [
              PhotosScreen(),
              AudioViewScreen(),
              NewsScreen(),
              const DivyaDarshanScreen(),
            ],
          ),
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
                  blurRadius: 2,
                  spreadRadius: 0.5),
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
                  logic.photoScreen(0);
                },
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/image.svg",
                            height: 23),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Photos",
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
                  logic.audioScreen(1);
                },
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/audio.svg",
                            height: 23),
                      ),
                      const SizedBox(height: 3),
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
                  logic.newsScreen(2);
                },
                child: Container(
                  width: 50,
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
                  logic.divyaDarshan(3);
                },
                child: Container(
                  width: 55,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset("assets/image/video.svg",
                            height: 23),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Darshan",
                        style: TextStyle(
                          decoration: (logic.isDivyaDarshan)
                              ? TextDecoration.underline
                              : TextDecoration.none,
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: (logic.isDivyaDarshan)
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
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  logic.more(4, context);
                  setState(() {});
                },
                child: Container(
                  width: 50,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                            (Constant.isShowBottomSheet)
                                ? "assets/image/close.svg"
                                : "assets/image/more.svg",
                            height: 22),
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
    logic.isOpenSheet = true;
    showModalBottomSheet<void>(
      backgroundColor: CColor.white,
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (BuildContext context) {
        return SafeArea(
          child: GetBuilder<HomeController>(builder: (logic) {
            return Wrap(
              children: [
                Column(
                  children: [
                    Text(
                      "Satsang",
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: Font.poppins,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/image/pray.svg",
                                  height: 28),
                              Text(
                                "Photos",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: Font.poppins,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/image/pray.svg",
                                  height: 30),
                              Text(
                                "News",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: Font.poppins,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/image/newspaper.svg",
                                  height: 30),
                              Text(
                                "Audio",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: Font.poppins,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              SvgPicture.asset("assets/image/video-square.svg",
                                  height: 30),
                              Text(
                                "Divya Darshan",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: Font.poppins,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                    (logic.isOpenSheet)
                                        ? "assets/image/close.svg"
                                        : "assets/image/expand.svg",
                                    height: 23),
                                Text(
                                  (logic.isOpenSheet) ? "Close" : "More",
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: Font.poppins,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
        );
      },
    ) /*.then((value) {
      logic.isOpenSheet = false;
      setState(() {});
    })*/
        ;
  }
}
