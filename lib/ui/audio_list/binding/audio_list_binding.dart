import 'package:get/get.dart';
import 'package:satsang/ui/audio_list/controller/audio_list_controller.dart';

class AudioListBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AudioListController>(() => AudioListController());
  }

}