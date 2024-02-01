import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/divya_darshan/controller/divya_darshan_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DivyaDarshanScreen extends StatelessWidget {
  DivyaDarshanScreen({super.key});

   final DivyaDarshanController darshanController = Get.put(DivyaDarshanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DivyaDarshanController>(
        builder: (logic) {
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 65),
                Expanded(
                  child: WebViewWidget(
                    controller: darshanController.controller,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
