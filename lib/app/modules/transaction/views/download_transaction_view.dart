import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/pdfTransaction_controller.dart';
import '../provider/pdfTransaction_provider.dart';

class DownloadTransaction extends GetView<PdfTransactionController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PdfTransactionController>(
      init: PdfTransactionController(p: PdfTransactionProvider()),
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
                              'Laporan',
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
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Transaksi",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#0063F8')),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Anda dapat memfilternya\n terlebih dahulu sebelum\n mendownload",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: HexColor('#707793')
                                              .withOpacity(0.7)),
                                    )
                                  ],
                                ),
                                Icon(EvaIcons.fileTextOutline,
                                    size: 62,
                                    color:
                                        HexColor('#0063F8').withOpacity(0.15))
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            PopupMenuButton<int>(
                              onSelected: (int v) {
                                print(v);
                                final daysCount = DateTime.now().year;

                                controller.resultYears.value = v.toString();
                              },
                              itemBuilder: (BuildContext ctx) =>
                                  controller.result!,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor('#0063F8')
                                              .withOpacity(0.05)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller.resultYears.value,
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: HexColor('#707793')),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                EvaIcons
                                                    .arrowIosDownwardOutline,
                                                color: HexColor('#0063F8'),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            PopupMenuButton<int>(
                              onSelected: (int v) {
                                print(v);
                                final daysCount = DateTime.now().year;

                                controller.resultMonths.value = v.toString();
                              },
                              itemBuilder: (BuildContext ctx) =>
                                  controller.resultmonth!,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor('#0063F8')
                                              .withOpacity(0.05)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                " ${monthsAll[int.parse(controller.resultMonths.value) - 1]}",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: HexColor('#707793')),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                EvaIcons
                                                    .arrowIosDownwardOutline,
                                                color: HexColor('#0063F8'),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            PopupMenuButton<int>(
                              onSelected: (int v) {
                                print(v);
                                if (v == 1) {
                                  controller.resultStatus.value = 'income';
                                } else {
                                  controller.resultStatus.value = 'expense';
                                }
                                print(controller.resultStatus.value);
                              },
                              itemBuilder: (BuildContext ctx) =>
                                  controller.status!,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor('#0063F8')
                                              .withOpacity(0.05)),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                controller.resultStatus.value ==
                                                        'income'
                                                    ? "Pemasukan"
                                                    : "Pengeluaran",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: HexColor('#707793')),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                EvaIcons
                                                    .arrowIosDownwardOutline,
                                                color: HexColor('#0063F8'),
                                              ),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.getPdfTransactions();
                              },
                              child: Container(
                                  height: 48,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.2),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                          colors: gradientColorAirren),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Icon(
                                            EvaIcons.cloudDownloadOutline,
                                            color: HexColor('#ffffff'),
                                            size: 24,
                                          )),
                                      Text(
                                        "Download",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ),
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0.0, 8.0),
                                color: Color.fromRGBO(0, 99, 248, 0.16),
                                blurRadius: 24,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
            )));
      },
    );
  }
}
