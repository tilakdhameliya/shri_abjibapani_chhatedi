import 'dart:async';
import 'package:flutter_pdfview/flutter_pdfview.dart';
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
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/debugs.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';

class NityaNiyamController extends GetxController {
  bool isLoading = false;
  int resumeNumber = 0;
  int nullResumeNumber = 0;
  String downloadedAudioName = "";
  String path = "";
  bool isReady = false;
  String errorMessage = '';

  final Completer<PDFViewController> controller =
      Completer<PDFViewController>();

  @override
  void onInit() {
    downloadPdf("Nitya_Niyam");
    super.onInit();
  }

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

  downloadPdf(fileName) async {
    isLoading = true;
    update();

    if (Platform.isAndroid) {
      await getAndroidVersion().then((value) {
        version = value;
      });
    }

    if (Platform.isAndroid) {
      if (version! > 32) {
        if (await Permission.notification.isGranted) {
          download(fileName);
          update();
        } else {
          download(fileName);
          update();
        }
      } else {
        if (!Constant.isStorage) {
          download(fileName);
        }
      }
    } else if (Platform.isIOS) {
      download(fileName);
    }
  }

  var downloadFilePah = "";
  late File outputFile;

  Future download(String filename) async {
    isLoading = true;
    update();
    var savePath = "";
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      savePath = "${dir.path}/$filename.pdf";
    } else {
      savePath = '/storage/emulated/0/download/$filename.pdf';
    }
    downloadFilePah = savePath;
    outputFile = File(savePath);

    var dio = Dio();
    dio.interceptors.add(LogInterceptor());
    String url = "http://abjibapanichhatedi.org/ebooks/sayam%20prarthana.pdf";
    try {
      update();
      if (await outputFile.exists()) {
        isLoading = false;
        path = savePath;

        Debug.printLog("hello world");
        update();
      } else {
        await dio.download(
          url,
          savePath,
          onReceiveProgress: (count, total) {
            if (count != 33) {
              if (count == total) {
                downloadAudioAndNotification(savePath);
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
      isLoading = false;
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

  Future<void> showAlertDialogPermission(
      String permission, bool isPermanentlyDenied, fileName) async {
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
                            isLoading = false;
                            Get.back();
                            await Permission.storage.request().then(
                                  (value) => downloadPdf(fileName),
                                );
                          } else if (permission == "notificationPermission") {
                            isLoading = false;
                            await Permission.notification.request().then(
                                  (value) => downloadPdf(fileName),
                                );
                          } else if (isPermanentlyDenied) {
                            openAppSettings();
                          } else {
                            downloadPdf(fileName);
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

  downloadAudioAndNotification(String savePath) {
    Debug.printLog("downloadFilePah downloadFilePah........$savePath");
    // showDownloadNotification(savePath);
    path = savePath;
    Fluttertoast.showToast(msg: "Download pdf successfully");
    isLoading = false;
    update();
  }
}
