import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:open_file/open_file.dart';
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

  runApp(const MyApp());
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
