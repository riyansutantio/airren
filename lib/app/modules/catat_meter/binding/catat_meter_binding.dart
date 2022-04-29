import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:get/get.dart';

import '../controllers/catat_meter_controller.dart';

class CatatMeterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatatMeterController>(
        () => CatatMeterController(catatmeterProvider: CatatMeterProvider()),
        fenix: true);
  }
}
