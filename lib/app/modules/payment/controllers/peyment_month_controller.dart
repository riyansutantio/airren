import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/meter_transactionAll_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../providers/payment_providers.dart';

class PaymentMonthController extends GetxController {
  PaymentMonthController({required this.p, required this.id});
  PaymentProviders? p;
  int? id;
  final isloading = false.obs;
  final boxUser = GetStorage();
  final result = <TransactionAllModel>[].obs;
  final searchValue = ''.obs;
  final isSearch = false.obs;

  final searchController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPeymentMonths();
  }
  @override
  void onReady() {
    super.onReady();
    debounce(searchValue, (String? val) {
      print(val!.length);
      if ((result.value.isEmpty)) {
        isloading.value = true;
      } else {
        isloading.value = false;
      }
      return searchManage();
    }, time: 500.milliseconds);
  }
  Future getPeymentMonths() async {
    try {
      isloading.value = true;
      final res =
          await p!.getPeymentMonth(bearer: boxUser.read(tokenBearer), id: id);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        result.assignAll(res.data!.cusMs!);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isloading.value = false;
    }
  }
  Future searchManage() async {
    final res = await p!.getSearchMeter(
        bearer: boxUser.read(tokenBearer), searchValue: searchValue.value,id: id);
    // logger.wtf(res!.data!.data!.toList());

    result.assignAll(res!.data!.cusMs!);
  }
}
