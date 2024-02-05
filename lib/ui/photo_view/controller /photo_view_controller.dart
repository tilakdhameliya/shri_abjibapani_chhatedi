import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:satsang/utils/constant.dart';
import 'package:share_plus/share_plus.dart';
import '../../../model/photo/photo_album_model.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../utils/debugs.dart';


class PhotoViewController extends GetxController{
  int index = 0;
  List<Images> images = [];
  int currentIndex = 0;
  bool isLoader = false;
  bool isSelected = false;
  ScrollController imageController = ScrollController();

  @override
  void onInit() {
    if(Get.arguments != null){
      if(Get.arguments[0] != null){
        index = Get.arguments[0];
      }
      if (Get.arguments[1] != null) {
        // images = [];
        images = Get.arguments[1];
/*        Debug.printLog("----->> image index ${images.length} ${Get.arguments[1]}");
        images.insert(0, Images());
        images.insert(1, Images());
        Debug.printLog("----->> image index ${images.length}");
        int index = images.length - 1;
        images.insert(index + 1, Images());
        int index2 = images.length - 1;
        images.insert(index2 + 1, Images());
        Debug.printLog("----->> image ${images.length} $index $index2");*/
      }
    }
    super.onInit();
  }

  @override
  void onReady() {
    Constant.photoController.jumpToPage(index);
    imageController.jumpTo(index.toDouble());
    super.onReady();
  }

  Future<void> shareImage(String imageUrl, BuildContext context) async {
    isLoader = true;
    update();
    http.Response response = await http.get(Uri.parse(imageUrl));
    Uint8List bytes = response.bodyBytes;

    File file = await saveImageToFile(bytes, 'image.jpg');
    isLoader = false;
    update();
    Share.shareFiles([file.path]);
    update();
  }

  Future<File> saveImageToFile(Uint8List bytes, String fileName) async {
    String dir = (await getApplicationDocumentsDirectory()).path;

    File file = File('$dir/$fileName');
    await file.writeAsBytes(bytes);
    return file;
  }

  saveImage(int index) {
    isLoader = true;
    update();
    String url = images[index].imageUrl.toString();
    GallerySaver.saveImage(url).then((value) {
      if (value == true) {
        Fluttertoast.showToast(msg: "Image Save successfully");
        isLoader = false;
        update();
      } else {
        Fluttertoast.showToast(msg: "Image not save");
        isLoader = false;
        update();
      }
    });
    update();
  }
}