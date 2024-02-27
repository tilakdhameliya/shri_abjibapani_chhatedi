import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/network_connectivity.dart';

class PhotosController extends GetxController{
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoadData = true;
  repoData repo = repoData();
  bool isOffline = false;
  bool isLoader = false;
  bool isCall = false;


  getData() async {
    isLoader = true;
       await repo.getPhotoAlbum().then((value) async {
        Constant.photoAlbum = value.photoAlbums!;
        for (int i = 0; i < Constant.photoAlbum.length; i++) {
          final fullImage =
          Image.network(Constant.photoAlbum[i].previewImage.toString());
          await precacheImage(fullImage.image, Get.context!);
        }
      });
    isLoader = false;
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

  @override
  void onInit() {
    checkConnection();
    super.onInit();
  }

}