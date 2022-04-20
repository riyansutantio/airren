import 'dart:convert';

import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../model/catat_meter/add_catat_meter_bulan_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../home/controllers/home_controller.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../provider/catat_meter_provider.dart';

class CatatMeterController extends GetxController {
  CatatMeterProvider catatmeterProvider;

  CatatMeterController({required this.catatmeterProvider});

  final SessionController sessionController =
      Get.put(SessionController(sessionProvider: SessionProvider()));

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getMeterMonth();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  Future<void> onClose() async {
    await getMeterMonth();
  }

  void increment() => count.value++;
  final boxUser = GetStorage();
  final isLoadingMeterMonth = false.obs;
  final meterMonthResult = <MonthMeterResult>[].obs;
  List<MonthMeterResult> listCMB = [];

  //manage bulan
  final month_Of = 0.obs;
  final year_Of = 0.obs;

  Future getMeterMonth() async {
    try {
      isLoadingMeterMonth.value = true;
      final res = await catatmeterProvider.getMeterMonth(
          bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
      } else if (res.message == "Meter Month successfully retrived") {
        logger.e("Meter Month successfully retrived");
        meterMonthResult.assignAll(res.data!.monthMeters!);
      } else {
        logger.e('Meter Month unsuccessfully retrived');
        meterMonthResult.assignAll(res.data!.monthMeters!);
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
      month_of: month_Of.toInt(),
      year_of: year_Of.toInt(),
    );
    if (res.status! == 'success') {
      await getMeterMonth();
      logger.d(res.status! + " menambahkan catat meter bulanan");
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: "Gagal ditambahkan");
      logger.d(res.status! + " gagal catat meter bulanan");
    }
  }
}
