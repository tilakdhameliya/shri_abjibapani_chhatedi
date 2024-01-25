import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/ui/audio/controller/audio_controller.dart';
import 'package:satsang/utils/constant.dart';

import '../../../utils/color.dart';
import '../../../utils/debugs.dart';
import '../../../utils/font.dart';

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
          return _centerView(logic);
        }));
  }




  _centerView(AudioController logic){
    return Column(
      children: [
        const SizedBox(height: 75),
        ListView.builder(
          itemCount: Constant.audioSection.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _listItem(logic,index);
          },),
      ],
    );
  }

  _listItem(AudioController logic, int index){
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: (){
            if(index == 0) {
              Constant.subAudio =
                  Constant.audioAlbum.where((element) => element.sectionId ==
                      "1").toList();
            }else if(index == 1){
              Constant.subAudio =
                  Constant.audioAlbum.where((element) => element.sectionId ==
                      "2").toList();
            }else if(index == 2){
              Constant.subAudio =
                  Constant.audioAlbum.where((element) => element.sectionId ==
                      "3").toList();
            }
            Get.toNamed(AppRoutes.subAudio,arguments: [Constant.subAudio,Constant.audioSection[index].name.toString()]);
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
                          image: NetworkImage(Constant.audioSection[index].image
                              .toString()),
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

}
