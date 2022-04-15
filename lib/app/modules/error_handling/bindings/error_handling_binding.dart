import 'package:get/get.dart';

import '../controllers/error_handling_controller.dart';

class ErrorHandlingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ErrorHandlingController>(
      () => ErrorHandlingController(),
    );
  }
}
