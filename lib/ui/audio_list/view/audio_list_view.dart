// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:satsang/player/PositionSeekWidget.dart';
import 'package:satsang/ui/audio_list/controller/audio_list_controller.dart';
import 'package:satsang/utils/color.dart';
import 'package:satsang/utils/constant.dart';
import '../../../player/PlayingControls.dart';
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
          id: Constant.audioId,
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
          const SizedBox(width: 28)
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
                    audioBar(logic),
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
                await logic.assetsAudioPlayer.open(
                  logic.audios[index],
                  showNotification: true,
                  playInBackground: PlayInBackground.enabled,
                  audioFocusStrategy: const AudioFocusStrategy.request(
                      resumeAfterInterruption: true,
                      resumeOthersPlayersAfterDone: true),
                  headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                  notificationSettings: const NotificationSettings(
                  ),
                );
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
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: CColor.theme,
                                  strokeWidth: 1.5,
                                ),
                              )
                            : (logic.audioTrack[index].isIndicator)
                                ? CircularPercentIndicator(
                                    radius: 15.0,
                                    lineWidth: 3.0,
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
                                : (!logic.audioTrack[index].isDownload)
                                    ? SvgPicture.asset(
                                        "assets/image/download.svg",
                                        color: CColor.theme)
                                    : const SizedBox(),
                      ),
                    ],
                  ),
                  // (logic.audioTrack[index].isPlay)
                  //     ? audioProgressBar(logic, index)
                  //     : const SizedBox()
                ],
              ),
            ),
          );
        });
  }

  audioBar(AudioListController logic) {
    return Column(
      children: <Widget>[
        logic.assetsAudioPlayer.builderLoopMode(
          builder: (context, loopMode) {
            return PlayerBuilder.isPlaying(
                player: logic.assetsAudioPlayer,
                builder: (context, isPlaying) {
                  return PlayingControls(
                    loopMode: loopMode,
                    isPlaying: isPlaying,
                    isPlaylist: true,
                    onStop: () {
                      setState(() {
                        logic.assetsAudioPlayer.stop().then((value) {
                          setState(() {});
                        })  ;
                      });
                    },
                    toggleLoop: () {
                      setState(() {
                        logic.assetsAudioPlayer.toggleLoop().then((value) {
                          setState(() {});
                        });
                      });
                    },
                    onPlay: () {
                      setState(() {
                        logic.assetsAudioPlayer.playOrPause().then((value) {
                          setState(() {});
                        });
                      });
                    },
                    onNext: () {
                      setState(() {
                        logic.assetsAudioPlayer.next().then((value) {
                          setState(() {});
                        });
                      });
                    },
                    onPrevious: () {
                      setState(() {
                        logic.assetsAudioPlayer.previous().then((value) {
                          setState(() {});
                        });
                      });
                    },
                  );
                });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 8),
              child: Text(
                logic.assetsAudioPlayer.getCurrentAudioArtist,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.5,
                ),
              ),
            ),
            logic.assetsAudioPlayer.builderRealtimePlayingInfos(
                builder: (context, RealtimePlayingInfos? infos) {
              if (infos == null) {
                return const SizedBox();
              }
              return Column(
                children: [
                  PositionSeekWidget(
                    currentPosition: infos.currentPosition,
                    duration: infos.duration,
                              seekTo: (to) {
                                logic.assetsAudioPlayer.seek(to);
                              },
                            ),
                          ],
                        );
                      }),
                ],
              ),

            ],
          );
  }
}
