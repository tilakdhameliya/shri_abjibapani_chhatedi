import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/utils/constant.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/font.dart';
import '../controller/daily_satsang_controller.dart';

class DailySatsangScreen extends StatefulWidget {
   DailySatsangScreen({super.key});

  final DailySatsangController dailySatsangController = Get.put(DailySatsangController());

  @override
  State<DailySatsangScreen> createState() => _DailySatsangScreenState();
}

class _DailySatsangScreenState extends State<DailySatsangScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GetBuilder<DailySatsangController>(
          builder: (logic) {
            return Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            );
          },
        ),
      ),
    );
  }

  _header(DailySatsangController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 65,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              offset: const Offset(0.0, 1.5),
              blurRadius: 1,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Daily Satsang",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Share.share(Constant.dailyQuote);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset("assets/image/share.svg", height: 21),
            ),
          )
        ],
      ),
    );
  }

  _centerView(DailySatsangController logic){
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          // padding: const EdgeInsets.only(top: 70,right: 15,left: 15,bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Text(Constant.dailyQuote,style: TextStyle(color: Colors.black,fontSize: 19,fontFamily: Font.poppins,height: 1.7,fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
}
