import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/constant.dart';

class NewsController extends GetxController{
  repoData repo = repoData();
  bool isLoading = false;
  bool isOffline = false;

@override
  void onInit() {
  checkConnection();
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

  checkConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      isOffline = true;
      update();
    } else{
      isOffline = false;
      getData();
    }
  }

}