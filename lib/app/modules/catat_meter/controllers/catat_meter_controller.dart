import 'dart:convert';

import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/model/catat_meter/catat_meter_model.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/customer/controllers/customer_controller.dart';
import 'package:airen/app/modules/customer/providers/customer_provider.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../model/customer/customerModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../provider/catat_meter_provider.dart';

class CatatMeterController extends GetxController {
  CatatMeterProvider catatmeterProvider;

  CatatMeterController({required this.catatmeterProvider});
  CustomerController? CC;
  CustomerProviders? CP;
  final SessionController sessionController =
      Get.put(SessionController(sessionProvider: SessionProvider()));

  final count = 0.obs;
  final isLoadingCatatMeter = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await getMeterMonth();
    if (searchValue.value != '') {
      // await CC!.getCusUsers();
    }
  }

  @override
  void onReady() async {
    super.onReady();
    debounce(searchValue, (val) {
      return searchManage();
    }, time: 500.milliseconds);
  }

  @override
  void onClose() async {
    await getMeterMonth();
  }

  void increment() => count.value++;
  final boxUser = GetStorage();
  final isLoadingMeterMonth = false.obs;
  final meterMonthResult = <MonthMeterResult>[].obs;
  final catatMeterresult = <CatatMeterResult>[].obs;
  final cusUserResult = <CustomerModel>[].obs;
  RxInt isRadio = 1.obs;
  final idManageCatatBulan = 0.obs;
  final searchValue = ''.obs;
  final judul = ''.obs;
  final isSearch = false.obs;
  final bulan = 0.obs;
  final searchController = TextEditingController();

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
          // List result = meterMonthResult.fold({}, (previousValue, element) {
          //   Map val = previousValue as Map;
          //   String date = element['year_of'];

          // });
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

  Future getCatatMeter() async {
    try {
      isLoadingCatatMeter.value = true;
      final res = await catatmeterProvider.getCatatMeter(
          bearer: boxUser.read(tokenBearer), bulan: bulan.value);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        //Get.to(UnauthenticationView());
        logger.i('kosong');
        logger.d(catatMeterresult);
      } else {
        catatMeterresult.addAll(res.data!.meters!);
        //logger.d(catatMeterresult);
        //logger.wtf(res.data!.meters!);
        update();
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingCatatMeter.value = false;
    }
  }

  Future<void> closeSearchAppBar() async {
    isSearch.value = false;
    searchValue.value = '';
  }

  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((e) => e[0]).take(2).join()
      : '';

  Future searchManage() async {
    isLoadingCatatMeter.value = true;
    final res = await catatmeterProvider.getSearchCus(
        bearer: boxUser.read(tokenBearer), searchValue: searchValue.value);
    // logger.wtf(res!.data!.data!.toList());
    cusUserResult.assignAll(res!.data!.cusMs!);
  }

  Future deleteMeterBulan() async {
    final res = await catatmeterProvider.deleteMeterBulan(
        bearer: boxUser.read(tokenBearer),
        id: idManageCatatBulan.value.toString());
    if (res!.message! == 'Meter month successfully deleted') {
      await getCatatMeter();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil dihapus');
    } else {
      snackBarNotificationFailed(title: 'Gagal dihapus');
      sessionController.authError();
    }
  }
}
