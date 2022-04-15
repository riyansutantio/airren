import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:get/get.dart';

import '../controllers/data_master_controller.dart';

class DataMasterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DataMasterController>(
      () => DataMasterController(masterDataProvider: MasterDataProvider()),
    );
  }
}
