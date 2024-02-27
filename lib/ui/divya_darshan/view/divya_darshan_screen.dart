import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/divya_darshan/controller/divya_darshan_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/font.dart';


class DivyaDarshanScreen extends StatelessWidget {
  DivyaDarshanScreen({super.key});

   final DivyaDarshanController darshanController = Get.put(DivyaDarshanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CColor.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
        ),
      ),
      body: GetBuilder<DivyaDarshanController>(
        builder: (logic) {
          return SafeArea(
            child: Stack(
              children: [
                (logic.isOffline)
                    ? _offLine(logic)
                    : Column(
                        children: [
                          const SizedBox(height: 60),
                          Expanded(
                            child: WebViewWidget(
                              controller: Constant.darshanController,
                            ),
                          ),
                        ],
                      ),
                _header(logic),
              ],
            ),
          );
        },
      ),
    );
  }
  _header(DivyaDarshanController logic) {
    return Container(
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
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.arrow_back_rounded)
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Abjibapa Divya Darshan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.arrow_back_rounded
                    ,color: Colors.transparent)
            ),
          ),
        ],
      ),
    );
  }

  _offLine(DivyaDarshanController logic) {
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
            color: CColor.black,
            height: 110,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: Text(
              "OOPS!",
              style: TextStyle(
                color: CColor.black,
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
              Constant.isOffline = true;
              logic.checkConnection(true);
            },
            child: Container(
              height: Get.height * 0.06,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: CColor.black,
                ),
              ),
              child: Center(
                child: Text(
                  "RETRY",
                  style: TextStyle(
                    color: CColor.black,
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
