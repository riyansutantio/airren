import 'package:airen/app/modules/payment/views/payment_invoice_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/payment_controller.dart';
import '../controllers/peyment_month_controller.dart';
import '../providers/payment_providers.dart';

class PaymentMonth extends GetView<PaymentMonthController> {
  int? id;
  PaymentMonth({required this.id});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMonthController>(
      init: PaymentMonthController(p: PaymentProviders(), id: id),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: (controller.isSearch.value)
                  ? buildAppBarSearch(context, controller)
                  : PreferredSize(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
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
                                      'Febuari 2022',
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isSearch.value = true;
                                      },
                                      child: const Icon(
                                        EvaIcons.search,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              HexColor('#5433FF'),
                              HexColor('#0063F8')
                            ]),
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
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: controller.result.value.length,
                          itemBuilder: (context, index) {
                            String? name =
                                controller.result[index].name!.length <= 14
                                    ? controller.result[index].name!
                                    : controller.result[index].name!.substring(0,14)+'..';
                            return GestureDetector(
                              onTap: () {
                                Get.to(PaymentInvoice(
                                  id: id,
                                  idInvoice: controller.result[index].id,
                                  name: name,
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, left: 16.0, right: 16.0),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${controller.result[index].name}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#3C3F58'),
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            rupiah(controller
                                                .result[index].amount),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#FF8801'),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.result[index].uniqueId}",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: HexColor('#0063F8')
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "${controller.result[index].address}",
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: HexColor('#707793')
                                                          .withOpacity(0.7),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              child: Text(
                                                "${controller.result[index].status}",
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
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Container(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  229,
                                              padding: const EdgeInsets.all(9),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Dibuat pada",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: HexColor(
                                                                '#707793'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${controller.result[index].publishedAt!.day} ${months[controller.result[index].publishedAt!.month - 1]} ${controller.result[index].publishedAt!.year}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            color: HexColor(
                                                                '#0063F8'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: HexColor('#0063F8')
                                                    .withOpacity(0.05)),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  229,
                                              padding: const EdgeInsets.all(9),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Volume",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 12,
                                                            color: HexColor(
                                                                '#707793'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "${controller.result[index].meterNow}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            fontSize: 14,
                                                            color: HexColor(
                                                                '#05C270'),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: HexColor('#0063F8')
                                                    .withOpacity(0.05)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.16),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      color: Colors.white),
                                ),
                              ),
                            );
                          })),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
            ));
      },
    );
  }

  PreferredSize buildAppBarSearch(
      BuildContext context, PaymentMonthController controller) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.isSearch.value = false;
                  // controller.searchValue.value = '';
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: AirenTextFormFieldBase(
                  onSubmit: (val) {
                    controller.searchController.clear();
                    logger.i(val!);
                    return null;
                  },
                  onChange: (val) {
                    controller.searchValue.value = val!;
                    return null;
                  },
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(EvaIcons.search),
                  ),
                  autofocus: true,
                  textInputType: TextInputType.text,
                  hintText: 'Cari..',
                  obscureText: false,
                  passwordVisibility: false,
                  controller: controller,
                  textEditingController: controller.searchController,
                  returnValidation: (val) {
                    if (val!.isEmpty) {
                      return "Tarif dasar harus terisi";
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ))
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
            boxShadow: const []),
      ),
      preferredSize: Size.fromHeight(Get.height * 0.1),
    );
  }
}
