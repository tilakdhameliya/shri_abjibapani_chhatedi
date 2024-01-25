import 'package:get/get.dart';
import 'package:satsang/ui/daily_satsang/controller/daily_satsang_controller.dart';

class DailySatsangBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DailySatsangController>(() => DailySatsangController());
  }

}