import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../model/pam_transaction.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../provider/transaction_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  TransactionController({required this.p});
  TransactionProvider? p;
  final boxUser = GetStorage();
  final count = 0.obs;
  final isLoadingPamTrans = false.obs;
  RxInt? total_balance = 0.obs;
  RxInt? firstBlance = 0.obs;
  final isShowTransaksi = false.obs;
  final pamTransResult = <PamTransactionsModel>[].obs;
  final nameController = TextEditingController();
  final nominalController = TextEditingController();
  final deskriptionController = TextEditingController();
  final nameDetailController = TextEditingController();
  final nominalDetailController = TextEditingController();
  final nominalFirstBlanceController = TextEditingController();
  final deskriptionDetailController = TextEditingController();

  final nameExpenseController = TextEditingController();
  final nominalExpenseController = TextEditingController();
  final deskriptionExpenseController = TextEditingController();

  String formatNumber(String s) =>
      NumberFormat.decimalPattern('id').format(int.parse(s));
  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'id').currencySymbol;

  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPref();
    await getPamTransactions();
  }

  Future addIncomes() async {
    final res = await p!.addIncomeTrans(
      bearer: boxUser.read(tokenBearer),
      amount: int.parse(nominalController.text.replaceAll('.', '')),
      name: nameController.text,
      description: deskriptionController.text,
    );
    logger.i(nameController.text);
    if (res!.status! == 'success') {
      await getPamTransactions();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
    nominalController.clear();
    nameController.clear();
    deskriptionController.clear();
  }

  Future addExpensesTran() async {
    final res = await p!.addExpenseTrans(
      bearer: boxUser.read(tokenBearer),
      amount: int.parse(nominalExpenseController.text.replaceAll('.', '')),
      name: nameExpenseController.text,
      description: deskriptionExpenseController.text,
    );
    logger.i(nameController.text);
    if (res!.status! == 'success') {
      await getPamTransactions();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
    nominalExpenseController.clear();
    nameExpenseController.clear();
    deskriptionExpenseController.clear();
  }

  Future<void> getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    firstBlance!.value = preferences.getInt('firstBlance') ?? 0;
  }

  Future addFirstBlances() async {
    final res = await p!.addFirstBlance(
      bearer: boxUser.read(tokenBearer),
      amount: int.parse(nominalFirstBlanceController.text.replaceAll('.', '')),
    );
    if (res!.status! == 'success') {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setInt('firstBlance', 1);
      preferences.commit();
      firstBlance!.value = 1;
      await getPamTransactions();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
    nominalFirstBlanceController.clear();
  }

  Future<void> clearCondition() async {
    nameController.clear();
    nominalController.clear();
    deskriptionController.clear();
  }

  Future getPamTransactions() async {
    try {
      isLoadingPamTrans.value = true;
      final res = await p!.getPamTransaction(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        total_balance!.value = res.data!.totalBalance!;

        pamTransResult.assignAll(res.data!.transModel!);
        logger.i(total_balance);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingPamTrans.value = false;
    }
  }
}
