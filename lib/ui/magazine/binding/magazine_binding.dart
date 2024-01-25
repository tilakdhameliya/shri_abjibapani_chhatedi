import 'package:get/get.dart';
import 'package:satsang/ui/magazine/controller/magazine_controller.dart';

class MagazineBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MagazineController>(() => MagazineController());
  }

}