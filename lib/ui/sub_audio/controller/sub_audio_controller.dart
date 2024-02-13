import 'package:get/get.dart';

import '../../../model/audio/audio_album_model.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';

class SubAudioController extends GetxController{
  List<AudioAlbums> subAudio = [];
  repoData repo = repoData();
  String albumName = "";

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        subAudio = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        albumName = Get.arguments[1];
      }
    }
    super.onInit();
  }
}