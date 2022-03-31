import 'package:airen/app/model/term_about_help_model.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/utils.dart';

class AccountController extends GetxController {

  AccountProvider accountProvider;


  AccountController({required this.accountProvider});

  final isLoadingAboutUs = false.obs;
  final isLoadingTermCondition = false.obs;
  final isLoadingPrivacy = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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

}
