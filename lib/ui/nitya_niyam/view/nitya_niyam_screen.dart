import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/color.dart';
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
        appBar: AppBar(
          backgroundColor: CColor.white,
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
        ),
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
            child: Center(
              child: Text(
                "Nitya Niyam",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 28)
        ],
      ),
    );
  }

  _centerView(NityaNiyamController logic) {
    return (logic.isOffline)
        ? _offLine(logic)
        : (logic.isLoading)
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    Text("Downloading...",style: TextStyle(
                      fontFamily: Font.poppins,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),)
                  ],
                ),
              )
            : Stack(
              children: [
                PDFView(
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
                      Debug.printLog(" error  ${error.toString()}");
                    },
                    onPageError: (page, error) {
                      logic.errorMessage = '$page: ${error.toString()}';
                      Debug.printLog('$page: ${error.toString()}');
                    },
                    onViewCreated: (PDFViewController pdfViewController) {
                      // logic.controller.complete(pdfViewController);
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
            );
  }

  _offLine(NityaNiyamController logic) {
    return Container(
      width: Get.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/image/no_internet.svg",
            // ignore: deprecated_member_use
            color: CColor.black,
            height: 110,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: Text(
              "OOPS!",
              style: TextStyle(
                color: CColor.black,
                fontSize: 25,
                fontWeight: FontWeight.w500,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.01),
            child: Text(
              "No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.01),
            child: Text(
              "Please check your connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.05),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              logic.checkConnection();
            },
            child: Container(
              height: Get.height * 0.06,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                border: Border.all(
                  color: CColor.black,
                ),
              ),
              child: Center(
                child: Text(
                  "RETRY",
                  style: TextStyle(
                    color: CColor.black,
                    fontFamily: Font.poppins,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
