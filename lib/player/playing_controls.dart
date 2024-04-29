import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../utils/debugs.dart';

class PlayingControls extends StatefulWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  const PlayingControls({super.key,
    required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });

  @override
  State<PlayingControls> createState() => _PlayingControlsState();
}

class _PlayingControlsState extends State<PlayingControls> {
  Widget _loopIcon(BuildContext context) {
    double screenWidthSize = Get.width;
    bool isSmallDeviceWidth = (defaultTargetPlatform == TargetPlatform.iOS)?screenWidthSize <= 450:screenWidthSize <= 350;
    final iconSize = (isSmallDeviceWidth)?(defaultTargetPlatform == TargetPlatform.iOS)?38.0:25.0:43.0;
    if (widget.loopMode == LoopMode.none) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (widget.loopMode == LoopMode.playlist) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      //single
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          const Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidthSize = Get.width;
    bool isSmallDeviceWidth = screenWidthSize <= 350;
    final iconSize = (defaultTargetPlatform == TargetPlatform.iOS)?35.0:(isSmallDeviceWidth)?25.0:40.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: (isSmallDeviceWidth)?5:10),
          child: GestureDetector(
            onTap: () {
              if (widget.toggleLoop != null) widget.toggleLoop!();
            },
            child: _loopIcon(context),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            shadowColor: Colors.transparent,
            // fixedSize: Size(40, 40),
            padding: EdgeInsets.zero
          ),
          onPressed: widget.isPlaylist ? widget.onPrevious : null,
          child: SvgPicture.asset("assets/image/previous.svg",height:iconSize),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              shadowColor: Colors.transparent,
              // fixedSize: Size(40, 40),
              padding: EdgeInsets.zero
          ),
          onPressed: widget.onPlay,
          child: widget.isPlaying
              ? SvgPicture.asset("assets/image/pause.svg", height: iconSize)
              : SvgPicture.asset("assets/image/play.svg", height: iconSize),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              shadowColor: Colors.transparent,
              // fixedSize: Size(35, 35),
              padding: EdgeInsets.zero
          ),
          onPressed: widget.isPlaylist ? widget.onNext : null,
          child: SvgPicture.asset("assets/image/next.svg", height: iconSize),
        ),
        if (widget.onStop != null)
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  shadowColor: Colors.transparent,
                  // fixedSize: Size(35, 35),
                  padding: EdgeInsets.zero
              ),
              // padding: const EdgeInsets.all(16),
              onPressed: widget.onStop,
              child: SvgPicture.asset("assets/image/stop.svg", height:iconSize)),
      ],
    );
  }
}
