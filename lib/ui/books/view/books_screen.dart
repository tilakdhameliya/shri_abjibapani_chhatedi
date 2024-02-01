// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
                    _header(logic),
                    _centerView(logic),
                  ],
                ),
                _loaderOpacity(logic),
                _loader(logic)
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
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(
            child: Text(
              "E-books",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          )
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
          // splashColor: Colors.transparent,
          // highlightColor: Colors.transparent,
          onTap: () async {
            if (Constant.isStorage) {
              if (await Permission.storage.isGranted) {
                Preference.shared.setBool(Preference.isStorage, false);
                Constant.isStorage =
                    Preference.shared.getBool(Preference.isStorage)!;
              }
            }
            if (Platform.isAndroid) {
              await logic
                  .getAndroidVersion()
                  .then((value) => logic.version = value);
            }
            if (logic.version! > 32) {
              if (Constant.isNotification || !Constant.isNotification) {
                logic.downloadAudio(
                    context,
                    index,
                    Constant.eBooks[index].url,
                    Constant.eBooks[index].name);
                setState(() {});
              }
            } else {
              if (Constant.isStorage) {
                logic.showAlertDialogPermission(
                    context,
                    "storagePermission",
                    true,
                    index,
                    Constant.eBooks[index].url,
                    Constant.eBooks[index].name);
              } else {
                logic.downloadAudio(
                    context,
                    index,
                    Constant.eBooks[index].url,
                    Constant.eBooks[index].name);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 95,
                  margin: const EdgeInsets.only(right:20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit.cover,
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
                (Constant.eBooks[index].isLoader == true)
                    ? const SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                          color: CColor.theme,
                          strokeWidth: 2,
                        ),
                      )
                    : SvgPicture.asset("assets/image/download.svg",
                        color: CColor.red)
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

  _loaderOpacity(BookController logic) {
    return logic.isLoading
        ? const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          )
        : Container();
  }

  _loader(BookController logic) {
    return logic.isLoading
        ? WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(35),
                height: 88,
                width: 88,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
            ),
          )
        : Container();
  }
}
