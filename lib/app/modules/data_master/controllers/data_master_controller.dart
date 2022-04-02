import 'package:airen/app/model/base_fee/base_fee_model.dart';
import 'package:airen/app/routes/app_pages.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/pam_user/pam_user_model.dart';
import '../../../utils/constant.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../providers/master_data_provider.dart';

class DataMasterController extends GetxController {
  MasterDataProvider masterDataProvider;

  DataMasterController({required this.masterDataProvider});

  final count = 0.obs;
  final masterData = 0.obs;

  ///Manage User
  final nameController = TextEditingController();
  final phoneNumberPamController = TextEditingController();
  final emailPamController = TextEditingController();

  final idManagePamController = TextEditingController();
  final nameDetailController = TextEditingController();
  final phoneNumberDetailPamController = TextEditingController();
  final emailPamDetailController = TextEditingController();

  final checkBoxPembayaran = false.obs;
  final checkBoxCatatMeter = false.obs;

  ///Base Fee
  final idBaseFeeController = TextEditingController();
  final amountController = TextEditingController();
  final meterPositionController = TextEditingController();

  final amountDetailController = TextEditingController();
  final meterDetailPositionController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    await getPamUser();
    await getBaseFee();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void toPengelola() {
    masterData.value = 0;
    logger.i(masterData.value);
  }

  void toTarifDasar() {
    masterData.value = 1;
    logger.i(masterData.value);
  }

  final boxUser = GetStorage();

  final isLoadingPamUser = false.obs;

  final pamUserResult = <PamsUserResult>[].obs;

  final pamRoleResult = <RolePam>[].obs;

  void checkRole(List<RolePam>? role){
    for(var i = 0; i < role!.length; i++){
      if (role[i].name == "Bendahara PAM"){
        checkBoxPembayaran.value = true;
      } else if (role[i].name == "Catat Meter PAM"){
        checkBoxCatatMeter.value = true;
      }
    }
  }

  Future getPamUser() async {
    try {
      isLoadingPamUser.value = true;
      final res = await masterDataProvider.getPamUser(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      pamUserResult.assignAll(res!.data!.pamsUsers!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingPamUser.value = false;
    }
  }

  Future addManagePam() async {
    final res = await masterDataProvider.addPamManage(
        bearer: boxUser.read(tokenBearer),
        email: emailPamController.text,
        name: nameController.text,
        phoneNumber: phoneNumberPamController.text,
        roles: [
          if (checkBoxPembayaran.value == true) "Bendahara PAM",
          if (checkBoxCatatMeter.value == true) "Catat Meter PAM",
        ]);
    logger.i(emailPamController.text);
    if (res!.status! == 'success') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Pengelola',
          messageText: 'berhasil ditambahkan',
          titleText: 'Pengelola',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      snackBarNotification(
          title: 'Pengelola',
          messageText: 'gagal ditambahkan',
          titleText: 'Pengelola',
          subTitle: 'gagal ditambahkan',
          color: Colors.red);
    }
  }

  Future updateManagePam() async {
    final res = await masterDataProvider.updatePamManage(
        id: idManagePamController.text,
        blocked: radioValueActivated.value,
        bearer: boxUser.read(tokenBearer),
        email: emailPamDetailController.text,
        name: nameDetailController.text,
        phoneNumber: phoneNumberDetailPamController.text,
        roles: [
          if (checkBoxPembayaran.value == true) "Bendahara PAM",
          if (checkBoxCatatMeter.value == true) "Catat Meter PAM",
        ]);
    if (res!.status! == 'success') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Pengelola',
          messageText: 'berhasil diupdate',
          titleText: 'Pengelola',
          subTitle: 'berhasil diupdate',
          color: Colors.green);
    } else {
      snackBarNotification(
          title: 'Pengelola',
          messageText: 'gagal diupdate',
          titleText: 'Pengelola',
          subTitle: 'gagal diupdate',
          color: Colors.red);
    }
  }

  Future deleteManagePam() async {
    final res = await masterDataProvider.deletePamManage(id: idManagePamController.text, bearer: boxUser.read(tokenBearer));
    if (res!.status! == 'success') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Pengelola',
          messageText: 'berhasil dihapus',
          titleText: 'Pengelola',
          subTitle: 'berhasil dihapus',
          color: Colors.green);
    } else {
      snackBarNotification(
          title: 'Pengelola', messageText: 'gagal dihapus', titleText: 'Pengelola', subTitle: 'gagal dihapus', color: Colors.red);
    }
  }

  ///Base Fee

  final isLoadingBaseFee = false.obs;

  final baseFeeResult = <BaseFeeResult>[].obs;

  Future getBaseFee() async {
    try {
      isLoadingBaseFee.value = true;
      final res = await masterDataProvider.getBaseFee(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      baseFeeResult.assignAll(res!.data!.baseFees!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingBaseFee.value = false;
    }
  }

  Future addBaseFee() async {
    final res = await masterDataProvider.addBaseFee(
        bearer: boxUser.read(tokenBearer), amount: amountController.text, meterPosition: meterPositionController.text);
    if (res!.message! == 'Base fee successfully created') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Tarif dasar',
          messageText: 'berhasil ditambahkan',
          titleText: 'Tarif dasar',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      Get.back();
      snackBarNotification(
          title: 'Tarif dasar',
          messageText: 'gagal ditambahkan',
          titleText: 'Tarif dasar',
          subTitle: 'gagal ditambahkan',
          color: Colors.red);
    }
  }

  Future updateBaseFee() async {
    final res = await masterDataProvider.updateBaseFee(
        id: idBaseFeeController.text,
        bearer: boxUser.read(tokenBearer),
        amount: amountDetailController.text,
        meterPosition: meterDetailPositionController.text);
    if (res!.status! == 'success') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Tarif dasar',
          messageText: 'berhasil diubah',
          titleText: 'Tarif dasar',
          subTitle: 'berhasil diubah',
          color: Colors.green);
    } else {
      snackBarNotification(
          title: 'Tarif dasar',
          messageText: 'gagal diubah',
          titleText: 'Tarif dasar',
          subTitle: 'gagal diubah',
          color: Colors.red);
    }
  }

  Future deleteBaseFee() async {
    final res = await masterDataProvider.deleteBaseFee(id: idBaseFeeController.text, bearer: boxUser.read(tokenBearer));
    if (res!.status! == 'success') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotification(
          title: 'Tarif dasar',
          messageText: 'berhasil dihapus',
          titleText: 'Tarif dasar',
          subTitle: 'berhasil dihapus',
          color: Colors.green);
    } else {
      snackBarNotification(
          title: 'Tarif dasar', messageText: 'gagal dihapus', titleText: 'Tarif dasar', subTitle: 'gagal dihapus', color: Colors.red);
    }
  }

  Future<void> clearCondition() async {
    nameController.clear();
    emailPamController.clear();
    phoneNumberPamController.clear();
    amountController.clear();
    meterPositionController.clear();
    checkBoxPembayaran.value = false;
    checkBoxCatatMeter.value = false;
  }

  var radioValueActivated = 0.obs;

  void handleRadioValueChangeActivated(var value) {
    radioValueActivated.value = value;
    switch (radioValueActivated.value) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
