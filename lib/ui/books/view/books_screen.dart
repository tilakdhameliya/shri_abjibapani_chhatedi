// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';
import '../controller/books_controller.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<BookController>(
          builder: (logic) {
            return Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 65),
                    _centerView(logic),
                  ],
                ),
                _header(logic),
              ],
            );
          },
        ),
      ),
    );
  }

  _header(BookController logic) {
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
                "E-books",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 28)
        ],
      ),
    );
  }

  _centerView(BookController logic) {
    return (logic.isLoading)
        ? const Expanded(
            child: Center(
              child: SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              ),
            ),
          )
        : Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    itemCount: Constant.eBooks.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _listItem(logic, index, context);
                    },
                  ),
                ],
              ),
            ),
          );
  }

  _listItem(BookController logic, int index, BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (!logic.isCom) {
              logic.downloadAudio(context, index, Constant.eBooks[index].url,
                  Constant.eBooks[index].name);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 95,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        // fit: BoxFit.cover,
                        image: NetworkImage(
                            Constant.eBooks[index].image.toString()),
                      )),
                ),
                Expanded(
                  child: Text(
                    Constant.eBooks[index].name.toString(),
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
                (Constant.eBooks[index].isLoader)
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: CColor.theme,
                    strokeWidth: 1.5,
                  ),
                )
                    : (Constant.eBooks[index].isIndicator)
                        ? CircularPercentIndicator(
                            radius: 15.0,
                            lineWidth: 3,
                            percent: logic.downloadPercentage,
                            center: Text(
                              logic.downloadingText,
                              style: TextStyle(
                                fontFamily: Font.poppins,
                                fontWeight: FontWeight.w500,
                                color: CColor.theme,
                                fontSize: 10,
                              ),
                            ),
                            progressColor: CColor.theme,
                          )
                        : (!Constant.eBooks[index].isDownload)
                            ? SvgPicture.asset("assets/image/download.svg",
                                color: CColor.red)
                            : const SizedBox()
              ],
            ),
          ),
        ),
        (index == Constant.eBooks.length - 1)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                    height: 0,
                    color: CColor.viewGray.withOpacity(0.7),
                    thickness: 1.5),
              )
      ],
    );
  }
}
