import 'package:airen/app/model/term_about_help_model.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/account_settings/user_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';

class AccountController extends GetxController {
  AccountProvider accountProvider;

  AccountController({required this.accountProvider});

  final isLoadingAboutUs = false.obs;
  final isLoadingUser = false.obs;
  final isLoadingTermCondition = false.obs;
  final isLoadingPrivacy = false.obs;

  final meterPositionController = TextEditingController();
  final amountController = TextEditingController();
  final dueDateController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();

  final namePamController = TextEditingController();
  final provinceController = TextEditingController();
  final regencyController = TextEditingController();
  final districtController = TextEditingController();
  final addressDetailController = TextEditingController();

  final selectedRegency = ''.obs;
  final selectedProvince = ''.obs;
  final selectedDistrict = ''.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  final boxUser = GetStorage();

  final resultAboutUs = ResultTermAboutHelp().obs;
  final resultTermCondition = ResultTermAboutHelp().obs;
  final resultPrivacy = ResultTermAboutHelp().obs;
  final resultUser = ResultProfile().obs;

  Future getUser() async {
    try {
      isLoadingUser.value = true;
      final res = await accountProvider.getUser(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      resultUser.value = res!.data!.profile!;
      emailController.text = res.data!.profile!.email!;
      nameController.text = res.data!.profile!.name!;
      phoneNumberController.text = res.data!.profile!.phoneNumber!;
      addressDetailController.text = res.data!.profile!.pam!.detailAddress!;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingUser.value = false;
    }
  }

  Future getAboutUs() async {
    try {
      isLoadingAboutUs.value = true;
      final res = await accountProvider.getTermAboutUsHelp(path: 'about-us', bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      resultAboutUs.value = res!.data!;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingAboutUs.value = false;
    }
  }

  Future getTermCondition() async {
    try {
      isLoadingAboutUs.value = true;
      final res = await accountProvider.getTermAboutUsHelp(path: 'term-condition', bearer: boxUser.read(tokenBearer));
      logger.wtf(boxUser.read(tokenBearer));
      resultTermCondition.value = res!.data!;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingAboutUs.value = false;
    }
  }

  Future getPrivacy() async {
    try {
      isLoadingAboutUs.value = true;
      final res = await accountProvider.getTermAboutUsHelp(path: 'privacy-policy', bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      resultPrivacy.value = res!.data!;
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingAboutUs.value = false;
    }
  }

  Future addMinUsage() async {
    final res = await accountProvider.minUsage(bearer: boxUser.read(tokenBearer), meterPosition: meterPositionController.text);
    if (res!.status! == 'success') {
      Get.back();
      clearCondition();
      snackBarNotification(
          title: 'Minimal Penggunaan',
          messageText: 'berhasil ditambahkan',
          titleText: 'Minimal Penggunaan',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      Get.back();
      snackBarNotification(
          title: 'Minimal Penggunaan',
          messageText: 'gagal ditambahkan',
          titleText: 'Minimal Penggunaan',
          subTitle: 'gagal ditambahkan',
          color: Colors.red);
    }
  }

  Future addCharge() async {
    final res = await accountProvider.addCharge(
        bearer: boxUser.read(tokenBearer), charge: amountController.text, dueDate: dueDateController.text);
    if (res!.status! == 'success') {
      Get.back();
      clearCondition();
      snackBarNotification(
          title: 'Denda',
          messageText: 'berhasil ditambahkan',
          titleText: 'Denda',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      Get.back();
      snackBarNotification(
          title: 'Denda', messageText: 'gagal ditambahkan', titleText: 'Denda', subTitle: 'gagal ditambahkan', color: Colors.red);
    }
  }

  Future updateProfile() async {
    final res = await accountProvider.updatePamUserProfile(
        bearer: boxUser.read(tokenBearer), phoneNumber: phoneNumberController.text, name: nameController.text);
    if (res!.status! == 'success') {
      Get.back();
      clearCondition();
      snackBarNotification(
          title: 'Update Profile',
          messageText: 'berhasil ditambahkan',
          titleText: 'Update Profile',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      Get.back();
      snackBarNotification(
          title: 'Update Profile', messageText: 'gagal ditambahkan', titleText: 'Update Profile', subTitle: 'gagal ditambahkan', color: Colors.red);
    }
  }

  Future updatePamProfile() async {
    final res = await accountProvider.updatePamProfile(
        bearer: boxUser.read(tokenBearer),
        name: namePamController.text,
        pamRegencyId: selectedRegency.value,
        pamProvinceId: selectedProvince.value,
        pamDistrictId: selectedDistrict.value,
        detailAddress: addressDetailController.text);
    if (res!.status! == 'success') {
      Get.back();
      clearCondition();
      snackBarNotification(
          title: 'PAM Profile',
          messageText: 'berhasil ditambahkan',
          titleText: 'PAM Profile',
          subTitle: 'berhasil ditambahkan',
          color: Colors.green);
    } else {
      Get.back();
      snackBarNotification(
          title: 'PAM Profile', messageText: 'gagal ditambahkan', titleText: 'PAM Profile', subTitle: 'gagal ditambahkan', color: Colors.red);
    }
  }

  void clearCondition() {
    meterPositionController.clear();
  }
}
