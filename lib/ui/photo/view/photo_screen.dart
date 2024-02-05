import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';
import 'package:satsang/utils/utils.dart';

import '../../../routes/app_routes.dart';
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
        },
        crossAxisSpacing: 5,
        mainAxisSpacing: 5, crossAxisCount: 2,

      ),
    );
  }

  _gridItem(BuildContext context, int index, PhotosController logic) {
    return Wrap(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.subImage,
                arguments: [Constant.photoAlbum[index].images,Constant.photoAlbum[index].name]);
          },
          child: Container(
            height: 150,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(Constant.photoAlbum[index].previewImage.toString()),
                ),
               ),
            child: Text(
              "${Constant.photoAlbum[index].name}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Font.poppins,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 11.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
