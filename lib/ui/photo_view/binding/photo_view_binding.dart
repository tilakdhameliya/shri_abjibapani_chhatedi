import 'package:get/get.dart';
import 'package:satsang/ui/photo_view/controller%20/photo_view_controller.dart';

class PhotoViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewController>(() => PhotoViewController());
  }

}