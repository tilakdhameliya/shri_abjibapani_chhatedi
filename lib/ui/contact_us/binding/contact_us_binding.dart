import 'package:get/get.dart';
import 'package:satsang/ui/contact_us/controller/contact_us_controller.dart';

class ContactBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }

}
