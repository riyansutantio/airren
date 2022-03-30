import 'dart:async';

import 'package:airen/app/model/district_model.dart';
import 'package:airen/app/model/province_model.dart';
import 'package:airen/app/model/regency_model.dart';
import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/modules/session/views/register_view.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_count_down/otp_count_down.dart';

import '../../../utils/constant.dart';

class SessionController extends GetxController {
  SessionProvider sessionProvider;

  SessionController({required this.sessionProvider});

  final nameController = TextEditingController();
  final nameAdminPamController = TextEditingController();
  final emailPamController = TextEditingController();
  final provinceController = TextEditingController();
  final regencyController = TextEditingController();
  final districtController = TextEditingController();
  final addressDetailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final count = 0.obs;

  var countDownOtp = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getProvince();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  /// Result Province
  final selectedProvince = ''.obs;
  final resultProvince = <Province>[].obs;

  final isLoadingProvince = false.obs;

  Future getProvince() async {
    try {
      isLoadingProvince.value = true;
      final res = await sessionProvider.getProvince();
      // logger.wtf(res!.data!.data!.toList());
      resultProvince.assignAll(res!.data!.provinces!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingProvince.value = false;
    }
  }

  /// Result Province

  /// Result Regency
  final selectedRegency = ''.obs;

  final resultRegency = <Regency>[].obs;

  final isLoadingRegency = false.obs;

  Future getRegency({String? id}) async {
    try {
      isLoadingRegency.value = true;
      final res = await sessionProvider.getRegency(id: id);
      // logger.wtf(res!.data!.data!.toList());
      resultRegency.assignAll(res!.data!.regencies!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingRegency.value = false;
    }
  }

  /// Result Regency

  /// Result District
  final selectedDistrict = ''.obs;

  final resultDistrict = <District>[].obs;

  final isLoadingDistrict = false.obs;

  Future getDistrict({String? id}) async {
    try {
      isLoadingDistrict.value = true;
      final res = await sessionProvider.getDistrict(id: id);
      // logger.wtf(res!.data!.data!.toList());
      resultDistrict.assignAll(res!.data!.districts!);
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingDistrict.value = false;
    }
  }

  /// Result Regency

  /// Register
  final boxPrice = GetStorage();

  final isLoadingRegister = false.obs;

  final resultRegister = <RegisterModel>[].obs;

  Future register() async {
    try {
      isLoadingRegister.value = true;
      final res = await sessionProvider.register(
          pamName: nameAdminPamController.text,
          pamDetailAddress: addressDetailController.text,
          pamDistrictId: selectedDistrict.value,
          pamProvinceId: selectedProvince.value,
          pamRegencyId: selectedRegency.value,
          pamUserEmail: emailPamController.text,
          pamUserName: nameController.text,
          pamUserPhoneNumber: phoneNumberController.text);
      logger.i('status ${res!.errors!.pamUserEmail![0]}');
      if (res.status == null) {
        Get.snackbar(res.errors!.pamUserEmail![0], 'invalid value', backgroundColor: Colors.white);
      } else {
        boxPrice.write(priceInit, res.data?.trialPrice);
        Get.snackbar('${res.message}', 'bisaaa!', backgroundColor: Colors.white);
        Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.to(PaymentView()));
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingRegister.value = false;
    }
  }

  Future<String> getTrialPrice() => boxPrice.read(priceInit);

  /// Register

  void startCountDown() {
    OTPCountDown.startOTPTimer(
      timeInMS: 1000 * 5 * 60,
      currentCountDown: (String countDown) {
        countDownOtp.value = countDown;
      },
      onFinish: () {
        print("Count down finished!");
      },
    );
  }

  final boxGoogleUser = GetStorage();

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? currentUser;

  void googleSignOut() async {
    await googleSignIn.disconnect();
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await googleSignIn.signIn();
      currentUser = user;
      boxGoogleUser.write(emailGoogle, currentUser?.email);
      boxGoogleUser.write(uidGoogle, currentUser?.id);
      logger.i('ini user ${currentUser?.email}, ini ID user ${currentUser?.id}');
    } catch (e) {
      print(e);
    } finally {
      emailPamController.text = currentUser!.email;
      if (currentUser != null) Get.to(RegisterView());
    }
  }

  void readGoogleUser() {
    logger.i("ini email google ${boxGoogleUser.read(emailGoogle)}");
    logger.i("ini uid google ${boxGoogleUser.read(uidGoogle)}");
  }
}
