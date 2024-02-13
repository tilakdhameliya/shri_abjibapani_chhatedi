import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/magazine/magazine_model.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/debugs.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';

class MagazineController extends GetxController {
  bool isLoading = false;
  bool isCom = false;
  int resumeNumber = 0;
  int nullResumeNumber = 0;
  String downloadedAudioName = "";
  repoData repo = repoData();

  void showDownloadNotification(String savePath) async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(threadIdentifier: 'thread_id');
      const platformChannelSpecifics =
          NotificationDetails(iOS: iOSPlatformChannelSpecifics);
      await Constant.flutterLocalNotificationsPlugin.show(
        0,
        'Resume Downloaded',
        'Your resume has been downloaded successfully!',
        platformChannelSpecifics,
        payload: savePath,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      const androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: 'app_icon',
        visibility: NotificationVisibility.public,
        enableVibration: true,
        playSound: true,
      );
      const platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await Constant.flutterLocalNotificationsPlugin.show(
        0,
        'Downloaded',
        'Downloaded successfully!',
        platformChannelSpecifics,
        payload: savePath,
      );
    }
  }

  int? version;

  downloadAudio(context, int index, url, fileName) async {
    isCom = true;

    update();

    if (Platform.isAndroid) {
      await getAndroidVersion().then((value) {
        version = value;
      });
    }

    if (Platform.isAndroid) {
      if (version! > 32) {
        if (await Permission.notification.isGranted) {
          var downloadUrl = url;
          download(downloadUrl, fileName, index);
          update();
        } else {
          var downloadUrl = url;
          download(downloadUrl, fileName, index);
          update();
        }
      } else {
        if (Constant.isStorage) {
          showAlertDialogPermission(
              context, "storagePermission", true, index, url, fileName);
        } else {
          download(url, fileName, index);
        }
      }
    } else if (Platform.isIOS) {
      var downloadUrl = url;
      download(downloadUrl, fileName, index);
    }
  }

  var downloadFilePah = "";
  late File outputFile;

  Future download(String url, String filename, int index) async {
    Constant.magazines[index].isLoader = true;
    update();
    Debug.printLog("-----------------------------url------------$url");
    var savePath = "";
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      savePath = "${dir.path}/$filename.pdf";
    } else {
      savePath =
          '/storage/emulated/0/download/abjibapani chhatedi/$filename.pdf';
    }
    downloadFilePah = savePath;
    outputFile = File(savePath);

    var dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      update();
      if (await outputFile.exists()) {
        Constant.magazines[index].isLoader = false;
        Constant.magazines[index].isDownload = true;
        isCom = false;
        Get.toNamed(AppRoutes.pdfView,
            arguments: [savePath, Constant.magazines[index].name]);
        update();
      } else {
        Constant.magazines[index].isLoader = true;
        var response = await dio.download(
          url,
          savePath,
          onReceiveProgress: (count, total) {
            if (count != 33) {
              if (count == total) {
                downloadAudioAndNotification(savePath, index);
                update();
              }
            } else {
              update();
              Fluttertoast.showToast(msg: "Pdf Not Download");
            }
            Debug.printLog("Count total =================> $count $total");
          },
        );
      }
    } catch (e) {
      Constant.magazines[index].isLoader = false;
      debugPrint(e.toString());
    }
    update();
  }

  double? progress = 0;
  bool isProgress = false;

  Future<int?> getAndroidVersion() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    throw UnsupportedError("Platform is not Android");
  }

  Future<void> showAlertDialogPermission(context, String permission,
      bool isPermanentlyDenied, int index, url, fileName) async {
    return showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            padding: EdgeInsets.only(
              top: Get.height * 0.02,
              left: Get.width * 0.05,
              right: Get.width * 0.05,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: CColor.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  permission == "storagePermission" &&
                          isPermanentlyDenied == false
                      ? "You have to turn on storage permission for this function from the setting."
                      : permission == "notificationPermission"
                          ? "You have to turn on notification permission for this function from the setting."
                          : isPermanentlyDenied
                              ? "To download audio, You need to go settings and allow storage."
                              : "",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontFamily: Font.poppins,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * 0.01,
                    bottom: Get.height * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "CANCEL",
                          style: TextStyle(
                            color: CColor.theme,
                            fontFamily: Font.poppins,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (permission == "storagePermission" &&
                              isPermanentlyDenied == false) {
                            Constant.magazines[index].isLoader = false;
                            Get.back();
                            await Permission.storage.request().then(
                                  (value) => downloadAudio(
                                      context, index, url, fileName),
                                );
                          } else if (permission == "notificationPermission") {
                            Constant.magazines[index].isLoader = false;
                            await Permission.notification.request().then(
                                  (value) => downloadAudio(
                                      context, index, url, fileName),
                                );
                          } else if (isPermanentlyDenied) {
                            openAppSettings();
                          } else {
                            downloadAudio(context, index, url, fileName);
                          }
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: CColor.theme,
                            fontFamily: Font.poppins,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> data= [];

  downloadAudioAndNotification(String savePath, index) {
    Debug.printLog("downloadFilePah downloadFilePah........$savePath");
    showDownloadNotification(savePath);
    isCom = false;
    Constant.magazines[index].isDownload = true;
    var download = Constant.magazines.where((element) => element.isDownload == true);
    data = download.map((track) => jsonEncode(track.toJson())).toList();
    Preference.shared.setStringList(Preference.downloadedMagazineList,
        data);
    Debug.printLog("------>>>> downloaded data $data");
    Debug.printLog(
        "------>>>> downloaded List ${Preference.shared.getStringList(Preference.downloadedMagazineList)}");
    Get.toNamed(AppRoutes.pdfView,
        arguments: [savePath, Constant.magazines[index].name]);
    Fluttertoast.showToast(msg: "Download pdf successfully");
    Constant.magazines[index].isLoader = false;
    update();
  }

  @override
  void onInit() {
    getData();
    List<MurtiMagazines> magazineTracksList = [];
    var stringList =
    Preference.shared.getStringList(Preference.downloadedMagazineList) ?? [];
    if (stringList.isNotEmpty) {
      for(var data in stringList){
        magazineTracksList.add(MurtiMagazines.fromJson(jsonDecode(data)));
      }
      for (int i = 0; i < magazineTracksList.length; i++) {
        var index = Constant.magazines
            .indexWhere((element) => element.name == magazineTracksList[i].name);
        if (index > -1) {
          Constant.magazines[index].isDownload = true;
        }
      }
    }
    super.onInit();
  }

  getData() async {
    isLoading = true;
    await repo.getMagazine().then((value) {
      Constant.magazines = value.murtiMagazines!;
    });
    isLoading = false;
    update();
  }
}
