import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:satsang/model/calender/tithi_calender_model.dart';
import 'package:satsang/routes/app_routes.dart';
import '../../../../utils/constant.dart';
import '../../../../utils/debugs.dart';
import '../../../../utils/network_connectivity.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/offline_popup.dart';
import 'package:flutter/services.dart' as root_bundle;
import '../../../utils/preference.dart';


class SplashController extends GetxController {
  Map source = {ConnectivityResult.none: false};
  final NetworkConnectivity networkConnectivity = NetworkConnectivity.instance;
  String string = '';
  bool isLoadData = true;
  ResumeData repo = ResumeData();


  @override
  void onInit() {
    super.onInit();
    networkConnectivity.initialise();
    networkConnectivity.myStream.listen((source) async {
      source = source;
      // 1.
      switch (source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.wifi:
          string = source.values.toList()[0] ? 'Online' : 'Offline';
          break;
        case ConnectivityResult.none:
        default:
          string = 'Offline';
      }
      // 2.
      update();
      // 3.
      Debug.printLog("connection status=====>>>>>>>$string");
      if (string == "Online" && isLoadData) {
        isLoadData = false;
        getPermission();
        moveToScreen();
      } else if (string == "Offline" && Constant.isOffline) {
        isLoadData = true;
        Constant.isOffline = false;
        showOfflineDialog();
      }
    });
  }

  moveToScreen() async {
    await repo.getAudioAlbum().then((value) {
      Debug.printLog("----->>> audio album $value");
      Constant.audioAlbum = value.audioAlbums!;
    });
    await repo.getPhotoAlbum().then((value) {
      Constant.photoAlbum = value.photoAlbums!;
/*      for (int i = 0; i < Constant.photoAlbum.length; i++) {
        final photo =
        Image.network(Constant.photoAlbum[i].previewImage.toString());
        precacheImage(photo.image, Get.context!);
        for (int j = 0; j < Constant.photoAlbum[i].images!.length; j++) {
          final image = Image.network(
              Constant.photoAlbum[i].images![j].thumbUrl.toString());
          precacheImage(image.image, Get.context!);
          final fullImage = Image.network(
              Constant.photoAlbum[i].images![j].imageUrl.toString());
          precacheImage(fullImage.image, Get.context!);
        }
      }*/
      for (int i = 0; i < Constant.photoAlbum.length; i++) {
        final fullImage =
            Image.network(Constant.photoAlbum[i].previewImage.toString());
        precacheImage(fullImage.image, Get.context!);
      }
    });
    await repo.getNews().then((value) {
      Constant.newsList = value.news!;
      for (int i = 0; i < Constant.newsList.length; i++) {
        final newsPhoto = Image.network(Constant.newsList[i].thumb.toString());
        precacheImage(newsPhoto.image, Get.context!);
      }
    });
    await repo.getMagazine().then((value) {
      Constant.magazines = value.murtiMagazines!;
    });
    await repo.getEBooks().then((value) {
      Constant.eBooks = value.ebooks!;
    });
    await repo.getAudioAlbum().then((value) {
      Constant.audioSection = value.audioSections!;
    });
    await getJsonData();
    Get.offAllNamed(AppRoutes.homeScreen);
    Debug.printLog("hello world");
  }

  getPermission() async {
    Constant.isGetNotificationPermission =
    Preference.shared.getBool(Preference.isGetNotificationPermission)!;
    Constant.isGetStoragePermission = Preference.shared.getBool(Preference.isGetStoragePermission)!;
    Constant.isGetPhotoPermission = Preference.shared.getBool(Preference.isGetPhotoPermission)!;

    Constant.isNotification =
    Preference.shared.getBool(Preference.isNotification)!;
    Constant.isStorage = Preference.shared.getBool(Preference.isStorage)!;

    if (!Constant.isGetNotificationPermission) {
      var notificationPermission = await Permission.notification.request();
      Constant.isNotification = notificationPermission.isDenied;
      Preference.shared
          .setBool(Preference.isNotification, Constant.isNotification);
      Preference.shared.setBool(Preference.isGetNotificationPermission,
          !Constant.isGetNotificationPermission);
      Constant.isGetNotificationPermission =
      Preference.shared.getBool(Preference.isGetNotificationPermission)!;
    }

    if (!Constant.isGetStoragePermission) {
      var storagePermission = await Permission.storage.request();
      Constant.isStorage = storagePermission.isDenied;
      Preference.shared.setBool(Preference.isStorage, Constant.isStorage);
      Preference.shared.setBool(
          Preference.isGetStoragePermission, !Constant.isGetStoragePermission);
      Constant.isGetStoragePermission =
      Preference.shared.getBool(Preference.isGetStoragePermission)!;
    }

    if(!Constant.isGetPhotoPermission){
      var storagePermission = await Permission.photos.request();
      Constant.isPhoto = storagePermission.isDenied;
      Preference.shared.setBool(Preference.isPhoto, Constant.isPhoto);
      Preference.shared.setBool(
          Preference.isGetPhotoPermission, !Constant.isGetPhotoPermission);
      Constant.isGetPhotoPermission =
      Preference.shared.getBool(Preference.isGetPhotoPermission)!;
    }
  }

  getJsonData() async {
    final jsondata = await DefaultAssetBundle.of(Get.context!)
        .loadString("assets/tithi_calender.json");
    final list = jsonDecode(jsondata);
    if (list != null) {
      Constant.tithiCalender = HeaderLines.fromJson(list["HeaderLines"]);
      var now = DateTime.now();
      var formatter = DateFormat('yyyy-MM-dd');
      String currentDate = formatter.format(now);

      for (int i = 0; i < Constant.tithiCalender.headerLine!.length; i++) {
        if (currentDate == Constant.tithiCalender.headerLine![i].date) {
          Constant.dailyQuote = Constant.tithiCalender.headerLine![i].suvichar.toString();
        }
      }
    }
  }
}
