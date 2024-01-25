
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_pages.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/debugs.dart';
import 'package:satsang/utils/preference.dart';

import 'connectivitymanager/connectivitymanager.dart';
import 'new_resume_data_model/new_resume_data_model.dart';

ResumeData repo = ResumeData();
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
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      title: 'Satsung',
      locale: Get.deviceLocale,
      getPages: AppPages.list,
      initialRoute: AppRoutes.splashScreen,
    );
  }
}