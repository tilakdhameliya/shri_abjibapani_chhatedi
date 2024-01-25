import 'package:get/get.dart';
import 'package:satsang/ui/books/controller/books_controller.dart';

class BookBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BookController>(() => BookController());
  }
}