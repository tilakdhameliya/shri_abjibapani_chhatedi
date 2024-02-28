import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satsang/model/calender/tithi_calender_model.dart';
import 'package:satsang/routes/app_routes.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/debugs.dart';
import '../../../../utils/network_connectivity.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/offline_popup.dart';
import 'package:flutter/services.dart' as root_bundle;
import '../../../utils/preference.dart';
import '../../../utils/utils.dart';

class SplashController extends GetxController {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoadData = true;
  repoData repo = repoData();
  int version = 0;

  @override
  void onInit() {
    super.onInit();
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
      // 2.
      update();
      // 3.
      Debug.printLog("connection status=====>>>>>>>$string");
      // if (string == "Online" && isLoadData) {
      //   isLoadData = false;
      //   await initializeNotifications();
      //   getPermission();
      //   moveToScreen();
      // } else if (string == "Offline" && Constant.isOffline) {
      //   isLoadData = true;
      //   Constant.isOffline = false;
      //   // showOfflineDialog();
      // }
      moveToScreen();
    });
  }

  moveToScreen() async {
    await initializeNotifications();
    await getJsonData();
    getPermission();
    Get.offAllNamed(AppRoutes.homeScreen);
  }

  Future<dynamic> getAndroidVersion() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    throw UnsupportedError("Platform is not Android");
  }

  getPermission() async {
    if (Platform.isAndroid) {
      await getAndroidVersion().then((value) {
        version = value;
      });
    }
    Constant.isGetNotificationPermission =
        Preference.shared.getBool(Preference.isGetNotificationPermission)!;
    Constant.isGetStoragePermission =
        Preference.shared.getBool(Preference.isGetStoragePermission)!;
    Constant.isGetPhotoPermission =
        Preference.shared.getBool(Preference.isGetPhotoPermission)!;

    Constant.isNotification =
        Preference.shared.getBool(Preference.isNotification)!;
    Constant.isStorage = Preference.shared.getBool(Preference.isStorage)!;

    if (!Constant.isGetNotificationPermission) {
      var notificationPermission = await Permission.notification.request();
      Constant.isNotification = notificationPermission.isDenied;
      Preference.shared
          .setBool(Preference.isNotification, Constant.isNotification);
      Preference.shared.setBool(Preference.isGetNotificationPermission,
          !Constant.isGetNotificationPermission);
      Constant.isGetNotificationPermission =
          Preference.shared.getBool(Preference.isGetNotificationPermission)!;
    }

    if(version < 32) {
      if (!Constant.isGetStoragePermission) {
        var storagePermission = await Permission.storage.request();
        Constant.isStorage = storagePermission.isDenied;
        Preference.shared.setBool(Preference.isStorage, Constant.isStorage);
        Preference.shared.setBool(
            Preference.isGetStoragePermission,
            !Constant.isGetStoragePermission);
        Constant.isGetStoragePermission =
        Preference.shared.getBool(Preference.isGetStoragePermission)!;
      }
    }

    // if (!Constant.isGetPhotoPermission) {
    //   var storagePermission = await Permission.photos.request();
    //   Constant.isPhoto = storagePermission.isDenied;
    //   Preference.shared.setBool(Preference.isPhoto, Constant.isPhoto);
    //   Preference.shared.setBool(
    //       Preference.isGetPhotoPermission, !Constant.isGetPhotoPermission);
    //   Constant.isGetPhotoPermission =
    //       Preference.shared.getBool(Preference.isGetPhotoPermission)!;
    // }
  }

  Future<void> initializeNotifications() async {
    const initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin
    );

    await Constant.flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        final String? payload = notificationResponse.payload;
        if (notificationResponse.payload != null) {
          debugPrint('notification payload: $payload');
        }
        if (Platform.isAndroid) {
          await Utils.sendData(payload.toString());
        } else if (Platform.isIOS) {
          await OpenFile.open(payload.toString());
        }
      },
    );
  }

  getJsonData() async {
    final jsondata = await DefaultAssetBundle.of(Get.context!)
        .loadString("assets/tithi_calender.json");
    final list = jsonDecode(jsondata);
    if (list != null) {
      Constant.tithiCalender = HeaderLines.fromJson(list["HeaderLines"]);
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String currentDate = formatter.format(now);

      for (int i = 0; i < Constant.tithiCalender.headerLine!.length; i++) {
        if (currentDate == Constant.tithiCalender.headerLine![i].date) {
          Constant.dailyQuote =
              Constant.tithiCalender.headerLine![i].suvichar.toString();
        }
      }
    }
  }
}
