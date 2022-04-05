import 'package:airen/app/model/term_about_help_model.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/modules/session/controllers/session_controller.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/routes/app_pages.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../model/account_settings/user_model.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';

class AccountController extends GetxController {
  AccountProvider accountProvider;

  AccountController({required this.accountProvider});

  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));

  final isLoadingAboutUs = false.obs;
  final isLoadingUser = false.obs;
  final isLoadingTermCondition = false.obs;
  final isLoadingPrivacy = false.obs;

  final meterPositionController = TextEditingController();
  final amountChargeController = TextEditingController();
  final dueDateController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final registerDateController = TextEditingController();

  final namePamController = TextEditingController();
  final provinceController = TextEditingController();
  final regencyController = TextEditingController();
  final districtController = TextEditingController();
  final addressDetailController = TextEditingController();

  final selectedRegency = ''.obs;
  final selectedProvince = ''.obs;
  final selectedDistrict = ''.obs;

  final displayName = ''.obs;
  final displayRegisterCreated = ''.obs;

  String displayRegisterToDateTime(){
    return DateFormat('d MMMM yyyy').format(DateTime.parse(displayRegisterCreated.value));
  }

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
      displayName.value = res.data!.profile!.name!;
      displayRegisterCreated.value = res.data!.profile!.createdAt!.toString();
      phoneNumberController.text = res.data!.profile!.phoneNumber!;
      addressDetailController.text = res.data!.profile!.pam!.detailAddress!;
      namePamController.text = res.data!.profile!.pam!.name!;
      amountChargeController.text = res.data!.profile!.pam!.charge.toString();
      dueDateController.text = res.data!.profile!.pam!.chargeDueDate.toString();
      meterPositionController.text = res.data!.profile!.pam!.minUsage.toString();
    } catch (e) {
      logger.e(e);
      sessionController.newDataCreate();
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
        bearer: boxUser.read(tokenBearer), charge: amountChargeController.text.numericOnly(), dueDate: dueDateController.text);
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
          title: 'Update Profile',
          messageText: 'gagal ditambahkan',
          titleText: 'Update Profile',
          subTitle: 'gagal ditambahkan',
          color: Colors.red);
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
          title: 'PAM Profile',
          messageText: 'gagal ditambahkan',
          titleText: 'PAM Profile',
          subTitle: 'gagal ditambahkan',
          color: Colors.red);
    }
  }

  var selectedImagePath = ''.obs;
  var imageInit = ''.obs;
  var selectedImageSize = ''.obs;
  var selectedNameImage = ''.obs;

  Future getFileFromDevice() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path.toString());
      PlatformFile fileName = result.files.last;
      logger.i(fileName.name);
      selectedImagePath.value = result.files.single.path.toString();
      selectedNameImage.value = fileName.name;
      logger.wtf(selectedImagePath.value);
      await accountProvider.pushProfilePhoto(photoPath: selectedImagePath.value, bearer: boxUser.read(tokenBearer));
      await getUser();
    } else {
      Get.snackbar('file not found', 'choose your photo');
    }
  }

  void clearCondition() {
    meterPositionController.clear();
  }
}
