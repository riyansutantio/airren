import 'package:airen/app/model/base_fee/base_fee_model.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/pam_user/pam_user_model.dart';
import '../../../utils/constant.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../providers/master_data_provider.dart';

class DataMasterController extends GetxController {
  MasterDataProvider masterDataProvider;

  DataMasterController({required this.masterDataProvider});

  final SessionController sessionController =
      Get.put(SessionController(sessionProvider: SessionProvider()));

  final count = 0.obs;
  final searchValue = ''.obs;
  final masterData = 0.obs;
  final isSearch = false.obs;

  final searchController = TextEditingController();

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
    debounce(searchValue, (val) {
      if (masterData.value == 0) {
        return searchManage();
      } else {
        return searchBaseFee();
      }
    }, time: 500.milliseconds);
  }

  @override
  void onClose() async {
    await getPamUser();
  }

  void increment() => count.value++;

  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((e) => e[0]).take(2).join()
      : '';

  void toPengelola() {
    masterData.value = 0;
    logger.i(masterData.value);
  }

  void toBaseFee() {
    masterData.value = 1;
    logger.i(masterData.value);
  }

  Future<void> closeSearchAppBar() async {
    isSearch.value = false;
    searchValue.value = '';
  }

  final boxUser = GetStorage();

  final isLoadingPamUser = false.obs;

  final pamUserResult = <PamsUserResult>[].obs;

  final pamRoleResult = <RolePam>[].obs;

  final rolesUser = <String>[].obs;

  void checkRole(List<RolePam>? role) {
    for (var i = 0; i < role!.length; i++) {
      if (role[i].name == "Bendahara PAM") {
        checkBoxPembayaran.value = true;
      } else if (role[i].name == "Catat Meter PAM") {
        checkBoxCatatMeter.value = true;
      }
    }
  }

  Future getPamUser() async {
    try {
      isLoadingPamUser.value = true;
      final res = await masterDataProvider.getPamUser(
          bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
      } else if (res.message == "Pam user successfully retrived") {
        pamUserResult.assignAll(res.data!.pamsUsers!);
      }
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
        roles: rolesUser);
    logger.i(emailPamController.text);
    if (res!.status! == 'success') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
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
        roles: rolesUser);
    if (res!.status! == 'success') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil diubah');
    } else {
      snackBarNotificationFailed(title: 'Gagal diubah');
    }
  }

  Future deleteManagePam() async {
    final res = await masterDataProvider.deletePamManage(
        id: idManagePamController.text, bearer: boxUser.read(tokenBearer));
    if (res!.message! == 'Pam user successfully deleted') {
      await getPamUser();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil dihapus');
    } else {
      snackBarNotificationFailed(title: 'Gagal dihapus');
      sessionController.authError();
    }
  }

  ///Base Fee

  final isLoadingBaseFee = false.obs;

  final baseFeeResult = <BaseFeeResult>[].obs;

  Future getBaseFee() async {
    isLoadingBaseFee.value = true;
    final res =
        await masterDataProvider.getBaseFee(bearer: boxUser.read(tokenBearer));
    // logger.wtf(res!.data!.data!.toList());
    if (res == null) {
      Get.to(UnauthenticationView());
    } else if (res.message == "Base fees successfully retrieved") {
      baseFeeResult.assignAll(res.data!.baseFees!);
    }
  }

  Future searchBaseFee() async {
    try {
      isLoadingBaseFee.value = true;
      final res = await masterDataProvider.getSearchBaseFee(
          bearer: boxUser.read(tokenBearer), searchValue: searchValue.value);
      // logger.wtf(res!.data!.data!.toList());
      baseFeeResult.assignAll(res!.data!.baseFees!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingBaseFee.value = false;
    }
  }

  Future searchManage() async {
    isLoadingPamUser.value = true;
    final res = await masterDataProvider.getSearchManage(
        bearer: boxUser.read(tokenBearer), searchValue: searchValue.value);
    // logger.wtf(res!.data!.data!.toList());
    pamUserResult.assignAll(res!.data!.pamsUsers!);
  }

  Future addBaseFee() async {
    final res = await masterDataProvider.addBaseFee(
        bearer: boxUser.read(tokenBearer),
        amount: amountController.text.numericOnly(),
        meterPosition: meterPositionController.text);
    if (res!.message! == 'Base fee successfully created') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      Get.back();
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
  }

  Future updateBaseFee() async {
    final res = await masterDataProvider.updateBaseFee(
        id: idBaseFeeController.text,
        bearer: boxUser.read(tokenBearer),
        amount: amountDetailController.text.numericOnly(),
        meterPosition: meterDetailPositionController.text);
    if (res!.status! == 'success') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil diubah');
    } else {
      snackBarNotificationSuccess(title: 'Gagal diubah');
    }
  }

  Future deleteBaseFee() async {
    final res = await masterDataProvider.deleteBaseFee(
        id: idBaseFeeController.text, bearer: boxUser.read(tokenBearer));
    if (res!.status! == 'success') {
      await getBaseFee();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil dihapus');
    } else {
      snackBarNotificationFailed(title: 'Gagal dihapus');
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
  var radioValueActivatedActiveDp = false.obs;

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
