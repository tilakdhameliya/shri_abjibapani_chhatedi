import 'package:get/get.dart';
import 'package:satsang/ui/audio/controller/audio_controller.dart';

class AudioBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AudioController>(() => AudioController());
  }
}
