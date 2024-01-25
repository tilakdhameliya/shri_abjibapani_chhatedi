import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
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
    return Wrap(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16)),
          ),
          child: Column(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset("assets/image/image.svg", height: 23),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Photos",
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
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset("assets/image/audio.svg", height:23),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "Audio",
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            decoration: TextDecoration.none,
                            fontFamily: Font.poppins,
                            color: Colors.black,
                            fontWeight:  FontWeight.w400,
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset("assets/image/news.svg", height:23),
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
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: (){

                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset("assets/image/video.svg", height:23),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "divya Darshan",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: Font.poppins,
                            color: Colors.black,
                            fontWeight:  FontWeight.w400,
                            fontSize: 11,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {

                    },
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SvgPicture.asset(
                              "assets/image/more.svg",
                              height: 22),
                        ),
                        const SizedBox(height: 3),
                        Text(
                           "More",
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
            ],
          ),
        ),
      ],
    );
  }
}
