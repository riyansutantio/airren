import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(accountProvider: AccountProvider()),
    );
  }
}
