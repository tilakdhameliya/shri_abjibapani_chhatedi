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
  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: msg,
    );
  }

  static Future<void> sendData(String path) async {
    const platform = MethodChannel("pdfPath");
    try {
      await platform.invokeMethod('pdfPathMethod', {"path": path});
    } on PlatformException catch (e) {
      Debug.printLog("e.message....${e.message}");
    }
  }

  static String get getBaseUrl {
    return "https://abjibapanichhatedi.org/webservice/index.php";
  }

}
