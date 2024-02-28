import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
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
    return GetBuilder<PhotosController>(
        builder: (logic) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: (logic.isOffline)
                ? _offLine(logic)
                :  _centerView(logic),
          ));
    });
  }

  _centerView(PhotosController logic) {
    return  (logic.isLoader)
        ? const Center(
          child: SizedBox(
            height: 45,
            width: 45,
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 3,
            ),
          ),
        )
        : MasonryGridView.count(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                    top: 80, right: 15, left: 15, bottom: 15),
                itemCount: Constant.photoAlbum.length,
                itemBuilder: (BuildContext context, int index) {
                  return _gridItem(context, index, logic);
                },
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
              );
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
        width: Get.width,
        height: (index % 2 == 0 && index != 0) ? 140 : 250,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
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

  _offLine(PhotosController logic){
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
            color:  CColor.black,
            height: 110,
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: Text(
              "OOPS!",
              style: TextStyle(
                color:  CColor.black,
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
                color: CColor.grayText,
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
                color: CColor.grayText,
                fontSize: 14,
                fontFamily: Font.poppins,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
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
                  color:  CColor.black,
                ),
              ),
              child: Center(
                child: Text(
                  "RETRY",
                  style: TextStyle(
                    color:  CColor.black,
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
