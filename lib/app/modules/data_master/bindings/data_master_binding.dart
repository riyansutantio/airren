import 'package:get/get.dart';

import '../controllers/data_master_controller.dart';

class DataMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataMasterController>(
      () => DataMasterController(),
    );
  }
}
