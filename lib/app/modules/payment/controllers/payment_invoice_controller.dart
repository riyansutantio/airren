import 'package:airen/app/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/invoice_pam.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../providers/payment_providers.dart';
import '../views/payment_data_view.dart';

class PaymentInvoiceController extends GetxController {
  PaymentInvoiceController(
      {required this.p, required this.id, required this.idInvoice});
  PaymentProviders? p;
  int? id;
  int? idInvoice;
  RxInt? totalPrice = 0.obs;
  Rx<TransactionAllModel>? dataTransactionAllModel = TransactionAllModel().obs;
  Rx<Pam>? dataPam = Pam().obs;
  Rx<TransactionAllModel>? tm = TransactionAllModel().obs;
  RxInt? fee = 0.obs;
  RxInt? charge = 0.obs;
  RxInt? totalResult = 0.obs;
  RxList<CostDetail>? result = <CostDetail>[].obs;
  RxBool? isloading = false.obs;
  final boxUser = GetStorage();
  RxString? numberPhone = ''.obs;
  pref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    numberPhone!.value = (preferences.getString('phoneNumber') ?? '');
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
      isloading?.value = true;
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
        fee?.value = res.data!.tm!.adminfee!;
        charge?.value = res.data!.tm!.charge!;
        result?.value.forEach((element) {
          totalPrice?.value =
              (totalPrice!.value + int.parse(element.total.toString()));
        });
        totalResult?.value = fee!.value + totalPrice!.value + charge!.value;
        // result.assignAll(res.data!.cusMs!);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isloading!.value = false;
    }
  }

  Future updateTransaction({
    required int idInvoice,
    required int id,
  }) async {
    final res = await p!.updatePeymentMonth(
      bearer: boxUser.read(tokenBearer),
      id: id,
      idInvoice: idInvoice,
    );
    if (res!.status! == 'success') {
      Get.off(PaymentDataViews());
      snackBarNotificationSuccess(title: 'Tagihan berhasil dibayar');
    } else {
      snackBarNotificationFailed(title: 'Tagihan gagal dibayar');
    }
  }

  confirmations() {
    Get.bottomSheet(Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40), topLeft: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  width: 70,
                  height: 5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.amber,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SvgPicture.asset('assets/quation.svg'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Konfirmasi',
                  style: GoogleFonts.montserrat(
                    color: HexColor('#3C3F58'),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Status akan menjadi lunas dan tidak\nbisa diubah ke status sebelumnya.',
                  style: GoogleFonts.montserrat(
                    color: HexColor('#707793'),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('Batal',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#0063F8'),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#0063F8').withOpacity(0.2),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateTransaction(id: id!, idInvoice: idInvoice!);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text('Ya, benar',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor('#0063F8'),
                          ),
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10, top: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
