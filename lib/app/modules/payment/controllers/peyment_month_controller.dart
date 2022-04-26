import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPeymentMonths();
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
}
