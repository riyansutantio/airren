import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/invoice_pam.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../error_handling/views/unauthentication_view.dart';

class print_controller extends GetxController {
  print_controller(
      {required this.p, required this.id, required this.idInvoice});
  CatatMeterProvider? p;
  int? id;
  int? idInvoice;
  RxInt? totalPrice = 0.obs;
  final dataTransactionAllModel = TransactionAllModel().obs;
  Rx<Pam>? dataPam = Pam().obs;
  Rx<TransactionAllModel>? tm = TransactionAllModel().obs;
  RxInt? fee = 0.obs;
  RxInt? charge = 0.obs;
  RxInt? totalResult = 0.obs;
  RxList<CostDetail>? result = <CostDetail>[].obs;
  final isloading = false.obs;
  final boxUser = GetStorage();
  RxString? numberPhone = ''.obs;
  pref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    numberPhone?.value = (preferences.getString('phoneNumber') ?? '');
  }

  @override
  void onInit() async {
    super.onInit();
    await pref();
    logger.i('test');
    if (id != null && idInvoice != null) {
      await getPeymentIvoice();
    }
  }

  Future getPeymentIvoice() async {
    try {
      isloading.value = true;
      final res = await p!.getPeymentMonthInvoice(
          bearer: boxUser.read(tokenBearer), id: id, idInvoice: idInvoice);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        tm?.value = res.data!.tm!;
        dataPam?.value = res.data!.pam!;
        result?.assignAll(res.data!.cusMs!);
        fee?.value = res.data!.pam!.adminFee!;
        charge?.value = res.data!.pam!.charge!;
        result!.value.forEach((element) {
          totalPrice = totalPrice! + int.parse(element.total!);
        });
        totalResult!.value = fee!.value + totalPrice!.value + charge!.value;
        // result.assignAll(res.data!.cusMs!);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isloading.value = false;
    }
  }
}
