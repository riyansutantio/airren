import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/catat_meter_bulan_view.dart';
import 'package:airen/app/modules/catat_meter/views/catat_meter_view.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../../utils/constant.dart';

class DetailCatatMeter extends GetView<CatatMeterController> {
  final CatatMeterController catatMeterBulanController =
      Get.put(CatatMeterController(catatmeterProvider: CatatMeterProvider()));

  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<CatatMeterController>(
      init: CatatMeterController(catatmeterProvider: CatatMeterProvider()),
      builder: (controller) {
        double x = double.parse(
            controller.meterLastManageDetailCatatBulan.value.toString());
        double? now = double.tryParse(controller.onchangeMeterNow.value) ?? x;
        double? last = double.parse(controller.meterBulanLalu.value.toString());
        double volume = now - last;
        var id = controller.idManageDetailCatatBulan.value;
        return Scaffold(
          appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                  controller.statusDetail.value =
                                      !controller.statusDetail.value;
                                  controller.clearCondition();
                                },
                                icon: const Icon(EvaIcons.arrowBack),
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                controller.judul.toString(),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 0, bottom: 0, right: 15),
                              child: GestureDetector(
                                  onTap: () {
                                    // Get.to(ErrorHandlingView());
                                  },
                                  child: const Icon(EvaIcons.bellOutline,
                                      color: Colors.white)),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (controller.meterNowController.text != '') {
                                  if (controller.statusDetail.value == true) {
                                    if (int.parse(controller
                                            .meterLastManageDetailCatatBulan
                                            .value) >
                                        int.parse(controller
                                            .meterNowController.text)) {
                                      logger.e("masuk sini");
                                      Get.back();
                                      snackBarNotificationFailed(
                                          title:
                                              "Nilai input data tidak valid");
                                    } else {
                                      catatMeterBulanController.addCatatMeter();
                                    }
                                  } else {
                                    if (int.parse(controller
                                            .meterLastManageDetailCatatBulan
                                            .value) >
                                        int.parse(controller
                                            .meterNowController.text)) {
                                      logger.e("masuk sini");
                                      Get.back();
                                      snackBarNotificationFailed(
                                          title:
                                              "Nilai input data tidak valid");
                                    } else {
                                      catatMeterBulanController
                                          .updateCatatMeter(
                                        id: controller.idManageCatatBulan
                                            .toString(),
                                        meter_now: controller
                                            .meterNowManageDetailCatatBulan
                                            .toString(),
                                        month: controller.bulan.value,
                                      );
                                    }
                                  }
                                } else {
                                  Get.back();
                                  snackBarNotificationFailed(
                                      title: "Nilai input tidak valid");
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, bottom: 0, right: 10),
                                child: GestureDetector(
                                    onTap: () {},
                                    child: const Icon(EvaIcons.checkmark,
                                        color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 25, right: 20, left: 20, bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 20),
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        backgroundColor:
                                            Colors.blue.withOpacity(0.1),
                                        child: Text(
                                          controller.getInitials(
                                            controller
                                                .nameManageDetailCatatBulan
                                                .toString(),
                                          ),
                                          style: GoogleFonts.montserrat(
                                            color: Colors.blue,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.nameManageDetailCatatBulan
                                                        .toString()
                                                        .length <=
                                                    12
                                                ? controller
                                                    .nameManageDetailCatatBulan
                                                    .toString()
                                                : controller
                                                        .nameManageDetailCatatBulan
                                                        .toString()
                                                        .substring(0, 12) +
                                                    '..',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            controller
                                                .addressManageDetailCatatBulan
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Text(
                                    controller.uniqueIdManageDetailCatatBulan
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                              child: Divider(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Bulan lalu",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          controller.meterBulanLalu.value
                                              .toString(),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: HexColor('#5433FF')),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color:
                                              Colors.blue, // set border color
                                          width: 3.0), // set border width
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                              15.0)), // set rounded corner radius
                                    ),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp('[,]')),
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.]')),
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: Colors.blue,
                                        hintText: controller
                                            .meterNowManageDetailCatatBulan
                                            .toString(),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (values) {
                                        controller.onchangeMeterNow.value =
                                            values;
                                        controller.increment();
                                      },
                                      validator: (text) {
                                        if (text == null ||
                                            text.isEmpty ||
                                            int.parse(text) == 0) {
                                          snackBarNotificationFailed(
                                              title: "Data yang diinput salah");
                                          Get.off(CatatMeterView());
                                        } else {
                                          logger.e("error");
                                        }
                                        return null;
                                      },
                                      controller: controller.meterNowController,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Volume",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: HexColor('#707793'),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          volume.toStringAsFixed(2),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              color: HexColor('#05C270'),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: HexColor('#05C270')
                                            .withOpacity(0.2)),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: buildElevatedButtonCustom(context),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
          ),
        );
      },
    );
  }

  ElevatedButton buildElevatedButtonCustom(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (controller.meterNowController.text != '') {
            if (controller.statusDetail.value == true) {
              if (double.parse(
                      controller.meterLastManageDetailCatatBulan.value) >
                  double.parse(controller.meterNowController.text)) {
                logger.e("masuk sini");
                Get.back();
                controller.isSearch.value = false;
                snackBarNotificationFailed(
                    title: "Nilai input data tidak valid");
              } else {
                controller.isSearch.value = false;
                catatMeterBulanController.addCatatMeter();
              }
            } else {
              if (double.parse(
                      controller.meterLastManageDetailCatatBulan.value) >
                  double.parse(controller.meterNowController.text)) {
                logger.e("masuk sini");
                if (controller.meterNowController.text != '') {
                  if (controller.statusDetail.value == true) {
                    if (double.parse(
                            controller.meterLastManageDetailCatatBulan.value) >
                        double.parse(controller.meterNowController.text)) {
                      logger.e("masuk sini");
                      Get.back();
                      controller.clearCondition();
                      controller.isSearch.value = false;
                      snackBarNotificationFailed(
                          title: "Nilai input data tidak valid");
                      controller.clearCondition();
                    } else {
                      catatMeterBulanController.addCatatMeter();
                      controller.isSearch.value = false;
                      controller.clearCondition();
                    }
                  } else {
                    if (double.parse(
                            controller.meterLastManageDetailCatatBulan.value) >
                        double.parse(controller.meterNowController.text)) {
                      logger.e("masuk sini");
                      Get.back();
                      controller.clearCondition();
                      snackBarNotificationFailed(
                          title: "Nilai input data tidak valid");
                      controller.clearCondition();
                    } else {
                      catatMeterBulanController.updateCatatMeter(
                        id: controller.idManageCatatBulan.toString(),
                        meter_now: controller.meterNowManageDetailCatatBulan
                            .toString(),
                        month: controller.bulan.value,
                      );
                      controller.clearCondition();
                    }
                  }
                } else {
                  Get.back();
                  snackBarNotificationFailed(title: "Nilai input tidak valid");
                  controller.clearCondition();
                }
                Get.back();
                snackBarNotificationFailed(
                    title: "Nilai input data tidak valid");
                controller.clearCondition();
              } else {
                controller.isSearch.value = false;
                catatMeterBulanController.updateCatatMeter(
                  id: controller.idManageCatatBulan.toString(),
                  meter_now:
                      controller.meterNowManageDetailCatatBulan.toString(),
                  month: controller.bulan.value,
                );
                controller.clearCondition();
              }
            }
          } else {
            controller.isSearch.value = false;
            Get.back();
            snackBarNotificationFailed(title: "Nilai input tidak valid");
            controller.clearCondition();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0.0, 8.0),
                  color: Color.fromRGBO(0, 99, 248, 0.2),
                  blurRadius: 24,
                ),
              ],
              gradient: LinearGradient(colors: gradientColorAirren),
              borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: Center(
              child: Text(
                (controller.statusDetail.value == false) ? "Update" : "Simpan",
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
                borderRadius: BorderRadius.circular(10))));
  }
}
