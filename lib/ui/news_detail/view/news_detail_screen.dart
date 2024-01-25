import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:satsang/ui/news_detail/controller/news_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/color.dart';
import '../../../utils/font.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsDetailController>(builder: (logic)
    {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              _centerView(logic),
              _header(),

            ],
          ),
        ),
      );
    });
  }

  _header() {
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
      child: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded)),
    );
  }

  _centerView(NewsDetailController logic){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
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
                            logic.newsData.title.toString(),
                            style: TextStyle(
                              fontFamily: Font.poppins,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            logic.newsData.time.toString(),
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
                              image:
                                  NetworkImage(logic.newsData.thumb.toString()),
                              fit: BoxFit.fill)),
                    ),

                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(
                height: 15,
                color: CColor.viewGray.withOpacity(0.7),
                thickness: 1.5),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Html(
                data: logic.newsData.content,
                shrinkWrap: true,
                onLinkTap: (url, map, element) async {
                  if (await canLaunch(url!)) {
                    await launch(
                      url,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
          )
        ],
      ),
    );
  }


}
