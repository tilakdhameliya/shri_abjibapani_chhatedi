import 'package:get/get.dart';

import '../../../model/photo/photo_album_model.dart';

class SubImageController extends GetxController{
  List<Images> images = [];
  String albumName = '';

@override
  void onInit() {
    if(Get.arguments != null) {
      if (Get.arguments[0] != null) {
        images = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        albumName = Get.arguments[1];
      }
    }
    super.onInit();
  }
}