import 'package:airen/app/modules/account/controllers/account_controller.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/modules/home/views/home_view.dart';
import 'package:airen/app/modules/session/views/login_view.dart';
import 'package:airen/app/routes/app_pages.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await checkStateUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  final boxUser = GetStorage();

  checkStateUser() async {
    logger.i(boxUser.read(tokenBearer));
    await Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => boxUser.read(tokenBearer) == null ? Get.offAllNamed(Routes.SESSION) : Get.to(HomeView()));
  }
}
