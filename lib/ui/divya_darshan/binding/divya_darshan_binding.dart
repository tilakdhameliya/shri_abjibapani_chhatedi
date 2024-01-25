import 'package:get/get.dart';
import 'package:satsang/ui/divya_darshan/controller/divya_darshan_controller.dart';

class DivyaDarshanaBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DivyaDarshanController>(() => DivyaDarshanController());
  }

}