import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PlayingControls extends StatefulWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  PlayingControls({
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
    bool isSmallDeviceWidth = screenWidthSize <= 350;
    final iconSize = (isSmallDeviceWidth)?25.0:45.0;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
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
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder(),),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shadowColor: MaterialStatePropertyAll(Colors.transparent)),
          onPressed: widget.isPlaylist ? widget.onPrevious : null,
          child: SvgPicture.asset("assets/image/previous.svg", height: (isSmallDeviceWidth)?25.0:45),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder()),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shadowColor: MaterialStatePropertyAll(Colors.transparent)),
          onPressed: widget.onPlay,
          child: widget.isPlaying
              ? SvgPicture.asset("assets/image/pause.svg", height: (isSmallDeviceWidth)?25.0:45)
              : SvgPicture.asset("assets/image/play.svg", height: (isSmallDeviceWidth)?25.0:45),
        ),
        ElevatedButton(
          style: const ButtonStyle(
              shape: MaterialStatePropertyAll(CircleBorder()),
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              shadowColor: MaterialStatePropertyAll(Colors.transparent)),
          onPressed: widget.isPlaylist ? widget.onNext : null,
          child: SvgPicture.asset("assets/image/next.svg", height: (isSmallDeviceWidth)?25.0:45),
        ),
        if (widget.onStop != null)
          ElevatedButton(
              style: const ButtonStyle(
                  shape: MaterialStatePropertyAll(CircleBorder()),
                  backgroundColor: MaterialStatePropertyAll(Colors.white),
                  shadowColor: MaterialStatePropertyAll(Colors.transparent)),
              // padding: const EdgeInsets.all(16),
              onPressed: widget.onStop,
              child: SvgPicture.asset("assets/image/stop.svg", height: (isSmallDeviceWidth)?25.0:45)),
      ],
    );
  }
}
