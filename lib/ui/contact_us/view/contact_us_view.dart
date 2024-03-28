import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/utils/color.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant.dart';
import '../../../utils/font.dart';
import '../controller/contact_us_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactController>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CColor.white,
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              _centerView(logic),
              _header(logic),
            ],
          ),
        ),
      );
    });
  }

  _header(ContactController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 62,
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
                child: const Icon(Icons.arrow_back_rounded)
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Contact Us",
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.arrow_back_rounded
                  ,color: Colors.transparent)
          ),
        ],
      ),
    );
  }

  _centerView(ContactController logic) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "Shri Abjibapani Chhatedi",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                color: CColor.theme,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Baladia (17 km from Bhuj),",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w400,
                color: CColor.grayText,
                fontSize: 16,
              ),
            ),
            Text(
              "Kutch,Gujarat",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                color: CColor.grayText,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                String url = "tel:+91 2832 282253";
                await launch(url);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: CColor.viewGray,width: 1.5),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/image/call.svg",
                        height: 23),
                    Expanded(
                      child: Text(
                        "+91 2832 282253",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    /*SvgPicture.asset("assets/image/call.svg",
                        height: 23),*/
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                String url = "tel:+91 2832 282553";
                await launch(url);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: CColor.viewGray,width: 1.5),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/image/call.svg",
                        height: 23),
                    Expanded(
                      child: Text(
                        "+91 2832 282553",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                   /* SvgPicture.asset("assets/image/call.svg",
                        height: 23),*/
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                String url = "tel:+91 9099049285";
                await launch(url);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: CColor.viewGray,width: 1.5),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/image/call.svg",
                        height: 23),
                    Expanded(
                      child: Text(
                        "+91 9099049285",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    /*SvgPicture.asset("assets/image/call.svg",
                        height: 23),*/
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                String email = Uri.encodeComponent("info@abjibapanichhatedi.org");
                Uri mail = Uri.parse("mailto:$email");
                launchUrl(mail);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: CColor.viewGray,width: 1.5),
                    borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/image/sms.svg",
                        height: 25),
                    Expanded(
                      child: Text(
                        "info@abjibapanichhatedi.org",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                String url =
                    'https://www.abjibapanichhatedi.org';
                await launch(url);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: CColor.viewGray,width: 1.5),
                  borderRadius: BorderRadius.circular(3)
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/image/global.svg",
                        height: 23),
                    Expanded(
                      child: Text(
                        "https://www.abjibapanichhatedi.org",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: Font.poppins,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
