import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import '../../../utils/font.dart';
import '../controller /pdf_controller.dart';

class PdfScreen extends StatefulWidget {
   PdfScreen({super.key});

  final PdfController pdfController  = Get.put(PdfController());

  @override
  State<PdfScreen> createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfController>(builder: (logic) {
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

  _header(PdfController logic) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: Get.width,
      height: 70,
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
      child: Wrap(
        children: [
          Row(
            children: [
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  Get.back();
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                    )),
              ),
              Expanded(
                child: Text(
                  logic.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Font.poppins,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              // Container(
              //     padding: const EdgeInsets.all(10),
              //     child: const Icon(Icons.arrow_back_rounded
              //         ,color: Colors.transparent)
              // ),
            ],
          ),
        ],
      ),
    );
  }

  _centerView(PdfController logic){
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 70),
            Expanded(
              child: PDFView(
                filePath: logic.path,
                enableSwipe: true,
                autoSpacing: false,
                pageFling: true,
                onRender: (pages) {
                  setState(() {
                    pages = pages;
                    logic.isReady = true;
                  });
                },
                onError: (error) {
                  print("helllooooo ${error.toString()}");
                },
                onPageError: (page, error) {
                  logic.errorMessage = '$page: ${error.toString()}';
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  logic.controller.complete(pdfViewController);
                },
                onPageChanged: (int? page, int? total) {},
              ),
            ),
          ],
        ),
        logic.errorMessage.isEmpty
            ? !logic.isReady
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container()
            : Center(
                child: Text(logic.errorMessage),
              )
      ],
    );
  }
}
