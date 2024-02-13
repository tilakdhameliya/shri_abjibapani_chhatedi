import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/constant.dart';

class NewsController extends GetxController{
  repoData repo = repoData();
  bool isLoading = false;

@override
  void onInit() {
  getData();
    super.onInit();
  }

  getData() async {
    isLoading = true;
    await repo.getNews().then((value) {
      Constant.newsList = value.news!;
      for (int i = 0; i < Constant.newsList.length; i++) {
        final newsPhoto = Image.network(Constant.newsList[i].thumb.toString());
        precacheImage(newsPhoto.image, Get.context!);
      }
    });
    isLoading = false;
    update();
  }
}