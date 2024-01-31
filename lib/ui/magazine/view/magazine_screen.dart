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
import '../controller/magazine_controller.dart';

class MagazineScreen extends StatefulWidget {
  const MagazineScreen({super.key});

  @override
  State<MagazineScreen> createState() => _MagazineScreenState();
}

class _MagazineScreenState extends State<MagazineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<MagazineController>(
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

  _header(MagazineController logic) {
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
              "Magazines",
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

  _centerView(MagazineController logic) {
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: Constant.magazines.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _listItem(logic, index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _listItem(MagazineController logic, int index) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
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
                    Constant.magazines[index].url,
                    Constant.magazines[index].name);
                setState(() {});
              }
            } else {
              if (Constant.isStorage) {
                logic.showAlertDialogPermission(
                    context,
                    "storagePermission",
                    true,
                    index,
                    Constant.magazines[index].url,
                    Constant.magazines[index].name);
              } else {

                logic.downloadAudio(
                    context,
                    index,
                    Constant.magazines[index].url,
                    Constant.magazines[index].name);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Constant.magazines[index].name.toString(),
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                (Constant.magazines[index].isLoader == true)
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
        (index == Constant.magazines.length - 1)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                    height: 15,
                    color: CColor.viewGray.withOpacity(0.7),
                    thickness: 1.5),
              )
      ],
    );
  }

  _loaderOpacity(MagazineController logic) {
    return logic.isLoading
        ? const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          )
        : Container();
  }

  _loader(MagazineController logic) {
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
