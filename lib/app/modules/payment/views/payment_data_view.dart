import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../model/meter_transaction_model.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/payment_controller.dart';
import '../providers/payment_providers.dart';

class PaymentDataViews extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(p: PaymentProviders()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.blue,
          appBar: buildAppBarDefault(context),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // controller.toUnpaid();
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(),
                                controller.paymentData.value == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/clock.svg'),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Belum Lunas',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (controller.paymentData.value == 0)
                                            Container(
                                              width: 35,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/clockoff.svg',
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Belum Lunas',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.toBaseFee();
                        },
                        child: Container(
                          color: Colors.transparent,
                          height: 90,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                controller.paymentData.value == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/checklunas.svg',
                                              color: Colors.white),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Lunas',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (controller.paymentData.value == 1)
                                            Container(
                                              width: 35,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/checklunasoff.svg',
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Lunas',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                controller.paymentData.value == 2
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/dendaon.svg',
                                              color: Colors.white),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Denda',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (controller.paymentData.value == 2)
                                            Container(
                                              width: 35,
                                              height: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            )
                                        ],
                                      )
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset('assets/denda.svg',
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Denda',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                buildExpandedUnpaid()
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // (controller.paymentData.value == 0) ? Get.to(AddPamManageView()) : Get.to(AddBaseFeeView());
            },
            backgroundColor: HexColor('#0063F8'),
            elevation: 0,
            child: Container(
              child: const Icon(EvaIcons.plus),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                boxShadow: [
                  BoxShadow(
                    color: HexColor('#0063F8').withOpacity(0.16),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBarDefault(BuildContext context) {
    return AppBar(
        elevation: 0,
        leadingWidth: 240,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: Text(
              'Pembayaran',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {
                  Get.to(ErrorHandlingView());
                },
                child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
        ));
  }

  Expanded buildExpandedBasePrice() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.zero,
                  ),
                )),
      ),
    );
  }

  Expanded buildExpandedUnpaid() {
    return Expanded(
        child: Obx(() => Container(
              padding: const EdgeInsets.only(top: 8.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: StickyGroupedListView<TransactionModel, DateTime>(
                order: StickyGroupedListOrder.DESC,
                elements: controller.result.value,
                groupBy: (TransactionModel element) => DateTime(
                  element.yearof!,
                ),
                itemComparator:
                    (TransactionModel element1, TransactionModel element2) =>
                        element1.yearof!.compareTo(element2.yearof!),
                floatingHeader: true,
                groupSeparatorBuilder: (TransactionModel element) => Container(
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          controller.now.value.year == element.yearof
                              ? 'Tahun Sekarang'
                              : 'Tahun ${element.yearof}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: HexColor('#0063F8').withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, TransactionModel element) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      elevation: 8.0,
                      child: Container(
                        child: ListTile(
                          leading: CircleAvatar(
                              maxRadius: 30,
                              backgroundColor:
                                  HexColor('#FF8801').withOpacity(0.1),
                              child: Icon(
                                EvaIcons.alertTriangleOutline,
                                color: HexColor('#FF3B3B'),
                              )),
                          contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            monthsAll[element.monthof! - 1],
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: HexColor('#3C3F58')),
                          ),
                          subtitle: Text(
                            element.numberofrecordedconsumer.toString() +
                                ' dari ${element.numberofconsumer} tagihan',
                            style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: HexColor('#707793').withOpacity(0.7)),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
