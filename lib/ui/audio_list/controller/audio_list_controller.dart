import 'package:get/get.dart';
import '../../../model/audio/audio_track_model.dart';

class AudioListController extends GetxController{
  String audioListName = "";
  String audioImage = "";
  List<AudioAlbumTracks> audioTrack = [];

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
}