import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satsang/routes/app_pages.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/preference.dart';
import 'package:satsang/utils/utils.dart';
import 'connectivitymanager/connectivitymanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  await InternetConnectivity().instance();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  getPermission();
  runApp(const MyApp());
}

getPermission() async {
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

  if (!Constant.isGetStoragePermission) {
    var storagePermission = await Permission.storage.request();
    Constant.isStorage = storagePermission.isDenied;
    Preference.shared.setBool(Preference.isStorage, Constant.isStorage);
    Preference.shared.setBool(
        Preference.isGetStoragePermission, !Constant.isGetStoragePermission);
    Constant.isGetStoragePermission =
    Preference.shared.getBool(Preference.isGetStoragePermission)!;
  }

  if (!Constant.isGetPhotoPermission) {
    var storagePermission = await Permission.photos.request();
    Constant.isPhoto = storagePermission.isDenied;
    Preference.shared.setBool(Preference.isPhoto, Constant.isPhoto);
    Preference.shared.setBool(
        Preference.isGetPhotoPermission, !Constant.isGetPhotoPermission);
    Constant.isGetPhotoPermission =
    Preference.shared.getBool(Preference.isGetPhotoPermission)!;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent)),
      debugShowCheckedModeBanner: false,
      title: 'Abjibapani Chhatedi',
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}