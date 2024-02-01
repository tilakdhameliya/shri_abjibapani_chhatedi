import 'package:get/get.dart';
import 'package:satsang/ui/registration/register/controller/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }

}