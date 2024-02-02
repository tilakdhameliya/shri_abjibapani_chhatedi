import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../model/audio/audio_track_model.dart';
import '../../../new_resume_data_model/new_resume_data_model.dart';
import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/debugs.dart';
import '../../../utils/font.dart';
import '../../../utils/preference.dart';
import '../view/audio_list_view.dart';
import 'package:rxdart/rxdart.dart' as rx;

class AudioListController extends GetxController {
  String audioListName = "";
  String audioImage = "";
  bool isPlay = false;
  bool isLoading = true;
  final player = AudioPlayer();
  List<AudioAlbumTracks> audioTrack = [];
  Stream<DurationState>? durationState;
  int resumeNumber = 0;
  int nullResumeNumber = 0;

  String downloadedAudioName = "";
  ResumeData repo = ResumeData();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        audioListName = Get.arguments[0];
      }
      if (Get.arguments[1] != null) {
        audioImage = Get.arguments[1];
      }
    }
    super.onInit();
  }

  @override
  void onReady() async {
    await repo.getAudioTrack(audioListName).then((value) {
      if (value.audioAlbumTracks != null) {
        audioTrack = value.audioAlbumTracks!;
      }
      isLoading = false;
      update();
    });
    super.onReady();
  }

  play(int index) async {
    audioTrack[index].isPlayLoader = true;
    update();
    if (audioTrack[index].isPlay == false) {
      await playAudio(audioTrack[index].url.toString());
      var playIndex =
          audioTrack.indexWhere((element) => element.isPlay == true);
      if (playIndex > -1) {
        audioTrack[playIndex].isPlay = false;
      }
      audioTrack[index].isPlayLoader = false;
      audioTrack[index].isPlay = true;
      await player.play().then((value) {
        audioTrack[index].isPlayLoader = false;
        update();
      });
      update();
    } else if (audioTrack[index].isPlay == true) {
      audioTrack[index].isPlay = false;
      audioTrack[index].isPlayLoader = false;
      await player.pause();
    }
    update();
  }

  playAudio(String url) {
    durationState =
        rx.Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
            player.positionStream,
            player.playbackEventStream,
            (position, playbackEvent) => DurationState(
                  progress: position,
                  buffered: playbackEvent.bufferedPosition,
                  total: playbackEvent.duration,
                ));
    player.setUrl(url);
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

  downloadAudio(context, int index, url, fileName) async {
    audioTrack[index].isLoader = true;
    update();

    if (Platform.isAndroid) {
      await getAndroidVersion().then((value) {
        version = value;
      });
    }

    List<String> list = [];
    int cnt = 0;

    downloadedAudioName =
        Preference.shared.getString(Preference.downloadedResumeName) ?? "";
    nullResumeNumber =
        Preference.shared.getInt(Preference.nullResumeNumber) ?? 0;

    for (int i = 0; i < list.length; i++) {
      if (list[i] == fileName) {
        cnt++;
      }
    }

    resumeNumber = cnt;
    if (Platform.isAndroid) {
      if (version! > 32) {
        if (await Permission.notification.isGranted) {
          // var downloadUrl = "https://stq7twcobd.execute-api.us-east-1.amazonaws.com/api/resume/pdf/${Preference.shared.getString(Preference.resumeId)}";
          var downloadUrl = url;
          download(
            downloadUrl,
            fileName,index);
          update();
        } else {
          var downloadUrl = url;
          download(
            downloadUrl,
              fileName,index);
          update();
        }
      } else {
        if (!Constant.isStorage) {
          var downloadUrl = url;
          download(
            downloadUrl,
              fileName,index);
        }
      }
    } else if (Platform.isIOS) {
      var downloadUrl = url;
      download(
        downloadUrl,
          fileName,index);
    }
  }

  var downloadFilePah = "";

  Future download(String url, String filename, int index) async {
    audioTrack[index].isLoader = true;
    update();
    Debug.printLog("-----------------------------url------------$url");
    var savePath = "";
    if (Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      savePath = "${dir.path}/$filename.mp3";
    } else {
      savePath = '/storage/emulated/0/download/$filename.mp3';
    }
    downloadFilePah = savePath;

    var dio = Dio();
    dio.interceptors.add(LogInterceptor());

    try {
      update();
      var response = await dio.download(
        url,
        savePath,
        onReceiveProgress: (count, total) {
          if (count != 33) {
            // showDownloadProgress(count, total, savePath);
          } else {
            // audioTrack[index].isLoader = false;
            update();
            Fluttertoast.showToast(msg: "Resume Not Download");
          }
          Debug.printLog("Count total =================> $count $total");
          if (count == total) {
            downloadAudioAndNotification(savePath,index);
            update();
          }
        },
      );

    } catch (e) {
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
      bool isPermanentlyDenied, int index, url,fileName) async {
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
                            audioTrack[index].isLoader = false;
                            Get.back();
                            await Permission.storage.request().then(
                                  (value) => downloadAudio(context, index, url,fileName),
                                );
                          } else if (permission == "notificationPermission") {
                            audioTrack[index].isLoader = false;
                            await Permission.notification.request().then(
                                  (value) => downloadAudio(context, index, url,fileName),
                                );
                          } else if (isPermanentlyDenied) {
                            openAppSettings();
                          } else {
                            downloadAudio(context, index, url,fileName);
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

  downloadAudioAndNotification(String savePath,index) {
    Debug.printLog("downloadFilePah downloadFilePah........$savePath");
    showDownloadNotification(savePath);
    /* Get.snackbar(
      'Success',
      'File downloaded successfully',
      colorText: CColor.black,
      margin: const EdgeInsets.only(bottom: 5),
      duration: const Duration(days: 50),
      mainButton: TextButton(
        onPressed: () async {
          if (Platform.isAndroid) {
            Utils.sendData(savePath);
          } else if (Platform.isIOS) {
            await OpenFile.open(savePath);
          }
        },
        child: Text(
          "View",
          style: TextStyle(
            fontFamily: Font.poppins,
            fontSize: 16,
            color: CColor.theme,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );*/
    audioTrack[index].isLoader = false;
    update();
  }

}
