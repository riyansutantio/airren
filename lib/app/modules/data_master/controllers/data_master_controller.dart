import 'package:airen/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/pam_user/pam_user_model.dart';
import '../../../utils/constant.dart';
import '../providers/master_data_provider.dart';

class DataMasterController extends GetxController {
  MasterDataProvider masterDataProvider;

  DataMasterController({required this.masterDataProvider});

  final count = 0.obs;
  final masterData = 0.obs;

  final nameController = TextEditingController();
  final phoneNumberPamController = TextEditingController();
  final emailPamController = TextEditingController();

  final checkBoxPembayaran = false.obs;
  final checkBoxCatatMeter = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getPamUser();
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
          if (checkBoxCatatMeter.value == true) "Catat meter PAM",
        ]);
    logger.i(emailPamController.text);
    if (res!.message! == null) {
      logger.i(res.message!);
    }
  }
}
