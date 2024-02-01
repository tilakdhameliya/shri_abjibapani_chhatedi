import 'dart:async';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

class PdfController extends GetxController {
  String path = "";
  String name = "";
  bool isReady = false;
  String errorMessage = '';
  final Completer<PDFViewController> controller =
      Completer<PDFViewController>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[0] != null) {
        path = Get.arguments[0];
      }
      if (Get.arguments[1] != null) {
        name = Get.arguments[1];
      }
    }
    super.onInit();
  }
}