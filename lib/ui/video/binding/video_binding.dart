import 'package:get/get.dart';
import 'package:satsang/ui/video/controller/video_controller.dart';

class VideoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VideoController>(() => VideoController());
  }
}