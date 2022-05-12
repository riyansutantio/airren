import 'package:airen/app/model/catat_meter/add_catat_meter_bulan_model.dart';
import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/catat_meter_bulan_view.dart';
import 'package:airen/app/modules/catat_meter/views/monthPicker.dart';
import 'package:airen/app/modules/home/views/home_view.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../error_handling/views/error_handling_view.dart';

class CatatMeterView extends GetView<CatatMeterController> {
  final CatatMeterController catatMeterBulanController =
      Get.put(CatatMeterController(catatmeterProvider: CatatMeterProvider()));
  @override
  Widget build(BuildContext context) {
    DateTime? selectedDate;
    DateTime raw = DateTime(now.year);
    String year = DateFormat('yyyy').format(raw).toString();
    // TODO: implement build
    return GetBuilder<CatatMeterController>(
      init: CatatMeterController(catatmeterProvider: CatatMeterProvider()),
      builder: (controller) {
        return Obx(
          () =>  Scaffold(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.offNamed('/home');
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  'Catat Meter',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.to(ErrorHandlingView());
                                  },
                                  child: const Icon(EvaIcons.bellOutline,
                                      color: Colors.white)),
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
                preferredSize: Size.fromHeight(Get.height * 0.1),
              ),
              body: Container(
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Colors.white),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        //listview bulan
                        Expanded(
                          child: (controller.meterMonthResult.isEmpty)
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
                                          'Tambahkan bulan terlebih dahulu\n kemudian baru lakukan pencatatan pada setiap\n pelanggan',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          )),
                                    ),
                                  ],
                                )
                              : Obx(
                                  () =>
                                      //listViewBuilder(controller, year)
                                      StickyGroupedListView<MonthMeterResult,
                                          DateTime>(
                                    order: StickyGroupedListOrder.DESC,
                                    elements: controller.meterMonthResult.value,
                                    groupBy: (MonthMeterResult element) =>
                                        DateTime(
                                      element.year_of!,
                                    ),
                                    itemComparator: (MonthMeterResult element1,
                                            MonthMeterResult element2) =>
                                        element1.month_of!
                                            .compareTo(element2.month_of!),
                                    floatingHeader: true,
                                    groupSeparatorBuilder:
                                        (MonthMeterResult element) => Container(
                                      height: 50,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              controller.now.value.year ==
                                                      element.year_of
                                                  ? 'Tahun Sekarang'
                                                  : 'Tahun ${element.year_of}',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: HexColor('#0063F8')
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder:
                                        (context, MonthMeterResult element) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 16.0,
                                              right: 16.0),
                                          child: Card(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(16)),
                                            ),
                                            elevation: 8.0,
                                            child: GestureDetector(
                                              onTap: () {
                                                controller.idManageCatatBulan
                                                    .value = element.id!;
                                                controller.bulan.value =
                                                    element.id!;
                                                logger
                                                    .d(controller.bulan.value);
                                                catatMeterBulanController
                                                    .getCatatMeter();
                                                controller
                                                    .judul.value = penentuBulan(
                                                            element.month_of)
                                                        .toString() +
                                                    " " +
                                                    element.year_of.toString();
                                                Get.to(CatatBulanView());
                                              },
                                              child: Container(
                                                child: ListTile(
                                                  leading: element
                                                              .number_of_recorded_consumer!
                                                              .toInt() ==
                                                          element
                                                              .number_of_consumer!
                                                              .toInt()
                                                      ? CircleAvatar(
                                                          maxRadius: 30,
                                                          backgroundColor:
                                                              HexColor('#05C270')
                                                                  .withOpacity(
                                                                      0.1),
                                                          child: Icon(
                                                            EvaIcons.checkmark,
                                                            color: HexColor(
                                                                '#05C270'),
                                                          ))
                                                      : element.month_of ==
                                                              DateTime.now()
                                                                  .month
                                                          ? CircleAvatar(
                                                              maxRadius: 30,
                                                              backgroundColor:
                                                                  HexColor(
                                                                          '#FF8801')
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Icon(
                                                                EvaIcons
                                                                    .clockOutline,
                                                                color: HexColor(
                                                                    '#FF8801'),
                                                              ),
                                                            )
                                                          : CircleAvatar(
                                                              maxRadius: 30,
                                                              backgroundColor:
                                                                  HexColor(
                                                                          '#FF3B3B')
                                                                      .withOpacity(
                                                                          0.1),
                                                              child: Icon(
                                                                EvaIcons
                                                                    .alertTriangleOutline,
                                                                color: HexColor(
                                                                    '#FF3B3B'),
                                                              )),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        monthsAll[
                                                            element.month_of! -
                                                                1],
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: HexColor(
                                                              '#3C3F58'),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: GestureDetector(
                                                          onTap: () => {},
                                                          child: Icon(
                                                            EvaIcons
                                                                .arrowForward,
                                                            color: HexColor(
                                                                '#FFCC00'),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle:  Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child:  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          element.number_of_recorded_consumer
                                                                  .toString() +
                                                              ' dari ${element.number_of_consumer} pelanggan',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: HexColor(
                                                                          '#707793')
                                                                      .withOpacity(
                                                                          0.7)),
                                                        ),
                                                          Text(
                                                          element.total_water_usage
                                                                  .toString()+' M3',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: HexColor(
                                                                          '#707793')
                                                                      .withOpacity(
                                                                          0.7)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),
                      ],
                    )),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  customMonthPicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
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
            ),
          
        );
      },
    );
  }
}

penentuBulan(index) {
  List<String> bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  return bulan[index - 1];
}
