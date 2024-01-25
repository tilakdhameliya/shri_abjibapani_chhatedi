import 'package:get/get.dart';
import 'package:satsang/ui/facebook/controller/facebook_controller.dart';

class FacebookBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<FacebookController>(() => FacebookController());
  }

}