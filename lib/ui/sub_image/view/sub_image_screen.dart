import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/sub_image/controller/sub_image_controller.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';

class SubImageScreen extends StatefulWidget {
  const SubImageScreen({super.key});

  @override
  State<SubImageScreen> createState() => _SubImageScreenState();
}

class _SubImageScreenState extends State<SubImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: CColor.white,
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
        ),
        body: SafeArea(
          child: GetBuilder<SubImageController>(
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

  _header(SubImageController logic) {
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
                logic.albumName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Font.poppins,
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Get.back();
            },
            child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(Icons.arrow_back_rounded
                ,color: Colors.transparent)
            ),
          ),
        ],
      ),
    );
  }

  _centerView(SubImageController logic){
    return (logic.isLoading)
        ? const Expanded(
            child: Center(
              child: SizedBox(
                height: 45,
                width: 45,
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 3,
                ),
              ),
            ),
          )
        : Expanded(
            child: MasonryGridView.builder(
              itemCount: logic.subImages.length,
              itemBuilder: (BuildContext context, int index) {
                return  InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.photoView,
                        arguments: [index,logic.subImages]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        logic.subImages[index].thumbUrl.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            ),/*MasonryGridView.count(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  top: 15, right: 15, left: 15, bottom: 15),
              shrinkWrap: true,
              itemCount: logic.subImages.length,
              itemBuilder: (BuildContext context, int index) {
                return _gridItem(context, index, logic);
              },
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 2,
            ),*/
          );
  }

  _gridItem(BuildContext context, int index, SubImageController logic) {
    return Wrap(
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.photoView,
                arguments: [index,logic.subImages]);
          },
          child: Container(
            height: 150,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(logic.subImages[index].thumbUrl.toString()),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // _centerView(SubImageController logic){
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: logic.subImages.length,
  //       shrinkWrap: true,
  //       physics: const BouncingScrollPhysics(),
  //       itemBuilder: (BuildContext context, int index) {
  //         return _listItem(logic,index);
  //       },),
  //   );
  // }
  //
  // _listItem(SubImageController logic, int index) {
  //   return Column(
  //     children: [
  //       InkWell(
  //         splashColor: Colors.transparent,
  //         highlightColor: Colors.transparent,
  //         onTap: () {
  //           Get.toNamed(AppRoutes.photoView,
  //               arguments: [index,logic.subImages]);
  //         },
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //           child: Row(
  //             children: [
  //               Container(
  //                 height: 70,
  //                 width: 95,
  //                 margin: const EdgeInsets.only(right:20),
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(15),
  //                     image: DecorationImage(
  //                       fit: BoxFit.cover,
  //                   image: NetworkImage(
  //                       logic.subImages[index].thumbUrl.toString()),
  //                 )),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   "${index + 1}",
  //                   style: TextStyle(
  //                     fontFamily: Font.poppins,
  //                     fontWeight: FontWeight.w600,
  //                     fontSize: 17,
  //                   ),
  //                 ),
  //               ),
  //               const Icon(Icons.arrow_forward_ios_rounded)
  //             ],
  //           ),
  //         ),
  //       ),
  //       (index == logic.subImages.length - 1)
  //           ? const SizedBox()
  //           : Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 15),
  //               child: Divider(
  //                   height: 15,
  //                   color: CColor.viewGray.withOpacity(0.7),
  //                   thickness: 1.5),
  //             )
  //     ],
  //   );
  // }
}
