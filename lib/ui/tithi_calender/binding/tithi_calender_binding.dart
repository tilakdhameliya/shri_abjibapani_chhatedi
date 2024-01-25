import 'package:get/get.dart';
import 'package:satsang/ui/tithi_calender/controller/tithi_calender_controller.dart';

class TithiCalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TithiCalenderController>(() => TithiCalenderController());
  }
}
