// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/font.dart';
import '../controller/magazine_controller.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({super.key});

  @override
  State<MagazineScreen> createState() => _MagazineScreenState();
}

class _MagazineScreenState extends State<MagazineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CColor.white,
        elevation: 0,
        toolbarHeight: 0,
        surfaceTintColor: Colors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: GetBuilder<MagazineController>(
          builder: (logic) {
            return WillPopScope(
              onWillPop: ()async {
                if (!logic.isCom) {
                  return true;
                }else {
                  Fluttertoast.showToast(msg: "Pdf Downloading...");
                  return false;
                }
              },
              child: Stack(
                children: [
                  (logic.isOffline)
                      ? _offLine(logic)
                      : Column(
                    children: [
                      const SizedBox(height: 65),
                      _centerView(logic),
                    ],
                  ),
                  _header(logic),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _header(MagazineController logic) {
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
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              if (!logic.isCom) {
                Get.back();
              }else{
                Fluttertoast.showToast(msg: "Pdf Downloading...");
              }
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Magazines",
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 28)
        ],
      ),
    );
  }

  _centerView(MagazineController logic) {
    return (logic.isLoading)
        ? const Expanded(
            child: Center(
              child: SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              ),
            ),
          )
        : Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: Constant.magazines.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _listItem(logic, index, context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _listItem(MagazineController logic, int index, BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (!logic.isCom) {
              logic.downloadMagazine(context, index, Constant.magazines[index].url,
                  Constant.magazines[index].name);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 17),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Constant.magazines[index].name.toString(),
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                (Constant.magazines[index].isLoader)
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: CColor.theme,
                    strokeWidth: 1.5,
                  ),
                )
                    : (Constant.magazines[index].isIndicator)
                        ? CircularPercentIndicator(
                            radius: 15.0,
                            lineWidth: 3.0,
                            percent: logic.downloadPercentage,
                            center: Text(
                              logic.downloadingText,
                              style: TextStyle(
                                fontFamily: Font.poppins,
                                fontWeight: FontWeight.w500,
                                color: CColor.theme,
                                fontSize: 10,
                              ),
                            ),
                            progressColor: CColor.theme,
                          )
                        : (!Constant.magazines[index].isDownload)
                            ? SvgPicture.asset("assets/image/download.svg",
                                color: CColor.theme)
                            : const SizedBox()
              ],
            ),
          ),
        ),
        (index == Constant.magazines.length - 1)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                    height: 0,
                    color: CColor.viewGray.withOpacity(0.7),
                    thickness: 1.5),
              )
      ],
    );
  }

  _offLine(MagazineController logic){
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/image/no_internet.svg",
            // ignore: deprecated_member_use
            color:  CColor.black,
            height: 110,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: Text(
              "OOPS!",
              style: TextStyle(
                color:  CColor.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.01),
            child: Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.01),
            child: Text(
              "Please check your connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              
              logic.checkConnection();
            },
            child: Container(
              height: Get.height * 0.06,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color:  CColor.black,
                ),
              ),
              child: Center(
                child: Text(
                  "RETRY",
                  style: TextStyle(
                    color:  CColor.black,
                    fontFamily: Font.poppins,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
