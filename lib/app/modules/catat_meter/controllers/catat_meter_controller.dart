import 'dart:convert';

import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../provider/catat_meter_provider.dart';

class CatatMeterController extends GetxController {
  CatatMeterProvider catatmeterProvider;

  CatatMeterController({required this.catatmeterProvider});

  final SessionController sessionController =
      Get.put(SessionController(sessionProvider: SessionProvider()));

  final count = 0.obs;
  final isLoadingCatatMeter = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await getMeterMonth();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() async {
    await getMeterMonth();
  }

  void increment() => count.value++;
  final boxUser = GetStorage();
  final isLoadingMeterMonth = false.obs;
  final meterMonthResult = <MonthMeterResult>[].obs;

  //manage bulan
  final month_Of = 0.obs;
  final year_Of = 0.obs;

  Future getMeterMonth() async {
    try {
      isLoadingMeterMonth.value = true;
      final res = await catatmeterProvider.getMeterMonth(
          bearer: boxUser.read(tokenBearer));
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.e("Error,There is no data");
      } else {
        if (res.message == "Meter months retrieved successfully") {
          meterMonthResult.addAll(res.data!.meterMonths!);
          // int meterlen = meterMonthResult.length;
          // for (int i = 0; i<=meterlen; i++) {
          //   logger.e(meterMonthResult[i].month_of);
          // }
          update();
        } else {
          logger.e("salah disini");
        }
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingMeterMonth.value = false;
    }
  }

  Future addCatatMeterBulan() async {
    final res = await catatmeterProvider.addCatatMeterBulan(
      bearer: boxUser.read(tokenBearer),
      monthOf: month_Of.toInt(),
      yearOf: year_Of.toInt(),
    );
    logger.e(res.status);
    if (res.status! == 'success') {
      await getMeterMonth();
      logger.d(res.status! + " menambahkan catat meter bulanan");
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
      update();
    } else {
      logger.d(res.status);
      snackBarNotificationFailed(title: "Gagal ditambahkan");
    }
  }
}
