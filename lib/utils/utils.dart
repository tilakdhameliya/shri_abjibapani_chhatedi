import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/font.dart';

import 'debugs.dart';
import 'network_connectivity.dart';

class Utils {
  // static GuestResult? getUserData() {
  //   var loggedUserData = Preference.shared.getString(Preference.keyUserData);
  //   Map<String, dynamic> valueMap = json.decode(loggedUserData!);
  //   return GuestResult.fromJson(valueMap);
  // }

  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: msg,
    );
  }

  static Future<void> sendData(String path) async {
    const platform = MethodChannel("resumePath");
    try {
      await platform.invokeMethod('resumePathMethod', {"path": path});
    } on PlatformException catch (e) {
      Debug.printLog("e.message....${e.message}");
    }
  }

  static networkConnection(
      String string, NetworkConnectivity networkConnectivity) {
    networkConnectivity.initialise();
    networkConnectivity.myStream.listen((source) async {
      source = source;
      // 1.
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 3.
      Debug.printLog("connection status=====>>>>>>>$string");
    });
  }

  static String get getBaseUrl {
    return "https://abjibapanichhatedi.org/webservice/index.php";
  }

  static customBottomSheet(BuildContext context) {
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
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/image.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Daily Satsang",
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
                onTap: () {},
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
              ),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/news.svg",
                          height: 23),
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
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/video.svg",
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
                onTap: () {
                  Get.toNamed(AppRoutes.magazineScreen);
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/book.svg",
                          height: 23),
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
                onTap: () {},
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
                onTap: () {},
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SvgPicture.asset("assets/image/calender.svg",
                          height: 23),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "Calender",
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
                onTap: () {},
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
                onTap: () {},
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
