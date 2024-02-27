import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/ui/audio/controller/audio_controller.dart';
import 'package:satsang/utils/constant.dart';

import '../../../utils/color.dart';
import '../../../utils/debugs.dart';
import '../../../utils/font.dart';
import '../../../utils/utils.dart';

class AudioViewScreen extends StatefulWidget {
  AudioViewScreen({super.key});

  final AudioController audioController = Get.put(AudioController());

  @override
  State<AudioViewScreen> createState() => _AudioViewScreenState();
}

class _AudioViewScreenState extends State<AudioViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AudioController>(builder: (logic) {
          return (logic.isOffline)
              ? _offLine(logic)
              : (logic.isLoader)
                  ? const CircularProgressIndicator(
                      color: Colors.black, strokeWidth: 2.5)
                  : _centerView(logic);
        }));
  }

  _centerView(AudioController logic) {
    return Column(
      children: [
        const SizedBox(height: 75),
        Expanded(
          child: ListView.builder(
            itemCount: Constant.audioSection.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return _listItem(logic, index);
            },
          ),
        ),
      ],
    );
  }

  _listItem(AudioController logic, int index) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (index == 0) {
              Constant.subAudio = Constant.audioAlbum
                  .where((element) => element.sectionId == "1")
                  .toList();
            } else if (index == 1) {
              Constant.subAudio = Constant.audioAlbum
                  .where((element) => element.sectionId == "2")
                  .toList();
            } else if (index == 2) {
              Constant.subAudio = Constant.audioAlbum
                  .where((element) => element.sectionId == "3")
                  .toList();
            }
            Get.toNamed(AppRoutes.subAudio, arguments: [
              Constant.subAudio,
              Constant.audioSection[index].name.toString()
            ]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 95,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                        Constant.audioSection[index].image.toString()),
                  )),
                ),
                Expanded(
                  child: Text(
                    Constant.audioSection[index].name.toString(),
                    style: TextStyle(
                      fontFamily: Font.poppins,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
        (index == Constant.audioSection.length - 1)
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                    height: 15,
                    color: CColor.viewGray.withOpacity(0.7),
                    thickness: 1.5),
              )
      ],
    );
  }

  _offLine(AudioController logic) {
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
              Constant.isOffline = true;
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
