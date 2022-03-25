import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(
      () => AccountController(accountProvider: AccountProvider()),
    );
  }
}
