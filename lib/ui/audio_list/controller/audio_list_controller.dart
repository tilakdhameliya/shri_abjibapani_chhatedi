import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../../../model/audio/audio_track_model.dart';
import '../view/audio_list_view.dart';
import 'package:rxdart/rxdart.dart' as rx;

class AudioListController extends GetxController{
  String audioListName = "";
  String audioImage = "";
  bool isPlay = false;
  final player = AudioPlayer();
  List<AudioAlbumTracks> audioTrack = [];
  Stream<DurationState>? durationState;


  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        audioTrack = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        audioListName = Get.arguments[1];
      }
      if (Get.arguments[2] != null) {
        audioImage = Get.arguments[2];
      }
    }
    super.onInit();
  }

  playAudio(String url){
    durationState = rx.Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
            (position, playbackEvent) => DurationState(
          progress: position,
          buffered: playbackEvent.bufferedPosition,
          total: playbackEvent.duration,
        ));
    player.setUrl(url);
  }

}