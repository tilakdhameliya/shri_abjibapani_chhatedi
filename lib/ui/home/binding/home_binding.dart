import 'package:get/get.dart';
import 'package:satsang/ui/audio/controller/audio_controller.dart';
import 'package:satsang/ui/daily_satsang/controller/daily_satsang_controller.dart';
import 'package:satsang/ui/home/controller/home_controller.dart';
import 'package:satsang/ui/photo/controller/photo_controller.dart';
import 'package:satsang/ui/tithi_calender/controller/tithi_calender_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<AudioController>(() => AudioController(),fenix: true);
    // Get.lazyPut<DailySatsangController>(() => DailySatsangController(),fenix: true);
    // Get.lazyPut<PhotosController>(() => PhotosController(),fenix: true);
    // Get.lazyPut<TithiCalenderController>(() => TithiCalenderController(),fenix: true);
  }
}