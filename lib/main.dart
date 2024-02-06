import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:satsang/routes/app_pages.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/preference.dart';
import 'package:satsang/utils/utils.dart';
import 'connectivitymanager/connectivitymanager.dart';
import 'new_resume_data_model/new_resume_data_model.dart';

ResumeData repo = ResumeData();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  await InternetConnectivity().instance();
  await initializeNotifications();

  runApp(const MyApp());
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
      title: 'Satsung',
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}
