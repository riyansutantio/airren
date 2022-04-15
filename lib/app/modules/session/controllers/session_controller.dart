import 'dart:async';
import 'package:airen/app/model/province_model.dart';
import 'package:airen/app/model/regency_model.dart';
import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/modules/error_handling/views/common_error_view.dart';
import 'package:airen/app/modules/error_handling/views/unauthentication_view.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/modules/session/views/register_view.dart';
import 'package:airen/app/routes/app_pages.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/district_model.dart';
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

  final RoundedLoadingButtonController btnControllerLoginGoogle = RoundedLoadingButtonController();
  final RoundedLoadingButtonController btnControllerRegister = RoundedLoadingButtonController();

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
  void onClose() {
    logger.w('close');
  }

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
    isLoadingRegency.value = true;
    final res = await sessionProvider.getRegency(id: id);
    // logger.wtf(res!.data!.data!.toList());
    resultRegency.assignAll(res!.data!.regencies!);
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
      // Get.snackbar(res.errors!.pamUserEmail![0], 'invalid value', backgroundColor: Colors.white);
      btnControllerRegister.stop();
    } else {
      boxPrice.write(phoneNumberVerification, res.data?.phoneNumber);
      boxPrice.write(priceInit, res.data?.transaction!.price!);
      boxPrice.write(orderIdTrxCreated, res.data?.pam?.createdAt.toString());
      boxPrice.write(orderIdTrx, res.data?.pam?.id);
      // Get.snackbar('${res.message}', 'trial price ${idrFormatter(value: res.data?.trialPrice)}', backgroundColor: Colors.white);
      Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.to(PaymentView()));
      btnControllerRegister.stop();
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

  Future<void> authError() async {
    boxUser.write(tokenBearer, null);
    boxUser.write(emailGoogle, null);
    boxUser.write(uidGoogle, null);
    await googleSignOut();
    Get.to(UnauthenticationView());
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
      emailPamController.text = currentUser!.email;
      uidPamController.text = currentUser!.id;
      logger.i('ini user ${currentUser?.email}, ini ID user ${currentUser?.id}');
    } catch (e) {
      btnControllerLoginGoogle.stop();
      logger.e(e);
    } finally {
      emailPamController.text = currentUser!.email;
      uidPamController.text = currentUser!.id;
      // if (currentUser != null) Get.to(RegisterView());
      login();
    }
  }

  Future login() async {
    try {
      final res = await sessionProvider.login(email: currentUser!.email, id: currentUser!.id);
      logger.i(res!.message!);
      if (res.message == "Please register first") {
        await Get.to(RegisterView());
        btnControllerLoginGoogle.stop();
      } else if (res.message == "Please pay first") {
        await boxUser.write(priceInit, (res.data?.transaction?.totalAmount == null) ? 0 : res.data?.transaction!.totalAmount!);
        await boxPrice.write(phoneNumberVerification, res.data?.phoneNumber);
        await boxPrice.write(orderIdTrx, res.data?.transaction!.transactionId!);
        logger.i("ini harga ${boxUser.read(priceInit)}");
        logger.i("ini trx order ${boxUser.read(orderIdTrx)}");
        logger.i("ini phone ${boxUser.read(phoneNumberVerification)}");
        await Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.to(PaymentView()));
        btnControllerLoginGoogle.stop();
      } else {
        boxUser.write(tokenBearer, res.data?.token);
        logger.i(boxUser.read('ini harga $priceInit'));
        await Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.offAllNamed(Routes.HOME));
        btnControllerLoginGoogle.stop();
      }
    } catch (e) {
      logger.w(e);
      btnControllerLoginGoogle.stop();
    } finally {
      btnControllerLoginGoogle.stop();
    }
  }

  Future logOut() async {
    final res = await sessionProvider.logOut(
        email: boxUser.read(emailGoogle), id: boxUser.read(uidGoogle), bearer: boxUser.read(tokenBearer));
    logger.i(res!.message!);
    if (res.message == "Logout Successfully") {
      await googleSignOut();
      await Get.toNamed(Routes.SESSION);
      boxUser.write(tokenBearer, null);
      boxUser.write(emailGoogle, null);
      boxUser.write(uidGoogle, null);
    } else {
      boxUser.write(tokenBearer, null);
      boxUser.write(emailGoogle, null);
      boxUser.write(uidGoogle, null);
      Get.to(UnauthenticationView());
    }
  }

  /// Login With Google
  void readGoogleUser() {
    logger.i("ini email google ${boxUser.read(emailGoogle)}");
    logger.i("ini uid google ${boxUser.read(uidGoogle)}");
  }

  void sendWhatsAppConfirm({String? time}) async {
    var url =
        """https://api.whatsapp.com/send?phone=62${boxUser.read(phoneNumberVerification)}&text=Kami%20telah%20melakukan%20pendaftaran%20aplikasi%20Airren%20sekaligus%20melakukan%20pembayaran%20via%20bank%20dengan%20keterangan%20sbb%20:%0ANomor%20Order%20:%20${boxUser.read(orderIdTrx)}%0ADari%20Bank%20:%0AKe%20Bank%20:%0AJumlah%20:%20${rpFormatter(value: boxUser.read(priceInit))}%0ATanggal%20:%20%0AMohon%20diperiksa%20dan%20diaktifkan%20akun%20kami%20Terimakasih""";
    await launch(url);
  }
}
