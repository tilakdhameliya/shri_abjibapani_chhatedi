import 'package:get/get.dart';
import 'package:satsang/ui/sub_audio/controller/sub_audio_controller.dart';

class SubAudioBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SubAudioController>(() => SubAudioController());
  }

}