import 'package:get/get.dart';
import 'package:satsang/ui/news_detail/controller/news_details_controller.dart';

class NewsDetailBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NewsDetailController>(() => NewsDetailController());
  }

}