import 'package:get/get.dart';

import '../controllers/customer_controller.dart';
import '../providers/customer_provider.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(
      () =>CustomerController(p: CustomerProviders()),
    );
  }
}
