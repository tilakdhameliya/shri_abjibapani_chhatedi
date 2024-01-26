import 'package:get/get.dart';
import 'package:satsang/ui/sub_image/controller/sub_image_controller.dart';

class SubImageBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SubImageController>(() => SubImageController());
  }
}