import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/detail_catat_meter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';

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
            body: WillPopScope(
              onWillPop: () =>
                  willPopWithFuncOnly(func: controller.closeSearchAppBar()),
              child: Container(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: (controller.isSearch.value == true)
                        ? searchNoFound(controller, context)
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
                    // child: (controller.catatMeterresult.isEmpty)
                    //     ? noDataFound()
                    //     : (controller.isSearch.value == false)
                    //         ? PelangganBuilder(controller) //false
                    //         : searchPelanggan(context, controller), //true
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
            ),
          ),
        );
      },
    );
  }

  Column searchNoFound(CatatMeterController controller, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white),
          child: (controller.cusUserResult.isEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                )
              : ListView.builder(
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
                          Get.to(DetailCatatMeter());
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
                                          child: Text('1',
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
      ],
    );
  }

  Expanded searchPelanggan(
      BuildContext context, CatatMeterController controller) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: (controller.cusUserResult.isEmpty)
            ? Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (controller.isSearch.value)
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: SvgPicture.asset('assets/searchnofound.svg'),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: SvgPicture.asset('assets/tarifkosong.svg'),
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          'Belum ada tagihan yang sesuai dengan \n kata kunci di atas.',
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
            : ListView.builder(
                itemCount: controller.cusUserResult.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.statusDetail.value = true;
                        controller.uniqueIdManageDetailCatatBulan.value =
                            controller.cusUserResult[index].uniqueId!;
                        controller.meterNowManageDetailCatatBulan.value =
                            0.toString();
                        Get.to(DetailCatatMeter());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 16.0),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: ListTile(
                              dense: false,
                              title: Text(
                                controller.cusUserResult[index].name.toString(),
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
                                    color: HexColor('#707793').withOpacity(0.7),
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
                                      child:
                                          SvgPicture.asset('assets/meter.svg'),
                                    ),
                                    Flexible(
                                      child: SizedBox(
                                        child: Text('1',
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
                            catatMeterBulanController.deleteMeterBulan();
                            logger.e(controller.idManageCatatBulan.value);
                          }
                        },
                        itemBuilder: (BuildContext ctx) => [
                          PopupMenuItem(
                              child: Row(
                                children: [
                                  const Text('Hapus Bulan'),
                                  const SizedBox(
                                    width: 8,
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
                padding: const EdgeInsets.fromLTRB(15, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: GestureDetector(
                        onTap: () {
                          controller.isSearch.value = true;
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 15, 15, 10),
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
                      onTap: () => controller.scanQR(),
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

  ListView PelangganBuilder(CatatMeterController controller) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: controller.catatMeterresult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        int? now = int.parse(controller.catatMeterresult[index].meter_now!);
        int? last = int.parse(controller.catatMeterresult[index].meter_last!);
        int volume = now - last;
        return GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                                GestureDetector(
                                  onTap: () {
                                    controller.statusDetail.value = false;
                                    controller.bulan.value = int.parse(
                                        controller.catatMeterresult[index]
                                            .meter_month_of!);
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
                                    controller.meterNowManageDetailCatatBulan
                                            .value =
                                        controller
                                            .catatMeterresult[index].meter_now!;
                                    controller.meterLastManageDetailCatatBulan
                                            .value =
                                        controller.catatMeterresult[index]
                                            .meter_last!;
                                    Get.to(DetailCatatMeter());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child:
                                        SvgPicture.asset("assets/editPen.svg"),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: SvgPicture.asset("assets/options.svg"),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange,
                                  ),
                                ),
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
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                children: [
                                  Text(
                                    "Awal",
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
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                children: [
                                  Text(
                                    "Akhir",
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
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04,
                                  MediaQuery.of(context).size.width * 0.06,
                                  MediaQuery.of(context).size.width * 0.04),
                              child: Column(
                                children: [
                                  Text(
                                    "Volume",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: HexColor('#707793'),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    volume.toString(),
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
                controller.searchValue.value = '';
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
                textInputType: TextInputType.text,
                hintText: 'Cari pelanggan ',
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
