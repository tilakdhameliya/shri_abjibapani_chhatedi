import 'package:get/get.dart';
import 'package:html/parser.dart' as html;
import '../../../model/news/news_model.dart';

class NewsDetailController extends GetxController{
  News newsData = News();
  String detailText = "";

@override
  void onInit() {
    // TODO: implement onInit
  if(Get.arguments != null){
    if(Get.arguments[0] != null){
      newsData = Get.arguments[0];
    }

    detailText = html
        .parse(newsData.content ?? "")
        .documentElement!
        .text;

  }
    super.onInit();
  }
}