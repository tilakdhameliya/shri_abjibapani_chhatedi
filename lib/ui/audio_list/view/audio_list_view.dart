import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/audio_list/controller/audio_list_controller.dart';
import 'package:satsang/utils/color.dart';

import '../../../utils/font.dart';

class AudioListScreen extends StatefulWidget {
  const AudioListScreen({super.key});

  @override
  State<AudioListScreen> createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<AudioListController>(
          builder: (logic) {
            return Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            );
          },
        ),
      ),);
  }

  _header(AudioListController logic) {
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
            icon: const Icon(Icons.arrow_back_rounded),),
          const SizedBox(width: 85),
          Text(logic.audioListName,
            style: TextStyle(
              fontFamily: Font.poppins,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),)
        ],
      ),
    );
  }

  _centerView(AudioListController logic){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        children: [
          Image.network(logic.audioImage),
          Expanded(
            child: ListView.builder(
              itemCount: logic.audioTrack.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _listItem(logic,index);
              },),
          ),
        ],
      ),
    );
  }

  _listItem(AudioListController logic, int index){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
          color: (index % 2 == 0) ? CColor.viewGray : Colors.white),
      child: Row(
        children: [
          SvgPicture.asset("assets/image/play.svg"),
          Text(logic.audioTrack[index].name.toString()),
          SvgPicture.asset("assets/image/download.svg"),
        ],
      ),
    );
  }
}
