import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../utils/color.dart';
import '../../../utils/font.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  final SplashController splashController = Get.put(SplashController());

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: CColor.white,
      ),
    );

    return Scaffold(
      body: _centerView(),
    );
  }

  _centerView() {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          // Color(0xff6c85bd),
          Colors.lightBlueAccent,
         Colors.white,
          Colors.white,
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          /*Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage("assets/resume/resume_builder_app_logo.png"),
              ),
            ),
          ),*/
          const SizedBox(height: 20),
          Text(
            "Resume Builder",
            style: TextStyle(
              fontFamily: Font.poppins,
              color: CColor.black,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: /*Image.asset("assets/resume/ic_loader.gif",
                    color: CColor.white, height: 50),*/
                  /*const LinearProgressIndicator(
                  // valueColor: AlwaysStoppedAnimation<Color>(CColor.black12),
                  valueColor: AlwaysStoppedAnimation<Color>(CColor.white12),
                  // backgroundColor: Colors.black12,
                  backgroundColor: Colors.white12,
                ),*/
                  const CircularProgressIndicator(
                    color: CColor.white,
                    strokeWidth: 3,
                  )),
            ),
          ),
          Text(
            "Version 1.0.0",
            style: TextStyle(
              fontFamily: Font.poppins,
              color: CColor.white,
              fontSize: 12,
            ),
          ),
          SizedBox(height: Get.height * 0.15)
        ],
      ),
    );
  }
}