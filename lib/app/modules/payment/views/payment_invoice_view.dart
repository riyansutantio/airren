import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/payment_controller.dart';
import '../controllers/payment_invoice_controller.dart';
import '../controllers/peyment_month_controller.dart';
import '../providers/payment_providers.dart';

class PaymentInvoice extends GetView<PaymentInvoiceController> {
  int? id;
  int? idInvoice;
  String? name;
  PaymentInvoice(
      {required this.id, required this.idInvoice, required this.name});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentInvoiceController>(
      init: PaymentInvoiceController(
          p: PaymentProviders(), id: id, idInvoice: idInvoice),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: PreferredSize(
                child: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(EvaIcons.arrowBack),
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                '$name',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.to(ErrorHandlingView());
                                },
                                child: const Icon(EvaIcons.bellOutline,
                                    color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
                      boxShadow: const []),
                ),
                preferredSize: Size.fromHeight(Get.height * 0.1),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 140,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      controller.dataPam!.value.name != null
                                          ? controller.dataPam!.value.name!
                                          : '',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: HexColor('#3C3F58'),
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        controller.dataPam!.value.detailAddress != null &&
                                                controller.dataPam!.value.district!.name !=
                                                    null &&
                                                controller.dataPam!.value
                                                        .regency!.name !=
                                                    null &&
                                                controller.dataPam!.value
                                                        .province!.name !=
                                                    null
                                            ? controller.dataPam!.value
                                                    .detailAddress! +
                                                ',' +
                                                controller.dataPam!.value
                                                    .district!.name! +
                                                ', ' +
                                                controller.dataPam!.value
                                                    .regency!.name! +
                                                ', ' +
                                                controller.dataPam!.value
                                                    .province!.name!
                                            : '',
                                        maxLines: 3,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  // Text(
                                  //     controller.data.value.pam.phoneNumber.
                                  //     style: GoogleFonts.montserrat(
                                  //         fontSize: 12,
                                  //         color: HexColor('#707793').withOpacity(0.7),
                                  //         fontWeight: FontWeight.w500)),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 8.0),
                                    color: Color.fromRGBO(0, 99, 248, 0.16),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 132,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Ditagihkan kepada',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: HexColor('#3C3F58'),
                                              fontWeight: FontWeight.bold)),
                                      Container(
                                        child: Text(
                                          controller.tm!.value.status == null
                                              ? ''
                                              : "${controller.tm!.value.status}",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor('#FF3B3B')),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: HexColor('#FF3B3B')
                                                .withOpacity(0.1)),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        controller.tm!.value.status == null
                                            ? ''
                                            : '${controller.tm!.value.name}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        controller.tm!.value.status == null
                                            ? ''
                                            : '${controller.tm!.value.uniqueId}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 20),
                                    child: Text(
                                        controller.tm!.value.status == null
                                            ? ''
                                            : '${controller.tm!.value.address}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 8.0),
                                    color: Color.fromRGBO(0, 99, 248, 0.16),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              height: 132,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Rincian Pemakaian',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: HexColor('#3C3F58'),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meter Awal",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        controller.tm!.value.starMeter != null
                                            ? "${controller.tm!.value.starMeter}"
                                            : '',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Meter Akhir",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        controller.tm!.value.meterLast == null
                                            ? ''
                                            : "${controller.tm!.value.meterLast}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Volume",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        controller.tm!.value.meterNow == null
                                            ? ''
                                            : "${controller.tm!.value.meterNow}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 8.0),
                                    color: Color.fromRGBO(0, 99, 248, 0.16),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Rincian Biaya',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: HexColor('#3C3F58'),
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.result!.value.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${controller.result![index].meter}   X   ${controller.result![index].cost}   =",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: HexColor('#707793')),
                                            ),
                                            Text(
                                              "${controller.result![index].total}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: HexColor('#707793')),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Subtotal",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        'Rp' +
                                            rupiah(controller.totalPrice!.value
                                                .toString()),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Biaya Admin",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        'Rp' +
                                            rupiah(controller.fee!.value
                                                .toString()),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Denda",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        'Rp 0',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                      Text(
                                        'Rp' +
                                            rupiah(
                                                controller.totalResult!.value),
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(0.0, 8.0),
                                    color: Color.fromRGBO(0, 99, 248, 0.16),
                                    blurRadius: 24,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.updateTransaction(
                                            id: id!, idInvoice: idInvoice!);
                                      },
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0.0, 8.0),
                                                color: Color.fromRGBO(
                                                    0, 99, 248, 0.2),
                                                blurRadius: 24,
                                              ),
                                            ],
                                            color: HexColor('#0063F8'),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                          height: 48,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              218,
                                          child: Center(
                                            child: Text(
                                              'DiBayar',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)))),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                offset: Offset(0.0, 8.0),
                                                color: Color.fromRGBO(
                                                    0, 99, 248, 0.2),
                                                blurRadius: 24,
                                              ),
                                            ],
                                            color: HexColor('#FF8801'),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: SizedBox(
                                          height: 48,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              218,
                                          child: Center(
                                            child: Text(
                                              'Cetak',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      )),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
            ));
      },
    );
  }
}
