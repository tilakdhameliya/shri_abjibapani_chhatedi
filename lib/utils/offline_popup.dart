import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/utils/utils.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../../utils/network_connectivity.dart';
import 'constant.dart';

Future<void> showOfflineDialog() async {
  var brightness = MediaQuery.of(Get.context!).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;

  // Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';

  return showDialog<void>(
    context: Get.context!,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Material(
          color: CColor.transparent,
          shadowColor: CColor.transparent,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              height: Get.height * 0.45,
              width: Get.width,
              decoration: const BoxDecoration(
                  color:  CColor.white,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/resume/no_internet.svg",
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
                        color: isDarkMode ? CColor.white : CColor.black,
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
                  InkWell(
                    highlightColor: CColor.transparent,
                    splashColor: CColor.transparent,
                    onTap: () {
                      Get.back();
                      
                      Utils.networkConnection(string, networkConnectivity);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: Get.height * 0.04),
                      height: Get.height * 0.06,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                        color: CColor.transparent,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: isDarkMode ? CColor.white : CColor.black,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "RETRY",
                          style: TextStyle(
                            color: isDarkMode ? CColor.white : CColor.black,
                            fontFamily: Font.poppins,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
