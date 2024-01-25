import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../utils/color.dart';

class InternetConnectivity {
  // ------------------ SINGLETON -----------------------
  static final InternetConnectivity _internetConnectivity =
      InternetConnectivity._internal();

  factory InternetConnectivity() {
    return _internetConnectivity;
  }

  InternetConnectivity._internal();

  static InternetConnectivity get shared => _internetConnectivity;

  static Connectivity? _connectivity;

  /* make connection with preference only once in application */
  Future<Connectivity?> instance() async {
    if (_connectivity != null) return _connectivity;

    _connectivity = Connectivity();

    return _connectivity;
  }

  static Future<ConnectivityResult> getStatus() {
    return _connectivity!.checkConnectivity();
  }

  static Future<bool> isInternetConnect() async {
    ConnectivityResult result = await getStatus();

    if (result == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static Future isInternetAvailable(BuildContext context,
      {required Function success,
      required Function cancel,
      required Function retry}) async {
    ConnectivityResult result = await getStatus();

    if (result != ConnectivityResult.none) {
      success();
      return;
    }

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text("No Internet Connection"),
          title: Text(
            "noInternetConnection".tr,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: CColor.black,
              fontSize: 16,
            ),
          ),
          content: Text(
            "descNoInternetConnection".tr,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: CColor.black,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "cancel".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: CColor.black,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                cancel();
              },
            ),
            TextButton(
              child: Text(
                "retry".tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: CColor.black,
                  fontSize: 14,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context);
                retry();
              },
            ),
          ],
        );
      },
    );
  }
}
