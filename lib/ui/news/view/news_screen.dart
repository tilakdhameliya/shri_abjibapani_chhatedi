import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:satsang/routes/app_routes.dart';
import 'package:satsang/utils/constant.dart';
import 'package:satsang/utils/font.dart';
import '../../../utils/color.dart';
import '../../../utils/utils.dart';
import '../controller/news_controller.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({super.key});

  final NewsController newsController = Get.put(NewsController());

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(builder: (logic) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: CColor.white,
            elevation: 0,
            toolbarHeight: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
          ),
          body: Stack(
            children: [_centerView(logic), _header(logic)],
          ));
    });
  }

  _centerView(NewsController logic) {
    return (logic.isOffline)
        ? _offLine(logic)
        : (logic.isLoading)
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
        : Column(
          children: [
            const SizedBox(height: 65),
            Expanded(
                child: ListView.builder(
                  itemCount: Constant.newsList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.newsDetailScreen,
                                arguments: [Constant.newsList[index]]);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            Constant.newsList[index].title
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: Font.poppins,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            Constant.newsList[index].time
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: Font.poppins,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Container(
                                      height: 70,
                                      width: 95,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(Constant
                                                  .newsList[index].thumb
                                                  .toString()),
                                              // fit: BoxFit.fill
                    )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        (index == Constant.newsList.length - 1)
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
                  },
                ),
              ),
          ],
        );
  }

  _header(NewsController logic) {
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
                "News",
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

  _offLine(NewsController logic){
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
