// ignore_for_file: library_private_types_in_public_api

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:satsang/utils/color.dart';
import '../utils/font.dart';

class PositionSeekWidget extends StatefulWidget {
  final Duration currentPosition;
  final Duration duration;
  final Function(Duration) seekTo;
  final AssetsAudioPlayer assetsAudioPlayer;


  const PositionSeekWidget({super.key,
    required this.currentPosition,
    required this.duration,
    required this.seekTo, required this.assetsAudioPlayer,

  });

  @override
  _PositionSeekWidgetState createState() => _PositionSeekWidgetState();
}

class _PositionSeekWidgetState extends State<PositionSeekWidget> {
  late Duration _visibleValue;
  bool listenOnlyUserInteraction = false;
  double get percent => widget.duration.inMilliseconds == 0
      ? 0
      : _visibleValue.inMilliseconds / widget.duration.inMilliseconds;

  @override
  void initState() {
    super.initState();
    _visibleValue = widget.currentPosition;
  }

  @override
  void didUpdateWidget(PositionSeekWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listenOnlyUserInteraction) {
      _visibleValue = widget.currentPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8,left: 8,bottom: 5,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.assetsAudioPlayer.getCurrentAudioTitle,
            style: TextStyle(
              fontFamily: Font.poppins,
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 45,
                child: Text(durationToString(widget.currentPosition),style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),),
              ),
              Expanded(
                child: Slider(
                  min: 0,
                  max: widget.duration.inMilliseconds.toDouble(),
                  value: percent * widget.duration.inMilliseconds.toDouble(),
                  activeColor: CColor.theme,
                  inactiveColor: Colors.grey,
                  onChanged: (newValue) {
                    setState(() {
                      final to = Duration(milliseconds: newValue.floor());
                      _visibleValue = to;
                    });
                  },
                  onChangeStart: (_) {
                    setState(() {
                      listenOnlyUserInteraction = true;
                    });
                  },
                  onChangeEnd: (newValue) {
                    setState(() {
                      listenOnlyUserInteraction = false;
                      widget.seekTo(_visibleValue);
                    });
                  },
                ),
              ),
              SizedBox(
                width: 45,
                child: Text(durationToString(widget.duration),style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  final twoDigitMinutes =
      twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
  final twoDigitSeconds =
      twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
  return '$twoDigitMinutes:$twoDigitSeconds';
}
