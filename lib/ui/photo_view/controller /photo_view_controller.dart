import 'package:get/get.dart';
import 'package:satsang/utils/constant.dart';

import '../../../model/photo/photo_album_model.dart';

class PhotoViewController extends GetxController{
  int index = 0;
  List<Images> images = [];
  int currentIndex = 0;

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        index = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        images = Get.arguments[1];
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    Constant.photoController.jumpToPage(index);
    super.onReady();
  }
}