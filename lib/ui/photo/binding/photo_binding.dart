import 'package:get/get.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';

class PhotosBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PhotosController>(() => PhotosController());
  }
}