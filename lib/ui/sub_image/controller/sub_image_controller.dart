import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/photo/photo_album_model.dart';

class SubImageController extends GetxController{
  List<Images> subImages = [];
  String albumName = '';
  bool isLoading = false;

@override
  void onInit() {
    if(Get.arguments != null) {
      if (Get.arguments[0] != null) {
        subImages = Get.arguments[0];
      }
      if(Get.arguments[1] != null){
        albumName = Get.arguments[1];
      }
// dataLoad();
    }
    super.onInit();
  }

  dataLoad() async {
    isLoading = true;
    update();
    for(var element in subImages){
      final fullImage =
      Image.network(element.thumbUrl.toString());
      await precacheImage(fullImage.image, Get.context!);
    }
    isLoading = false;
    update();
  }
}