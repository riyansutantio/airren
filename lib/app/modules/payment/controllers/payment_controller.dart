import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:io';
import '../../../model/meter_transaction_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../providers/payment_providers.dart';

class PaymentController extends GetxController {
  PaymentController({required this.p});
  PaymentProviders? p;
  final isloading = false.obs;
  
  final searchValue = ''.obs;
  final isSearch = false.obs;
  final paymentData = 0.obs;
  final now = new DateTime.now().obs;
  final boxUser = GetStorage();
  final result = <TransactionModel>[].obs;
  RxString? status = 'unpaid'.obs;
  final searchController = TextEditingController();
   @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPeyments();
  }
  Future getPeyments() async {
    try {
      isloading.value = true;
      final res = await p!.getPayment(bearer: boxUser.read(tokenBearer),status: status!.value);
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
}
