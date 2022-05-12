import 'package:airen/app/modules/transaction/views/expense/add_expense.dart';
import 'package:airen/app/modules/transaction/views/income/add_income.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/transaction_controller.dart';
import '../provider/transaction_provider.dart';
import 'download_transaction_view.dart';
import 'income/first_blance.dart';

class TransactionView extends GetView<TransactionController> {
  ScrollController sc = ScrollController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent.withOpacity(0)));
    return GetBuilder<TransactionController>(
      init: TransactionController(p: TransactionProvider()),
      builder: (controller) {
        return Scaffold(
            extendBodyBehindAppBar: true,
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
                              'Transaksi',
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
                              child: const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(EvaIcons.bellOutline,
                                    color: Colors.white),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.transparent.withOpacity(0),
                    boxShadow: const []),
              ),
              preferredSize: Size.fromHeight(Get.height * 0.1),
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(100)),
                  child: PopupMenuButton(
                      offset: const Offset(0, -125),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      padding: const EdgeInsets.only(right: 100),
                      onSelected: (String selectedValue) {
                        if (selectedValue == '1') {
                          Get.to(AddIncome());
                        } else {
                          Get.to(AddExpense());
                        }
                        print(selectedValue);
                      },
                      child: Container(
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      itemBuilder: (BuildContext ctx) => [
                            PopupMenuItem(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Pemasukan'),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      EvaIcons.arrowCircleDownOutline,
                                      color: HexColor('#05C270'),
                                    )
                                  ],
                                ),
                                value: '1'),
                            PopupMenuItem(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Pengeluaran'),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Icon(
                                      EvaIcons.arrowCircleUpOutline,
                                      color: HexColor('#FF3B3B'),
                                    )
                                  ],
                                ),
                                value: '2'),
                          ])),
            ),
            body: Obx(
              () => Container(
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      child: Stack(children: [
                        Positioned(
                          top: -50,
                          left: 0,
                          right: 0,
                          child: Image.asset("assets/bgt.png"),
                        ),
                        Positioned.fill(
                            top: 140,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Rp ",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 32, color: Colors.white)),
                                    Text(
                                        controller.total_balance == null
                                            ? '0'
                                            : "${rupiah(controller.total_balance)}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 32,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text("Saldo sekarang",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color:
                                              Colors.white.withOpacity(0.7))),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                controller.firstBlance!.value != 1
                                    ? btnSaldo()
                                    : controller.total_balance == null
                                        ? btnSaldo()
                                        : const SizedBox()
                              ],
                            ))
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            color: Colors.white),
                        child:
                            controller.pamTransResult.isEmpty &&
                                    controller.pamTransResult.length <= 0
                                ? Center(
                                    child: noListTransaksi(),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 24, left: 24.0, right: 24.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Transaksi terbaru',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#3C3F58'),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Get.to(
                                                        DownloadTransaction());
                                                  },
                                                  icon: Icon(
                                                    EvaIcons
                                                        .cloudDownloadOutline,
                                                    color: HexColor('#0063F8'),
                                                    size: 25,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  itemCount: controller
                                                      .pamTransResult.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    String typ = controller
                                                                .pamTransResult[
                                                                    index]
                                                                .type ==
                                                            'income'
                                                        ? 'Pemasukan'
                                                        : 'Pengeluaran';
                                                    int count = controller
                                                            .pamTransResult
                                                            .length +
                                                        1;
                                                    return index ==
                                                            controller
                                                                    .pamTransResult
                                                                    .length -
                                                                1
                                                        ? Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  controller
                                                                          .nameDetailController
                                                                          .text =
                                                                      controller
                                                                          .pamTransResult[
                                                                              index]
                                                                          .name!;
                                                                  controller
                                                                      .deskriptionDetailController
                                                                      .text = controller
                                                                          .pamTransResult[
                                                                              index]
                                                                          .description ??
                                                                      '';
                                                                  controller
                                                                          .nominalDetailController
                                                                          .text =
                                                                      controller
                                                                          .pamTransResult[
                                                                              index]
                                                                          .amount
                                                                          .toString();
                                                                  // controller.pamTransResult[index]
                                                                  //             .type ==
                                                                  //         'income'
                                                                  //     ? Get.to(DetailIncome())
                                                                  //     : 1;
                                                                  Get.bottomSheet(
                                                                      Obx(() =>
                                                                          Container(
                                                                            decoration:
                                                                                const BoxDecoration(
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                                                              color: Colors.white,
                                                                            ),
                                                                            child:
                                                                                Wrap(
                                                                              children: [
                                                                                Column(
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
                                                                                      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                                                                                      child: Container(
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            ListTile(
                                                                                              contentPadding: const EdgeInsets.all(10),
                                                                                              dense: false,
                                                                                              title: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Detail Transaksi',
                                                                                                    style: GoogleFonts.montserrat(
                                                                                                      color: HexColor('#3C3F58'),
                                                                                                      fontSize: 14,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(top: 8.0),
                                                                                                    child: Text(
                                                                                                      '${controller.pamTransResult[index].name}',
                                                                                                      style: GoogleFonts.montserrat(
                                                                                                        color: HexColor('#3C3F58'),
                                                                                                        fontSize: 12,
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(top: 4.0),
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          child: Container(
                                                                                                            width: MediaQuery.of(context).size.width - 132,
                                                                                                            child: Row(
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  'Rp ${rupiah(controller.pamTransResult[index].amount)}',
                                                                                                                  style: GoogleFonts.montserrat(
                                                                                                                    color: HexColor('#FF8801'),
                                                                                                                    fontSize: 14,
                                                                                                                    fontWeight: FontWeight.w700,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                const SizedBox(
                                                                                                                  width: 10,
                                                                                                                ),
                                                                                                                Container(
                                                                                                                  padding: const EdgeInsets.all(6),
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: controller.pamTransResult[index].type == 'income' ? HexColor('#05C270') : HexColor('#FF3B3B'),
                                                                                                                    borderRadius: BorderRadius.circular(6),
                                                                                                                  ),
                                                                                                                  child: Text(
                                                                                                                    typ,
                                                                                                                    style: GoogleFonts.montserrat(
                                                                                                                      color: HexColor('#FFFFFF'),
                                                                                                                      fontSize: 12,
                                                                                                                      fontWeight: FontWeight.bold,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              subtitle: Column(
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  const SizedBox(
                                                                                                    height: 15,
                                                                                                  ),
                                                                                                  Text(
                                                                                                    'Catatan:',
                                                                                                    style: GoogleFonts.montserrat(
                                                                                                      color: HexColor('#000000'),
                                                                                                      fontSize: 13,
                                                                                                      fontWeight: FontWeight.w500,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Text(
                                                                                                    controller.pamTransResult[index].description != null ? controller.pamTransResult[index].description! : '',
                                                                                                    maxLines: 3,
                                                                                                    style: GoogleFonts.montserrat(
                                                                                                      color: HexColor('#707793'),
                                                                                                      fontSize: 12,
                                                                                                      fontWeight: FontWeight.w300,
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              leading: CircleAvatar(
                                                                                                  maxRadius: 30,
                                                                                                  backgroundColor: HexColor('#0063F8'),
                                                                                                  child: Container(
                                                                                                    width: 55,
                                                                                                    height: 55,
                                                                                                    child: Column(
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Text(
                                                                                                          controller.pamTransResult[index].createdAt!.day <= 9 ? '0' + controller.pamTransResult[index].createdAt!.day.toString().toUpperCase() : controller.pamTransResult[index].createdAt!.day.toString().toUpperCase(),
                                                                                                          style: GoogleFonts.montserrat(
                                                                                                            color: HexColor('#FFFFFF'),
                                                                                                            fontSize: 16,
                                                                                                            fontWeight: FontWeight.bold,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text(
                                                                                                          months[controller.pamTransResult[index].createdAt!.month - 1],
                                                                                                          style: GoogleFonts.montserrat(
                                                                                                            color: HexColor('#FFFFFF').withOpacity(0.8),
                                                                                                            fontSize: 12,
                                                                                                            fontWeight: FontWeight.w400,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  )),
                                                                                            ),
                                                                                            const SizedBox(
                                                                                              height: 20,
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: const EdgeInsets.all(20.0),
                                                                                              child: Stack(
                                                                                                children: [
                                                                                                  Opacity(
                                                                                                    opacity: 0.1,
                                                                                                    child: ElevatedButton(
                                                                                                        child: const Center(child: SizedBox()),
                                                                                                        style: ButtonStyle(
                                                                                                          backgroundColor: MaterialStateProperty.all<Color>(HexColor('#0063F8')),
                                                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                            RoundedRectangleBorder(
                                                                                                              borderRadius: BorderRadius.circular(10),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        onPressed: () {
                                                                                                          Get.back();
                                                                                                        }),
                                                                                                  ),
                                                                                                  Positioned.fill(
                                                                                                      child: Align(
                                                                                                          alignment: Alignment.center,
                                                                                                          child: InkWell(
                                                                                                              onTap: () {
                                                                                                                Get.back();
                                                                                                              },
                                                                                                              child: Icon(
                                                                                                                EvaIcons.arrowIosDownwardOutline,
                                                                                                                color: HexColor('#0063F8'),
                                                                                                              ))))
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        decoration: const BoxDecoration(boxShadow: [
                                                                                          BoxShadow(
                                                                                            offset: Offset(0.0, 8.0),
                                                                                            color: Color.fromRGBO(0, 99, 248, 0.16),
                                                                                            blurRadius: 24,
                                                                                          ),
                                                                                        ], borderRadius: BorderRadius.all(Radius.circular(16)), color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )));
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      left:
                                                                          16.0,
                                                                      right:
                                                                          16.0),
                                                                  child:
                                                                      Container(
                                                                    child: ListTile(
                                                                        contentPadding: const EdgeInsets.all(10),
                                                                        dense: false,
                                                                        title: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              '${controller.pamTransResult[index].name}',
                                                                              style: GoogleFonts.montserrat(
                                                                                color: HexColor('#3C3F58'),
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 4.0),
                                                                              child: Text(
                                                                                'Rp ${rupiah(controller.pamTransResult[index].amount)}',
                                                                                style: GoogleFonts.montserrat(
                                                                                  color: HexColor('#FF8801'),
                                                                                  fontSize: 14,
                                                                                  fontWeight: FontWeight.w700,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        subtitle: Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 4.0),
                                                                          child:
                                                                              Text(
                                                                            controller.pamTransResult[index].description ??
                                                                                '',
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              color: HexColor('#707793').withOpacity(0.7),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        leading: CircleAvatar(
                                                                            maxRadius: 30,
                                                                            backgroundColor: HexColor('#0063F8').withOpacity(0.05),
                                                                            child: Container(
                                                                              width: 55,
                                                                              height: 55,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    controller.pamTransResult[index].createdAt!.day <= 9 ? '0' + controller.pamTransResult[index].createdAt!.day.toString().toUpperCase() : controller.pamTransResult[index].createdAt!.day.toString().toUpperCase(),
                                                                                    style: GoogleFonts.montserrat(
                                                                                      color: HexColor('#0063F8').withOpacity(0.8),
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    months[controller.pamTransResult[index].createdAt!.month - 1],
                                                                                    style: GoogleFonts.montserrat(
                                                                                      color: HexColor('#0063F8').withOpacity(0.8),
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                        trailing: Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(left: 8.0),
                                                                          child:
                                                                              Icon(
                                                                            controller.pamTransResult[index].type == "expense"
                                                                                ? EvaIcons.arrowCircleUpOutline
                                                                                : EvaIcons.arrowCircleDownOutline,
                                                                            color: controller.pamTransResult[index].type == "expense"
                                                                                ? HexColor('#FF3B3B')
                                                                                : HexColor('#05C270'),
                                                                          ),
                                                                        )),
                                                                    decoration: const BoxDecoration(
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            offset:
                                                                                Offset(0.0, 8.0),
                                                                            color: Color.fromRGBO(
                                                                                0,
                                                                                99,
                                                                                248,
                                                                                0.16),
                                                                            blurRadius:
                                                                                24,
                                                                          ),
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(
                                                                                16)),
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 24,
                                                              ),
                                                              Center(
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                        DownloadTransaction());
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(boxShadow: const [
                                                                        BoxShadow(
                                                                          offset: Offset(
                                                                              0.0,
                                                                              8.0),
                                                                          color: Color.fromRGBO(
                                                                              0,
                                                                              99,
                                                                              248,
                                                                              0.2),
                                                                          blurRadius:
                                                                              24,
                                                                        ),
                                                                      ], gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(10)),
                                                                      child: SizedBox(
                                                                          width: 48,
                                                                          height: 48,
                                                                          child: Icon(
                                                                            EvaIcons.cloudDownloadOutline,
                                                                            color:
                                                                                HexColor('#ffffff'),
                                                                          ))),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        : GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                      .nameDetailController
                                                                      .text =
                                                                  controller
                                                                      .pamTransResult[
                                                                          index]
                                                                      .name!;
                                                              controller
                                                                  .deskriptionDetailController
                                                                  .text = controller
                                                                      .pamTransResult[
                                                                          index]
                                                                      .description ??
                                                                  '';
                                                              controller
                                                                      .nominalDetailController
                                                                      .text =
                                                                  controller
                                                                      .pamTransResult[
                                                                          index]
                                                                      .amount
                                                                      .toString();
                                                              // controller.pamTransResult[index]
                                                              //             .type ==
                                                              //         'income'
                                                              //     ? Get.to(DetailIncome())
                                                              //     : 1;
                                                              Get.bottomSheet(
                                                                  Obx(() =>
                                                                      Container(
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topRight: Radius.circular(40),
                                                                              topLeft: Radius.circular(40)),
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            Column(
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
                                                                                  padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                                                                                  child: Container(
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        ListTile(
                                                                                          contentPadding: const EdgeInsets.all(10),
                                                                                          dense: false,
                                                                                          title: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Text(
                                                                                                'Detail Transaksi',
                                                                                                style: GoogleFonts.montserrat(
                                                                                                  color: HexColor('#3C3F58'),
                                                                                                  fontSize: 14,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(top: 8.0),
                                                                                                child: Text(
                                                                                                  '${controller.pamTransResult[index].name}',
                                                                                                  style: GoogleFonts.montserrat(
                                                                                                    color: HexColor('#3C3F58'),
                                                                                                    fontSize: 12,
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(top: 4.0),
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      child: Container(
                                                                                                        width: MediaQuery.of(context).size.width - 132,
                                                                                                        child: Row(
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              'Rp ${rupiah(controller.pamTransResult[index].amount)}',
                                                                                                              style: GoogleFonts.montserrat(
                                                                                                                color: HexColor('#FF8801'),
                                                                                                                fontSize: 14,
                                                                                                                fontWeight: FontWeight.w700,
                                                                                                              ),
                                                                                                            ),
                                                                                                            const SizedBox(
                                                                                                              width: 10,
                                                                                                            ),
                                                                                                            Container(
                                                                                                              padding: const EdgeInsets.all(6),
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: controller.pamTransResult[index].type == 'income' ? HexColor('#05C270') : HexColor('#FF3B3B'),
                                                                                                                borderRadius: BorderRadius.circular(6),
                                                                                                              ),
                                                                                                              child: Text(
                                                                                                                typ,
                                                                                                                style: GoogleFonts.montserrat(
                                                                                                                  color: HexColor('#FFFFFF'),
                                                                                                                  fontSize: 12,
                                                                                                                  fontWeight: FontWeight.bold,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          subtitle: Column(
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              const SizedBox(
                                                                                                height: 15,
                                                                                              ),
                                                                                              Text(
                                                                                                'Catatan:',
                                                                                                style: GoogleFonts.montserrat(
                                                                                                  color: HexColor('#000000'),
                                                                                                  fontSize: 13,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                ),
                                                                                              ),
                                                                                              Text(
                                                                                                controller.pamTransResult[index].description != null ? controller.pamTransResult[index].description! : '',
                                                                                                maxLines: 3,
                                                                                                style: GoogleFonts.montserrat(
                                                                                                  color: HexColor('#707793'),
                                                                                                  fontSize: 12,
                                                                                                  fontWeight: FontWeight.w300,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          leading: CircleAvatar(
                                                                                              maxRadius: 30,
                                                                                              backgroundColor: HexColor('#0063F8'),
                                                                                              child: Container(
                                                                                                width: 55,
                                                                                                height: 55,
                                                                                                child: Column(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Text(
                                                                                                      controller.pamTransResult[index].createdAt!.day <= 9 ? '0' + controller.pamTransResult[index].createdAt!.day.toString().toUpperCase() : controller.pamTransResult[index].createdAt!.day.toString().toUpperCase(),
                                                                                                      style: GoogleFonts.montserrat(
                                                                                                        color: HexColor('#FFFFFF'),
                                                                                                        fontSize: 16,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                      ),
                                                                                                    ),
                                                                                                    Text(
                                                                                                      months[controller.pamTransResult[index].createdAt!.month - 1],
                                                                                                      style: GoogleFonts.montserrat(
                                                                                                        color: HexColor('#FFFFFF').withOpacity(0.8),
                                                                                                        fontSize: 12,
                                                                                                        fontWeight: FontWeight.w400,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              )),
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          height: 20,
                                                                                        ),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(20.0),
                                                                                          child: Stack(
                                                                                            children: [
                                                                                              Opacity(
                                                                                                opacity: 0.1,
                                                                                                child: ElevatedButton(
                                                                                                    child: const Center(child: SizedBox()),
                                                                                                    style: ButtonStyle(
                                                                                                      backgroundColor: MaterialStateProperty.all<Color>(HexColor('#0063F8')),
                                                                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                                                        RoundedRectangleBorder(
                                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    onPressed: () {
                                                                                                      Get.back();
                                                                                                    }),
                                                                                              ),
                                                                                              Positioned.fill(
                                                                                                  child: Align(
                                                                                                      alignment: Alignment.center,
                                                                                                      child: InkWell(
                                                                                                          onTap: () {
                                                                                                            Get.back();
                                                                                                          },
                                                                                                          child: Icon(
                                                                                                            EvaIcons.arrowIosDownwardOutline,
                                                                                                            color: HexColor('#0063F8'),
                                                                                                          ))))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    decoration: const BoxDecoration(boxShadow: [
                                                                                      BoxShadow(
                                                                                        offset: Offset(0.0, 8.0),
                                                                                        color: Color.fromRGBO(0, 99, 248, 0.16),
                                                                                        blurRadius: 24,
                                                                                      ),
                                                                                    ], borderRadius: BorderRadius.all(Radius.circular(16)), color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 8.0,
                                                                      left:
                                                                          16.0,
                                                                      right:
                                                                          16.0),
                                                              child: Container(
                                                                child: ListTile(
                                                                    contentPadding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    dense:
                                                                        false,
                                                                    title:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${controller.pamTransResult[index].name}',
                                                                          style:
                                                                              GoogleFonts.montserrat(
                                                                            color:
                                                                                HexColor('#3C3F58'),
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(top: 4.0),
                                                                          child:
                                                                              Text(
                                                                            'Rp ${rupiah(controller.pamTransResult[index].amount)}',
                                                                            style:
                                                                                GoogleFonts.montserrat(
                                                                              color: HexColor('#FF8801'),
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    subtitle:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          top:
                                                                              4.0),
                                                                      child:
                                                                          Text(
                                                                        controller.pamTransResult[index].description ??
                                                                            '',
                                                                        style: GoogleFonts
                                                                            .montserrat(
                                                                          color:
                                                                              HexColor('#707793').withOpacity(0.7),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    leading:
                                                                        CircleAvatar(
                                                                            maxRadius:
                                                                                30,
                                                                            backgroundColor: HexColor('#0063F8').withOpacity(
                                                                                0.05),
                                                                            child:
                                                                                Container(
                                                                              width: 55,
                                                                              height: 55,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    controller.pamTransResult[index].createdAt!.day <= 9 ? '0' + controller.pamTransResult[index].createdAt!.day.toString().toUpperCase() : controller.pamTransResult[index].createdAt!.day.toString().toUpperCase(),
                                                                                    style: GoogleFonts.montserrat(
                                                                                      color: HexColor('#0063F8').withOpacity(0.8),
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    months[controller.pamTransResult[index].createdAt!.month - 1],
                                                                                    style: GoogleFonts.montserrat(
                                                                                      color: HexColor('#0063F8').withOpacity(0.8),
                                                                                      fontSize: 12,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )),
                                                                    trailing:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        controller.pamTransResult[index].type ==
                                                                                "expense"
                                                                            ? EvaIcons.arrowCircleUpOutline
                                                                            : EvaIcons.arrowCircleDownOutline,
                                                                        color: controller.pamTransResult[index].type ==
                                                                                "expense"
                                                                            ? HexColor('#FF3B3B')
                                                                            : HexColor('#05C270'),
                                                                      ),
                                                                    )),
                                                                decoration: const BoxDecoration(
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        offset: Offset(
                                                                            0.0,
                                                                            8.0),
                                                                        color: Color.fromRGBO(
                                                                            0,
                                                                            99,
                                                                            248,
                                                                            0.16),
                                                                        blurRadius:
                                                                            24,
                                                                      ),
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(
                                                                            16)),
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          );
                                                  })),
                                        ),
                                      ),
                                    ],
                                  ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
            ));
      },
    );
  }

  Widget btnSaldo() {
    return ElevatedButton(
        onPressed: () {
          Get.to(FirstBlance());
        },
        child: Ink(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 8.0),
              color: Color.fromRGBO(0, 99, 248, 0.2),
              blurRadius: 24,
            ),
          ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 48,
            width: 170,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    EvaIcons.plusCircleOutline,
                    color: HexColor('#0063F8'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Saldo awal',
                    style: GoogleFonts.montserrat(
                      color: HexColor('#0063F8'),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }

  Widget noListTransaksi() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/emptylist.png",
            width: 77,
            height: 90,
          ),
          const SizedBox(height: 30),
          Text(
            "Belum ada transaksi",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Gunakan tombol di bawah untuk\nmenambahkan transaksi baru.",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                color: HexColor('#707793'),
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
