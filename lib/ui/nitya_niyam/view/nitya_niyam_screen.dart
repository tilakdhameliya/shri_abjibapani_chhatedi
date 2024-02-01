import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';

import '../../../utils/debugs.dart';
import '../../../utils/font.dart';
import '../controller/nitya_niyam_controller.dart';

class NityaNiyamScreen extends StatefulWidget {
  const NityaNiyamScreen({super.key});

  @override
  State<NityaNiyamScreen> createState() => _NityaNiyamScreenState();
}

class _NityaNiyamScreenState extends State<NityaNiyamScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NityaNiyamController>(builder: (logic) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              _centerView(logic),
              _header(logic),
            ],
          ),
        ),
      );
    });
  }

  _header(NityaNiyamController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 65,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.2),
              offset: const Offset(0.0, 1.5),
              blurRadius: 1,
              spreadRadius: 0.5),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          Expanded(
            child: Text(
              "Nitya Niyam",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: Font.poppins,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  _centerView(NityaNiyamController logic) {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          (logic.isLoading)
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                )
              : PDFView(
                  filePath: logic.path,
                  enableSwipe: true,
                  autoSpacing: true,
                  pageFling: true,
                  onRender: (pages) {
                    setState(() {
                      pages = pages;
                      logic.isReady = true;
                    });
                  },
                  onError: (error) {
                    Debug.printLog("helllooooo ${error.toString()}");
                  },
                  onPageError: (page, error) {
                    logic.errorMessage = '$page: ${error.toString()}';
                    Debug.printLog('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    logic.controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {},
                ),
          logic.errorMessage.isEmpty
              ? !logic.isReady
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : Container()
              : Center(
                  child: Text(logic.errorMessage),
                )
        ],
      ),
    );
  }
}
