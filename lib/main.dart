import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_pages.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/preference.dart';
import 'connectivitymanager/connectivitymanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  await InternetConnectivity().instance();
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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