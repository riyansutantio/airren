import 'package:airen/app/modules/catat_meter/views/catat_meter_view.dart';
import 'package:airen/app/modules/catat_meter/views/invoice_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/detail_catat_meter.dart';

import '../../../utils/utils.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../../payment/controllers/payment_invoice_controller.dart';
import '../../printer/setting_printer.dart';

class CatatBulanView extends GetView<CatatMeterController> {
  final CatatMeterController catatMeterBulanController =
      Get.put(CatatMeterController(catatmeterProvider: CatatMeterProvider()));
  // CatatBulanView({required this.bulan});
  // int? bulan;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CatatMeterController>(
      init: CatatMeterController(catatmeterProvider: CatatMeterProvider()),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            appBar: (controller.isSearch.value)
                ? buildAppBarSearch(context, controller)
                : BuildCatatMeterApp(context, controller),
            body: Stack(
              children: [
                WillPopScope(
                  onWillPop: () =>
                      willPopWithFuncOnly(func: controller.closeSearchAppBar()),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: (controller.isSearch.value == true)
                            ? Obx(() => searchNoFound(controller, context))
                            : (controller.catatMeterresult.isEmpty)
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 40.0),
                                        child: SvgPicture.asset(
                                            'assets/belumadapencatatan.svg'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Text('Belum ada data Pencatatan',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                            'Tambahkan pencatatandengan mencari \n data pelanggannya terlebih dahulu.',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793')
                                                  .withOpacity(0.7),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            )),
                                      )
                                    ],
                                  )
                                : PelangganBuilder(controller),
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      HexColor('#5433FF'),
                      HexColor('#0063F8')
                    ])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container searchNoFound(
      CatatMeterController controller, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white),
      child: (controller.cusUserResult.isEmpty)
          ? Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: SvgPicture.asset('assets/searchnofound.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text('Tidak ditemukan',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        'Belum ada tagihan yang sesuai dengan \n kata kunci',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: HexColor('#707793').withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
              ),
            )
          : Obx(
              () => ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.cusUserResult.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          controller.statusDetail.value = true;
                          controller.uniqueIdManageDetailCatatBulan.value =
                              controller.cusUserResult[index].uniqueId!;
                          controller.meterNowManageDetailCatatBulan.value =
                              0.toString();
                          controller.meterLastManageDetailCatatBulan.value =
                              controller.cusUserResult[index].meter!;
                          controller.nameManageDetailCatatBulan.value =
                              controller.cusUserResult[index].name!;
                          controller.addressManageDetailCatatBulan.value =
                              controller.cusUserResult[index].address!;
                          controller.idBulanLalu.value =
                              controller.cusUserResult[index].id!;
                          logger.e(controller.idBulanLalu.value);
                          controller.getBulanLalu();
                          Get.to(() => DetailCatatMeter());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 16.0, right: 16.0),
                          child: Container(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: ListTile(
                                dense: false,
                                title: Text(
                                  controller.cusUserResult[index].name
                                      .toString(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      HexColor('#0063F8').withOpacity(0.1),
                                  maxRadius: 25,
                                  child: Text(
                                    controller.getInitials(controller
                                        .cusUserResult[index].name
                                        .toString()),
                                    style: GoogleFonts.montserrat(
                                      color: Colors.blue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    controller.cusUserResult[index].uniqueId
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      color:
                                          HexColor('#707793').withOpacity(0.7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset(
                                            'assets/meter.svg'),
                                      ),
                                      Flexible(
                                        child: SizedBox(
                                          child: Text(
                                              controller
                                                  .cusUserResult[index].meter
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.montserrat(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              )),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.amber,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.0, 8.0),
                                    color: Color.fromRGBO(0, 99, 248, 0.16),
                                    blurRadius: 24,
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16)),
                                color: Colors.white),
                          ),
                        ),
                      )),
            ),
    );
  }

  Column noDataFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: SvgPicture.asset('assets/belumadapencatatan.svg'),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Belum ada data Pencatatan',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
              'Tambahkan pencatatandengan mencari \n data pelanggannya terlebih dahulu.',
              style: GoogleFonts.montserrat(
                color: HexColor('#707793').withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.normal,
              )),
        )
      ],
    );
  }

  PreferredSize BuildCatatMeterApp(
      BuildContext context, CatatMeterController controller) {
    return PreferredSize(
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
                          onPressed: () => Get.back(),
                          icon: const Icon(EvaIcons.arrowBack),
                          color: Colors.white),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          controller.judul.value,
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
                      PopupMenuButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        padding: const EdgeInsets.only(right: 8),
                        icon: const Icon(EvaIcons.moreVertical,
                            color: Colors.white),
                        onSelected: (String selectedValue) {
                          print(selectedValue);
                          if (selectedValue == '1') {
                            controller.deleteState.value = true;
                          }
                          (controller.deleteState.value == true)
                              ? modalDeleteAlert(context, controller)
                              : Container();
                        },
                        itemBuilder: (BuildContext ctx) => [
                          PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Hapus Bulan',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Icon(
                                    EvaIcons.trashOutline,
                                    color: HexColor('#FF3B3B'),
                                  )
                                ],
                              ),
                              value: '1'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 18, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: GestureDetector(
                        onTap: () {
                          controller.isSearch.value = true;
                          controller.increment();
                          controller.cusUserResult.refresh();
                          controller.getCusUsers();
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 15, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cari pelanggan",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(0),
                                child: Icon(
                                  EvaIcons.search,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.scanQR();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(0.8),
                        child: SvgPicture.asset("assets/qrCam.svg"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
            boxShadow: const []),
      ),
      preferredSize: Size.fromHeight(Get.height * 0.2),
    );
  }

  Future<dynamic> modalDeleteAlert(
      BuildContext context, CatatMeterController controller) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white.withOpacity(0.0),
          constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.3),
          height: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(150, 20, 150, 20),
                child: Container(
                  height: 6,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                child: SvgPicture.asset('assets/deleteAlert.svg'),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Anda yakin?',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                    'Data akan dihapus secara permanen. \n Benarkah ingin menghapusnya?',
                    style: GoogleFonts.montserrat(
                      color: HexColor('#707793').withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.deleteState.value = false;
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                        child: Text(
                          "batal",
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.white,
                        elevation: 0,
                        primary: Colors.blue.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.deleteState.value = false;
                        logger.e(controller.idManageCatatBulan.value);
                        controller.deleteMeterBulan();
                        controller.meterMonthResult.refresh();
                        Get.offAll(CatatMeterView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                        child: Text(
                          "Ya, hapus",
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.white,
                        elevation: 0,
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ListView PelangganBuilder(CatatMeterController controller) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: controller.catatMeterresult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        double? now =
            double.parse(controller.catatMeterresult[index].meter_now!);
        double? last =
            double.parse(controller.catatMeterresult[index].meter_last!);
        double volume = now - last;
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                    controller
                                        .catatMeterresult[index].consumer_name
                                        .toString(),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    )),
                              ),
                              Text(
                                  controller.catatMeterresult[index]
                                      .consumer_unique_id
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  controller.catatMeterresult[index]
                                      .consumer_full_address
                                      .toString(),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (controller.catatMeterresult[index]
                                          .is_published ==
                                      false) {
                                    controller.statusDetail.value = false;
                                    controller.idManageDetailCatatBulan.value =
                                        controller.catatMeterresult[index].id
                                            .toString();
                                    controller
                                            .nameManageDetailCatatBulan.value =
                                        controller.catatMeterresult[index]
                                            .consumer_name
                                            .toString();
                                    controller.uniqueIdManageDetailCatatBulan
                                            .value =
                                        controller.catatMeterresult[index]
                                            .consumer_unique_id!;
                                    controller.alamatManageDetailCatatBulan
                                            .value =
                                        controller.catatMeterresult[index]
                                            .consumer_full_address!;
                                    controller.onchangeMeterNow.value =
                                        controller
                                            .catatMeterresult[index].meter_now!;
                                    controller.meterNowManageDetailCatatBulan
                                            .value =
                                        controller
                                            .catatMeterresult[index].meter_now!
                                            .toString();
                                    controller.meterBulanLalu.value =
                                        double.parse(controller
                                            .catatMeterresult[index]
                                            .meter_last!);
                                    controller.meterLastManageDetailCatatBulan
                                            .value =
                                        controller.catatMeterresult[index]
                                            .meter_last!;
                                    Get.to(() => DetailCatatMeter());
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: SvgPicture.asset('assets/editPen.svg'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                  primary: (controller.catatMeterresult[index]
                                              .is_published ==
                                          false)
                                      ? Colors.blue
                                      : Colors.blue.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              PopupMenuButton(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child:
                                        SvgPicture.asset("assets/options.svg"),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange,
                                    ),
                                  ),
                                  onSelected: (String selectedValue) {
                                    print(selectedValue);
                                    if (selectedValue == '1') {
                                      controller.meterLastManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .meter_last!;
                                      controller.meterNowManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .meter_now!;
                                      controller.uniqueIdManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .consumer_unique_id!;
                                      controller.nameManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .consumer_name!;
                                      controller.addressManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .consumer_full_address!;
                                      controller
                                              .phoneNumberManageDetailCatatBulan
                                              .value =
                                          controller.catatMeterresult[index]
                                              .consumer_phone_number!;
                                      showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            color:
                                                Colors.white.withOpacity(0.0),
                                            height: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          150, 20, 150, 20),
                                                  child: Container(
                                                    height: 6,
                                                    width: 70,
                                                    decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20.0,
                                                          top: 20.0),
                                                  child: SvgPicture.asset(
                                                      'assets/confirmDelete.svg'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Text('Konfirmasi',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      'Tagihan yang sudah diterbitkan, \n posisi meter tidak bisa diubah lagi.',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: HexColor(
                                                                '#707793')
                                                            .withOpacity(0.7),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          controller
                                                              .statusTagihan
                                                              .value = false;
                                                          Get.back();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  25,
                                                                  15,
                                                                  25,
                                                                  15),
                                                          child: Text(
                                                            "batal",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shadowColor:
                                                              Colors.white,
                                                          elevation: 0,
                                                          primary: Colors.blue
                                                              .withOpacity(0.1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          controller
                                                              .statusTagihan
                                                              .value = true;
                                                          controller
                                                              .addTagihan();
                                                          Get.back();
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  25,
                                                                  15,
                                                                  25,
                                                                  15),
                                                          child: Text(
                                                            "Ya, benar",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shadowColor:
                                                              Colors.white,
                                                          elevation: 0,
                                                          primary: Colors.blue,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      Get.to(InvoiceViews(
                                        id: controller.bulan.value,
                                        idInvoice: controller
                                            .catatMeterresult[index]
                                            .meter_transaction_id,
                                        name: controller
                                            .nameManageDetailCatatBulan.value,
                                      ));
                                    }
                                  },
                                  itemBuilder: (BuildContext ctx) => [
                                        PopupMenuItem(
                                            enabled: (controller
                                                        .catatMeterresult[index]
                                                        .is_published ==
                                                    false)
                                                ? true
                                                : false,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Terbitkan Tagihan'),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                SvgPicture.asset((controller
                                                            .catatMeterresult[
                                                                index]
                                                            .is_published ==
                                                        false)
                                                    ? 'assets/terbitkanTagihan.svg'
                                                    : 'assets/terbitkanTagihanFalse.svg'),
                                              ],
                                            ),
                                            value: '1'),
                                        PopupMenuItem(
                                            enabled: (controller
                                                        .catatMeterresult[index]
                                                        .is_published ==
                                                    false)
                                                ? false
                                                : true,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text('Print tagihan'),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                SvgPicture.asset((controller
                                                            .catatMeterresult[
                                                                index]
                                                            .is_published ==
                                                        false)
                                                    ? 'assets/printTagihanFalse.svg'
                                                    : 'assets/printTagihan.svg'),
                                              ],
                                            ),
                                            value: '2'),
                                      ])
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                    MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                children: [
                                  Text(
                                    "Awal",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
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
                                    controller
                                        .catatMeterresult[index].meter_last
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: HexColor('#6500CD'),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: HexColor('#6500CD').withOpacity(0.2)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                children: [
                                  Text(
                                    "Akhir",
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
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
                                    controller.catatMeterresult[index].meter_now
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: HexColor('#05C270'),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: HexColor('#05C270').withOpacity(0.2)),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04),
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
                                        color: HexColor('#FF8801'),
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: HexColor('#FF8801').withOpacity(0.2)),
                            ),
                          ),
                        ],
                      ),
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
        );
      },
    );
  }
}

PreferredSize buildAppBarSearch(
    BuildContext context, CatatMeterController controller) {
  return PreferredSize(
    child: Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.isSearch.value = false;
                controller.searchValue.value = '';
                controller.increment();
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
                  controller.increment();
                  return null;
                },
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(EvaIcons.search),
                ),
                textInputType: TextInputType.text,
                hintText: 'Nama atau nopel',
                obscureText: false,
                passwordVisibility: false,
                controller: controller,
                textEditingController: controller.searchController,
                returnValidation: (val) {
                  if (val!.isEmpty) {
                    return "Pelanggan tidak ditemukan";
                  }
                  return null;
                },
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
            ))
          ],
        ),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
          boxShadow: const []),
    ),
    preferredSize: Size.fromHeight(Get.height * 0.2),
  );
}
