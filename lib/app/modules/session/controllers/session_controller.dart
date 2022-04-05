import 'dart:async';
import 'package:airen/app/model/district_model.dart';
import 'package:airen/app/model/province_model.dart';
import 'package:airen/app/model/regency_model.dart';
import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/modules/session/views/register_view.dart';
import 'package:airen/app/routes/app_pages.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant.dart';

class SessionController extends GetxController {
  SessionProvider sessionProvider;

  SessionController({required this.sessionProvider});

  final namePamController = TextEditingController();
  final nameAdminPamController = TextEditingController();
  final emailPamController = TextEditingController();
  final uidPamController = TextEditingController();
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

  final resultError = <Errors>[].obs;

  Future register() async {
    try {
      isLoadingRegister.value = true;
      final res = await sessionProvider.register(
          pamName: namePamController.text,
          pamDetailAddress: addressDetailController.text,
          pamDistrictId: selectedDistrict.value,
          pamProvinceId: selectedProvince.value,
          pamRegencyId: selectedRegency.value,
          pamUserEmail: emailPamController.text,
          pamUserName: nameAdminPamController.text,
          pamUserPhoneNumber: phoneNumberController.text);
      if (res!.status == null) {
        Get.snackbar(res.errors!.pamUserEmail![0], 'invalid value', backgroundColor: Colors.white);
      } else {
        boxPrice.write(priceInit, res.data?.trialPrice);
        Get.snackbar('${res.message}', 'trial price ${idrFormatter(value: res.data?.trialPrice)}', backgroundColor: Colors.white);
        Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.to(PaymentView()));
      }
    } catch (e) {
      logger.i(e);
    } finally {
      googleSignOut();
    }
  }

  int getTrialPrice() => boxPrice.read(priceInit);

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

  /// Login With Google
  final boxUser = GetStorage();

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? currentUser;

  Future<void> newDataCreate() async {
    boxUser.write(tokenBearer, null);
    boxUser.write(emailGoogle, null);
    boxUser.write(uidGoogle, null);
    await googleSignOut();
    Get.offAllNamed(Routes.SESSION);
  }

  Future<void> googleSignOut() async {
    await googleSignIn.signOut();
  }

  Future<void> googleDisconnect() async {
    await googleSignIn.disconnect();
  }

  Future<void> signInWithGoogle() async {
    try {
      final user = await googleSignIn.signIn();
      currentUser = user;
      boxUser.write(emailGoogle, currentUser?.email);
      boxUser.write(uidGoogle, currentUser?.id);
      nameAdminPamController.text = currentUser!.displayName!;
      logger.i('ini user ${currentUser?.email}, ini ID user ${currentUser?.id}');
    } catch (e) {
      logger.e(e);
    } finally {
      emailPamController.text = currentUser!.email;
      uidPamController.text = currentUser!.id;
      // if (currentUser != null) Get.to(RegisterView());
      login();
    }
  }

  Future login() async {
    final res = await sessionProvider.login(email: currentUser!.email, id: currentUser!.id);
    logger.i(res!.message!);
    if (res.message == "Please register first") {
      Get.to(RegisterView());
    } else if (res.message == "Please pay first") {
      Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.to(PaymentView()));
    } else {
      boxUser.write(tokenBearer, res.data?.token);
      logger.i(boxUser.read(tokenBearer));
      Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.offAllNamed(Routes.HOME));
    }
  }

  Future logOut() async {
    final res = await sessionProvider.logOut(
        email: boxUser.read(emailGoogle), id: boxUser.read(uidGoogle), bearer: boxUser.read(tokenBearer));
    logger.i(res!.message!);
    if (res.status == "success") {
      boxUser.write(tokenBearer, null);
      boxUser.write(emailGoogle, null);
      boxUser.write(uidGoogle, null);
      googleSignOut();
      Get.offAllNamed(Routes.SESSION);
    } else {
      Get.snackbar('${res.message}', 'failed logOut');
    }
  }

  /// Login With Google
  void readGoogleUser() {
    logger.i("ini email google ${boxUser.read(emailGoogle)}");
    logger.i("ini uid google ${boxUser.read(uidGoogle)}");
  }

  void sendWhatsAppConfirm({String? phone, String? nomerOrder, String? bill, String? time}) async {
    var url =
        """https://api.whatsapp.com/send?phone=$phone&text=Kami%20telah%20melakukan%20pendaftaran%20aplikasi%20Airren%20sekaligus%20melakukan%20pembayaran%20via%20bank%20dengan%20keterangan%20sbb%20:%0ANomor%20Order%20:%20$nomerOrder%0ADari%20Bank%20:%0AKe%20Bank%20:%0AJumlah%20:%20$bill%0ATanggal%20:%20$time%0AMohon%20diperiksa%20dan%20diaktifkan%20akun%20kami%20Terimakasih""";
    await launch(url);
  }
}
