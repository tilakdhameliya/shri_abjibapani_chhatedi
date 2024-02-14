// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:satsang/ui/audio_list/controller/audio_list_controller.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/debugs.dart';
import '../../../utils/font.dart';

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
              onWillPop: () async {
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
      // padding: const EdgeInsets.all(10),
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
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
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
                        return _listItem(logic, index, context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  _listItem(AudioListController logic, int index, BuildContext context) {
    return GetBuilder<AudioListController>(
        id: Constant.audioId,
        builder: (logic) {
          return InkWell(
            onTap: () async {
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
              child: Column(
                children: [
                  Row(
                    children: [
                      (logic.audioTrack[index].isPlayLoader)
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                color: CColor.theme,
                                strokeWidth: 1.5,
                              ))
                          : SvgPicture.asset(
                              (logic.audioTrack[index].isPlay)
                                  ? "assets/image/stop.svg"
                                  : "assets/image/play.svg",
                              height: 35,
                              color: CColor.theme),
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
                          logic.downloadAudio(
                              context,
                              index,
                              logic.audioTrack[index].url,
                              logic.audioTrack[index].name);
                        },
                        child: (logic.audioTrack[index].isLoader)
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: CircularProgressIndicator(
                                  color: CColor.theme,
                                  strokeWidth: 2,
                                ),
                              )
                            : (!logic.audioTrack[index].isDownload)
                                ? SvgPicture.asset("assets/image/download.svg",
                                    color: CColor.theme)
                                : const SizedBox(),
                      ),
                    ],
                  ),
                  (logic.audioTrack[index].isPlay)
                      ? audioProgressBar(logic, index)
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
  }

  StreamBuilder<DurationState> audioProgressBar(
      AudioListController logic, index) {
    return StreamBuilder<DurationState>(
      stream: logic.durationState,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final durationState = snapshot.data;
          final progress = durationState?.progress ?? Duration.zero;
          final buffered = durationState?.buffered ?? Duration.zero;
          final total = durationState?.total ?? Duration.zero;
          return Padding(
            padding: const EdgeInsets.only(right: 50, left: 50, top: 10),
            child: ProgressBar(
              progress: progress,
              buffered: buffered,
              total: total,
              onSeek: (duration) {
                logic.player.seek(duration);
              },
              onDragUpdate: (details) {
                debugPrint(
                    ' details--=-=-]]]  ${details.timeStamp}, ${details.localPosition}');
                setState(() {});
              },
              barHeight: 5.0,
              baseBarColor: Colors.grey.withOpacity(0.2),
              progressBarColor: CColor.theme,
              thumbColor: CColor.theme,
              barCapShape: BarCapShape.round,
              thumbRadius: 10.0,
              thumbCanPaintOutsideBar: true,
              timeLabelLocation: TimeLabelLocation.none,
              timeLabelType: TimeLabelType.totalTime,
              timeLabelTextStyle: TextStyle(
                  fontSize: 8,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
              timeLabelPadding: 10,
            ),
          );
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  StreamBuilder<PlayerState> playButton(AudioListController logic, int index) {
    return StreamBuilder<PlayerState>(
      stream: logic.player.playerStateStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (logic.audioTrack[index].isPlayLoader == true) {
            return const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                    color: CColor.theme, strokeWidth: 1.5));
          } else if (logic.audioTrack[index].isPlay == true) {
            return SvgPicture.asset("assets/image/stop.svg",
                height: 35, color: CColor.theme);
          } else {
            return SvgPicture.asset("assets/image/play.svg",
                height: 35, color: CColor.theme);
          }
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else {
          return const CircularProgressIndicator();
        }
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
