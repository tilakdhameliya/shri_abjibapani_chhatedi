// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
    return  Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<AudioListController>(
          builder: (logic) {
            return Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            );
          },
        ),
      ),);
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
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),),
          Expanded(
            child: Text(logic.audioListName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 19,
              ),),
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
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            children: [
              Image.network(logic.audioImage),
              const SizedBox(height: 15),
              ListView.builder(
                itemCount: logic.audioTrack.length,
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

  _listItem(AudioListController logic, int index){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
          color: (index % 2 == 0) ? CColor.viewGray.withOpacity(0.6) : Colors.white),
      child: Row(
        children: [
          InkWell(
              onTap: () async {
                if(logic.audioTrack[index].isPlay == false) {
                  await logic.playAudio(logic.audioTrack[index].url.toString());
                  if(index != 0) {
                    logic.audioTrack[index - 1].isPlay = false;
                  }
                  logic.audioTrack[index].isPlay = true;
                  await logic.player.play();
                }else if(logic.audioTrack[index].isPlay == true){
                  logic.audioTrack[index].isPlay = false;
                  await logic.player.pause();
                }
                setState(() {});
              },
              child: SvgPicture.asset((logic.audioTrack[index].isPlay == true)?"assets/image/stop.svg":"assets/image/play.svg", height: 35,color: CColor.red)),
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
                if (Constant.isStorage) {
                  if (await Permission.storage.isGranted) {
                    Preference.shared.setBool(Preference.isStorage, false);
                    Constant.isStorage =
                    Preference.shared.getBool(Preference.isStorage)!;
                  }
                }
                if (Platform.isAndroid) {
                  await logic.getAndroidVersion().then((value) => logic.version = value);
                }
                if (logic.version! > 32) {
                  if (Constant.isNotification || !Constant.isNotification) {
                    logic.downloadPdf(context,index,logic.audioTrack[index].url,logic.audioTrack[index].name);
                    setState(() {});
                  }
                } else {
                  if (Constant.isStorage) {
                    logic.showAlertDialogPermission(context, "storagePermission", true,index,logic.audioTrack[index].url,logic.audioTrack[index].name);
                  } else {
                    logic.downloadPdf(context,index,logic.audioTrack[index].url,logic.audioTrack[index].name);
                  }
              }
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
                : SvgPicture.asset("assets/image/download.svg",
                    color: CColor.red),
          ),
        ],
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

  StreamBuilder<DurationState> audioProgressBar(
      AudioListController logic) {
    return StreamBuilder<DurationState>(
      stream: logic.durationState,
      builder: (context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;
        return ProgressBar(
          progress: progress,
          buffered: buffered,
          total: total,
          onSeek: (duration) {

          },
          onDragUpdate: (details) {
            debugPrint('${details.timeStamp}, ${details.localPosition}');
          },
          barHeight: 5.0,
          baseBarColor: Colors.grey.withOpacity(0.2),
          progressBarColor: CColor.theme,
          bufferedBarColor: CColor.theme.withOpacity(0.2),
          thumbColor: CColor.viewGray,
          thumbGlowColor: Colors.green.withOpacity(0.3),
          barCapShape: BarCapShape.round,
          thumbRadius: 10.0,
          thumbCanPaintOutsideBar: true,
          timeLabelLocation: TimeLabelLocation.none,
          timeLabelType: TimeLabelType.totalTime,
          timeLabelTextStyle: TextStyle(
              fontSize: 8, color: Theme
              .of(context)
              .textTheme
              .bodyLarge
              ?.color),
          timeLabelPadding: 10,
        );
      },
    );
  }
}

class DurationState {
  const DurationState({this.progress, this.buffered, this.total});

  final Duration? progress;
  final Duration? buffered;
  final Duration? total;
}