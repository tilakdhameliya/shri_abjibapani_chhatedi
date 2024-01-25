import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';
import 'package:satsang/utils/utils.dart';

import '../../../utils/constant.dart';
import '../../../utils/font.dart';

class PhotosScreen extends StatefulWidget {
   PhotosScreen({super.key});

  final PhotosController photoController = Get.put(PhotosController());

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotosController>(builder: (logic) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [const SizedBox(height: 65), _centerView(logic)],
            ),
          ));
    });
  }

  _centerView(PhotosController logic){
    return Expanded(
      child: MasonryGridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
        shrinkWrap: true,
        itemCount: Constant.photoAlbum.length,
        itemBuilder: (BuildContext context, int index) {
          return _gridItem(context, index,logic);
        },  crossAxisCount: 2,
      ),
    );
  }

  _gridItem(BuildContext context, int index, PhotosController logic) {
    return Container(
      // height: 80,
      width: index % 3 == 0? Get.width:Get.width * 0.5 ,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [Colors.black,Colors.white],begin: Alignment.bottomCenter,end: Alignment.center)
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network(Constant.photoAlbum[index].previewImage.toString(),
            fit: BoxFit.cover,
          ),
          Text(
            "${Constant.photoAlbum[index].name}",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Font.poppins,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }
}
