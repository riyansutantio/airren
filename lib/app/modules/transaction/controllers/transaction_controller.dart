import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../model/pam_transaction.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../provider/transaction_provider.dart';

class TransactionController extends GetxController {
  TransactionController({required this.p});
  TransactionProvider? p;
  final boxUser = GetStorage();
  final count = 0.obs;
  final isLoadingPamTrans = false.obs;
  RxInt? total_balance = 0.obs;
  final isShowTransaksi = false.obs;
  final pamTransResult = <PamTransactionsModel>[].obs;
  final nameController = TextEditingController();
  final nominalController = TextEditingController();
  final deskriptionController = TextEditingController();
   final nameDetailController = TextEditingController();
  final nominalDetailController = TextEditingController();
  final deskriptionDetailController = TextEditingController();


  final nameExpenseController = TextEditingController();
  final nominalExpenseController = TextEditingController();
  final deskriptionExpenseController = TextEditingController();
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPamTransactions();
  }

  Future addIncomes() async {
    final res = await p!.addIncomeTrans(
      bearer: boxUser.read(tokenBearer),
      amount: int.parse(nominalController.text),
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
  }
  Future addExpensesTran() async {
    final res = await p!.addExpenseTrans(
      bearer: boxUser.read(tokenBearer),
      amount: int.parse(nominalExpenseController.text),
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
