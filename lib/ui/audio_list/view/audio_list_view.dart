// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satsang/ui/audio_list/controller/audio_list_controller.dart';
import 'package:satsang/utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';

class AudioListScreen extends StatefulWidget {
  const AudioListScreen({super.key});

  @override
  State<AudioListScreen> createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<AudioListController>(
          builder: (logic) {
            return WillPopScope(
              onWillPop: ()async{
                logic.stop();
                setState(() {});
                return true;
              },
              child: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 65),
                      _centerView(logic),
                    ],
                  ),
                  _header(logic),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _header(AudioListController logic) {
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
              logic.stop();
              setState(() {});
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
                logic.audioListName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _centerView(AudioListController logic) {
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
                    Image.network(logic.audioImage),
                    const SizedBox(height: 15),
                    ListView.builder(
                      itemCount: logic.audioTrack.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return _listItem(logic, index,context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _listItem(AudioListController logic, int index,BuildContext context) {
    return InkWell(
      onTap: (){
        logic.play(index);
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: (index % 2 == 0)
                ? CColor.viewGray.withOpacity(0.6)
                : Colors.white),
        child: Row(
          children: [
            (logic.audioTrack[index].isPlayLoader == true)
                ? const SizedBox(height: 25,width: 25,child: CircularProgressIndicator(color: CColor.theme,strokeWidth: 1.5,))
                : SvgPicture.asset(
                    (logic.audioTrack[index].isPlay == true)
                        ? "assets/image/stop.svg"
                        : "assets/image/play.svg",
                    height: 35,
                    color: CColor.red),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                logic.audioTrack[index].name.toString(),
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                logic.downloadAudio(context, index, logic.audioTrack[index].url,
                    logic.audioTrack[index].name);
              },
              child: (logic.audioTrack[index].isLoader == true)
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        color: CColor.theme,
                        strokeWidth: 2,
                      ),
                    )
                  : (logic.audioTrack[index].isDownload == false)
                      ? SvgPicture.asset("assets/image/download.svg",
                          color: CColor.red)
                      : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  _loaderOpacity(AudioListController logic) {
    return logic.isLoading
        ? const Opacity(
            opacity: 0.6,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          )
        : Container();
  }

  _loader(AudioListController logic) {
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

class DurationState {
  const DurationState({this.progress, this.buffered, this.total});

  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}
