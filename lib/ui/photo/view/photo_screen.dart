import 'package:auto_height_grid_view/auto_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';
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
            child: _centerView(logic),
          ));
    });
  }

  _centerView(PhotosController logic) {
    return  Container(
      padding: const EdgeInsets.only(top: 75, right: 10, left: 10, bottom: 10),
      child: MasonryGridView.builder(
        itemCount: Constant.photoAlbum.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.subImage, arguments: [
                Constant.photoAlbum[index].images,
                Constant.photoAlbum[index].name
              ]);
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  Constant.photoAlbum[index].previewImage.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );/*MasonryGridView.count(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 80, right: 15, left: 15, bottom: 15),
      itemCount: Constant.photoAlbum.length,
      itemBuilder: (BuildContext context, int index) {
        return _gridItem(context, index, logic);
      },
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 2,
    );*/
  }

  _gridItem(BuildContext context, int index, PhotosController logic) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.subImage, arguments: [
          Constant.photoAlbum[index].images,
          Constant.photoAlbum[index].name
        ]);
      },
      child: Container(
        // width: Get.width,
        // height: (index % 2 == 0 && index != 0) ? 140 : 250,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
                Constant.photoAlbum[index].previewImage.toString()),
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.001),
                  ], begin: Alignment.bottomCenter, end: Alignment.center)),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "${Constant.photoAlbum[index].name}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
