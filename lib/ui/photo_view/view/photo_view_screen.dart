// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satsang/model/photo/photo_album_model.dart';
import 'package:satsang/utils/constant.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/color.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';
import '../controller /photo_view_controller.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarColor: CColor.black,
            systemNavigationBarColor: CColor.black,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarIconBrightness: Brightness.light),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: CColor.black,
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light),
            ),
            body: SafeArea(
              child: GetBuilder<PhotoViewController>(
                builder: (logic) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          _header(logic, context),
                          _centerView(logic),
                          _imageView(logic)
                        ],
                      ),
                      _loaderOpacity(logic),
                      _loader(logic)
                    ],
                  );
                },
              ),
            )));
  }

  _header(PhotoViewController logic, BuildContext context) {
    return Container(
      width: Get.width,
      height: 65,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.black,
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
                  color: Colors.white,
                )),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${logic.currentIndex + 1}/${logic.images.length}",
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              imageDialog(context, logic);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                "assets/image/more_vertical.svg",
                height: 23,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _centerView(PhotoViewController logic) {
    return Expanded(
      child: PageView.builder(
        controller: Constant.photoController,
        scrollDirection: Axis.horizontal,
        itemCount: logic.images.length ,
        onPageChanged: (index) {
          logic.currentIndex = index;
          setState(() {});
        },
        itemBuilder: (BuildContext context, int index) {
          return _itemList(index, logic.images);
        },
      ),
    );
  }

  _itemList(int index, List<Images> images) {
    return CachedNetworkImage(
      imageUrl: images[index].imageUrl.toString(),
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  _imageView(PhotoViewController logic) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: logic.images.length,
        controller: logic.imageController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              Constant.photoController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.linear);
            },
            child: Container(
                width: 70,
                margin: const EdgeInsets.all(5),
                child: CachedNetworkImage(
                  imageUrl: logic.images[index].imageUrl.toString(),
                  fit: BoxFit.fitHeight,
                  // placeholder: (context, url) => Center(
                  //   child: SvgPicture.asset("assets/image/gallery.svg"),
                  // ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )),
          );
        },
      ),
    );
  }

  Future<void> imageDialog(
      BuildContext context, PhotoViewController logic) async {
    return showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return GetBuilder<PhotoViewController>(
          builder: (logic) {
            return Dialog(
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: Get.width,
                          height: 35,
                          alignment: Alignment.center,
                          child: Text(
                            "Select the Action",
                            style: TextStyle(
                              fontFamily: Font.poppins,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                        const Divider(
                            height: 15, color: Colors.black, thickness: 2),
                        InkWell(
                          onTap: () {
                            Get.back();
                            logic.saveImage();
                          },
                          child: Container(
                            width: Get.width,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontFamily: Font.poppins,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.5,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            height: 15,
                            color: CColor.viewGray.withOpacity(0.7),
                            thickness: 1.5),
                        InkWell(
                          onTap: () {
                            Get.back();
                            logic.shareImage(
                                logic.images[logic.index].imageUrl.toString(),
                                context);
                          },
                          child: Container(
                            width: Get.width,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              "Share",
                              style: TextStyle(
                                fontFamily: Font.poppins,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.5,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {});
  }

  _loaderOpacity(PhotoViewController logic) {
    return logic.isLoader
        ? const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          )
        : Container();
  }

  _loader(PhotoViewController logic) {
    return logic.isLoader
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
