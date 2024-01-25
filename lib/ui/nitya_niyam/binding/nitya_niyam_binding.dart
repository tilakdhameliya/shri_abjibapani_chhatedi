import 'package:get/get.dart';
import 'package:satsang/ui/nitya_niyam/controller/nitya_niyam_controller.dart';

class NityaNiyamBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NityaNiyamController>(() => NityaNiyamController());
  }
}