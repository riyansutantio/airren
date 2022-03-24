import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final pageNavBottom = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => pageNavBottom.value++;

  void onItemTapPage(int index) {
      pageNavBottom.value = index;
  }
}
