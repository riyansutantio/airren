import 'dart:convert';

import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/model/catat_meter/catat_meter_model.dart';
import 'package:airen/app/model/invoice_pam.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/catat_meter_bulan_view.dart';
import 'package:airen/app/modules/catat_meter/views/detail_catat_meter.dart';
import 'package:airen/app/modules/customer/controllers/customer_controller.dart';
import 'package:airen/app/modules/customer/providers/customer_provider.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../model/customer/customerModel.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../model/register_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../provider/catat_meter_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CatatMeterController extends GetxController {
  CatatMeterProvider? catatmeterProvider;

  CatatMeterController({required this.catatmeterProvider});
  CustomerController? CC;
  CustomerProviders? CP;
  final SessionController sessionController =
      Get.put(SessionController(sessionProvider: SessionProvider()));

  final count = 0.obs;
  final isLoadingCatatMeter = false.obs;
  final boxUser = GetStorage();
  final isLoadingMeterMonth = false.obs;
  final meterMonthResult = <MonthMeterResult>[].obs;
  final catatMeterresult = <CatatMeterResult>[].obs;
  final cusUserResult = <CustomerModel>[].obs;
  RxInt isRadio = 1.obs;
  final idManageCatatBulan = 0.obs;
  final judul = ''.obs;
  final bulan = 0.obs;
  final searchController = TextEditingController();
  final isSearch = false.obs;
  final searchValue = ''.obs;
  String scannedQrCode = '';
  final now = new DateTime.now().obs;
  List<dynamic> listOne = List.empty(growable: true).obs;

  //Detail catat Meter
  final statusDetail = false.obs;
  final idManageDetailCatatBulan = ''.obs;
  final nameManageDetailCatatBulan = ''.obs;
  final uniqueIdManageDetailCatatBulan = ''.obs;
  final alamatManageDetailCatatBulan = ''.obs;
  final meterNowManageDetailCatatBulan = ''.obs;
  final meterLastManageDetailCatatBulan = ''.obs;
  final addressManageDetailCatatBulan = ''.obs;
  final phoneNumberManageDetailCatatBulan = ''.obs;
  final meterNowController = TextEditingController();
  final updateMeterController = TextEditingController();
  final volume = ''.obs;
  final statusPenerbitanInvoice = false.obs;
  final statusTagihan = false.obs;
  final idBulanLalu = 0.obs;
  RxDouble meterBulanLalu = 0.0.obs;
  final onchangeMeterNow = ''.obs;

  //manage bulan
  final month_Of = 0.obs;
  final year_Of = 0.obs;
  final deleteState = false.obs;

  //pengaturan printer
  int? id;
  int? idInvoice;
  RxInt? totalPrice = 0.obs;
  final dataTransactionAllModel = TransactionAllModel().obs;
  Rx<Pam> dataPam = Pam().obs;
  Rx<TransactionAllModel> tm = TransactionAllModel().obs;
  RxInt fee = 0.obs;
  RxInt charge = 0.obs;
  RxInt totalResult = 0.obs;
  RxList<CostDetail> result = <CostDetail>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await getMeterMonth();
    if (meterBulanLalu.value != 0) {
      await getBulanLalu();
    }
    result.refresh();
    cusUserResult.refresh();
    if (id != null && idInvoice != null) {
      await getPeymentIvoice();
      logger.d("getting Invoice");
    } else {
      logger.d("Gagall");
    }
  }

  @override
  void onReady() async {
    super.onReady();
    debounce(searchValue, (val) {
      return searchManage();
    }, time: 500.milliseconds);
    debounce(onchangeMeterNow, (val) {
      return onchangeMeterNow;
    }, time: 500.milliseconds);
  }

  @override
  void onClose() async {
    await getMeterMonth();
    if (isSearch.value == true) {
      await getCusUsers();
    }
  }

  void increment() {
    update();
  }

  Future<void> clearCondition() async {
    meterNowController.clear();
    onchangeMeterNow.value = '';
    meterBulanLalu.value = 0.0;
    totalPrice!.value = 0;
    fee.value = 0;
    charge.value = 0;
    totalResult.value = 0;
    result = <CostDetail>[].obs;
  }

  Future getMeterMonth() async {
    try {
      isLoadingMeterMonth.value = true;
      final res = await catatmeterProvider!
          .getMeterMonth(bearer: boxUser.read(tokenBearer));
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.e("Error,There is no data");
      } else {
        if (res.message == "Meter months retrieved successfully") {
          meterMonthResult.assignAll(res.data!.meterMonths!);
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
    final res = await catatmeterProvider!.addCatatMeterBulan(
      bearer: boxUser.read(tokenBearer),
      monthOf: month_Of.toInt(),
      yearOf: year_Of.toInt(),
    );
    logger.d(res!.message!);
    if (res.message! == 'Meter months successfully created' ||
        res.status == 'success') {
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
      final res = await catatmeterProvider!
          .getCatatMeter(bearer: boxUser.read(tokenBearer), bulan: bulan.value);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        logger.i('kosong');
        logger.i(idManageCatatBulan);
        logger.d(catatMeterresult);
      } else {
        catatMeterresult.assignAll(res.data!.meters!);
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
    final res = await catatmeterProvider!.getSearchCus(
        bearer: boxUser.read(tokenBearer), searchValue: searchValue.value);
    // logger.wtf(res!.data!.data!.toList());
    cusUserResult.assignAll(res!.data!.cusMs!);
  }

  Future getCusUsers() async {
    try {
      isLoadingCatatMeter.value = true;
      final res = await CP!.getCusUser(bearer: boxUser.read(tokenBearer));

      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        cusUserResult.assignAll(res.data!.cusMs!);
        logger.d(cusUserResult);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingCatatMeter.value = false;
    }
  }

  Future getBulanLalu() async {
    try {
      isLoadingCatatMeter.value = true;
      final res = await catatmeterProvider!.getBulanlalu(
          bearer: boxUser.read(tokenBearer), id: idBulanLalu.value);
      // logger.wtf(res!.data!.data!.toList());
      logger.d(res?.message);
      if (res == null) {
        //Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        meterBulanLalu.value = double.parse(res.data!.meter_start!);
        logger.d(meterBulanLalu);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingCatatMeter.value = false;
    }
  }

  Future deleteMeterBulan() async {
    final res = await catatmeterProvider!.deleteMeterBulan(
        bearer: boxUser.read(tokenBearer),
        id: idManageCatatBulan.value.toString());
    if (res!.message! == 'Meter month successfully deleted') {
      await getCatatMeter();
      snackBarNotificationSuccess(title: 'Berhasil dihapus');
      update();
    } else {
      snackBarNotificationFailed(title: 'Gagal dihapus');
      sessionController.authError();
    }
  }

  Future<void> scanQR() async {
    try {
      scannedQrCode = await FlutterBarcodeScanner.scanBarcode(
        '#FFCC00',
        'Back',
        false,
        ScanMode.QR,
      );
      // ignore: unrelated_type_equality_checks
      if (scannedQrCode != '-1') {
        snackBarNotificationSuccess(
            title:
                'Berhasil melakukan scan - id : $scannedQrCode di ke $bulan');
        //statusDetail.value = true;
        isSearch.value = true;
        uniqueIdManageDetailCatatBulan.value = scannedQrCode;
        searchController.text = scannedQrCode;
        searchValue.value = scannedQrCode;
        Get.to(CatatBulanView());
        logger.e(scannedQrCode);
        // Get.to(DetailCatatMeter());
      } else {
        snackBarNotificationFailed(title: 'Gagal melakukan scan');
      }
      // ignore: empty_catches
    } on PlatformException {}
  }

  Future addCatatMeter() async {
    final res = await catatmeterProvider!.addCatatMeter(
      bearer: boxUser.read(tokenBearer),
      consumer_unique_id: uniqueIdManageDetailCatatBulan.value,
      meter_now: meterNowController.text,
      bulan: bulan.value,
    );
    logger.i(res!.status);
    if (res.status == 'success') {
      await getCatatMeter();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      Get.back();
      await clearCondition();
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
  }

  Future updateCatatMeter({
    required String id,
    required String meter_now,
    required int month,
  }) async {
    final res = await catatmeterProvider!.updateCatatMeter(
      bearer: boxUser.read(tokenBearer),
      meter_now: meterNowController.text,
      id: idManageDetailCatatBulan.value,
      month: bulan.value,
    );
    logger.i(res!.status);
    if (res.message == 'Meter successfully updated') {
      await getCatatMeter();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil diubah');
    } else {
      Get.back();
      snackBarNotificationFailed(title: 'Gagal diubah');
    }
  }

  Future addTagihan() async {
    final res = await catatmeterProvider!.addTagihan(
      bearer: boxUser.read(tokenBearer),
      consumer_unique_id: uniqueIdManageDetailCatatBulan.value,
      meter_now: meterNowManageDetailCatatBulan.value,
      meter_last: meterLastManageDetailCatatBulan.value,
      consumer_full_address: addressManageDetailCatatBulan.value,
      consumer_phone_number: phoneNumberManageDetailCatatBulan.value,
      consumer_name: nameManageDetailCatatBulan.value,
      bulan: bulan.value,
    );
    logger.i(res!.status);
    if (res.status == 'success') {
      await getCatatMeter();
      await getPeymentIvoice();
      await clearCondition();
      snackBarNotificationSuccess(title: 'Tagihan berhasil diterbitkan');
    } else {
      await clearCondition();
      snackBarNotificationFailed(title: 'Tagihan gagal diterbitkan');
    }
  }

  final isloading = false.obs;
  Future getPeymentIvoice() async {
    try {
      isloading.value = true;
      final res = await catatmeterProvider?.getPeymentMonthInvoice(
          bearer: boxUser.read(tokenBearer), id: id, idInvoice: idInvoice);
      if (res == null) {
        //Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        tm.value = res.data!.tm!;
        logger.d(tm);
        dataPam.value = res.data!.pam!;
        logger.d(dataPam);
        result.assignAll(res.data!.cusMs!);
        logger.d(result);
        fee.value = res.data!.pam!.adminFee!;
        logger.d(fee);
        charge.value = res.data!.pam!.charge!;
        logger.d(charge);
        result.value.forEach((element) {
          totalPrice = totalPrice! + int.parse(element.total!);
        });
        totalResult.value = fee.value + totalPrice!.value + charge.value;
        logger.d(totalResult);
        // result.assignAll(res.data!.cusMs!);
        update();
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isloading.value = false;
    }
  }
}