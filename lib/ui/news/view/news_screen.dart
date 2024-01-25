import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      return AnnotatedRegion(
          value: const SystemUiOverlayStyle(
              statusBarColor: CColor.white,
              systemNavigationBarColor: CColor.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarIconBrightness: Brightness.dark),
          child: Scaffold(
            bottomSheet: (Constant.isShowBottomSheet)
                ? Utils.customBottomSheet(context)
                : const SizedBox(),
            backgroundColor: Colors.white,
            body: Column(
              children: [const SizedBox(height: 65), _centerView(logic)],
            ),
          ));
    });
  }

  _centerView(NewsController logic) {
    return Expanded(
      child: ListView.builder(
        itemCount: Constant.newsList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                onTap: (){
                  Get.toNamed(AppRoutes.newsDetailScreen,arguments: [Constant.newsList[index]]);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Constant.newsList[index].title.toString(),
                                  style: TextStyle(
                                    fontFamily: Font.poppins,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Constant.newsList[index].time.toString(),
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
                                    fit: BoxFit.fill)),
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
    );
  }
}
