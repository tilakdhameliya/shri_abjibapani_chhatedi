import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/font.dart';
import 'package:url_launcher/url_launcher.dart';

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

}
