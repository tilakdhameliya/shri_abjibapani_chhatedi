import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/new_resume_data_model/new_resume_data_model.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/ui/sub_audio/controller/sub_audio_controller.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';

class SubAudioScreen extends StatefulWidget {
  const SubAudioScreen({super.key});

  @override
  State<SubAudioScreen> createState() => _SubAudioScreenState();
}

class _SubAudioScreenState extends State<SubAudioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GetBuilder<SubAudioController>(
          builder: (logic) {
            return Column(
              children: [
                _header(logic),
                _centerView(logic),
              ],
            );
          },
        ),
      ),
    );
  }

  _header(SubAudioController logic) {
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
          Text(logic.albumName,
            style: TextStyle(
            fontFamily: Font.poppins,
            fontWeight: FontWeight.w600,
            fontSize: 19,
          ),)
        ],
      ),
    );
  }

  _centerView(SubAudioController logic){
    return Expanded(
      child: ListView.builder(
        itemCount: logic.subAudio.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return _listItem(logic,index);
        },),
    );
  }

  _listItem(SubAudioController logic, int index){
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () async {
            Get.toNamed(AppRoutes.audioList,
                arguments: [logic.subAudio[index].name.toString(),logic.subAudio[index].image.toString()]);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 95,
                  margin:const EdgeInsets.only(right: 10) ,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(logic.subAudio[index].image
                            .toString()),
                      )),
                ),
                Expanded(
                  child: Text(
                    logic.subAudio[index].name.toString(),
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
        (index == logic.subAudio.length - 1)
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
}
