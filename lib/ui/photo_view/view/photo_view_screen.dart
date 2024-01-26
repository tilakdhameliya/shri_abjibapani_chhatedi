import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:satsang/model/photo/photo_album_model.dart';
import 'package:satsang/utils/constant.dart';

import '../../../utils/font.dart';
import '../controller /photo_view_controller.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({super.key});

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: GetBuilder<PhotoViewController>(
            builder: (logic) {
              return Column(
                children: [
                  _header(logic),
                  _centerView(logic),
                ],
              );
            },
          ),
        ));
  }

  _header(PhotoViewController logic) {
    return Container(
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
                child: const Icon(Icons.arrow_back_rounded)
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${logic.currentIndex + 1}/${logic.images.length}",
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _centerView(PhotoViewController logic){
    return Expanded(
      child: PageView.builder(
        controller: Constant.photoController,
        scrollDirection: Axis.horizontal,
        itemCount: logic.images.length,
        onPageChanged: (index){
          logic.currentIndex = index;
          setState(() {});
        },
        itemBuilder: (BuildContext context, int index) {
          return _itemList(index,logic.images);
        },),
    );
  }

  _itemList(int index, List<Images> images){
    return Image.network(images[index].imageUrl.toString());
  }

}
