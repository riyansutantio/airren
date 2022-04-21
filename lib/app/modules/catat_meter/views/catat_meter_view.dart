import 'package:airen/app/model/catat_meter/add_catat_meter_bulan_model.dart';
import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/month_picker.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../error_handling/views/error_handling_view.dart';

class CatatMeterView extends GetView<CatatMeterController> {
  final CatatMeterController catatMeterBulanController =
      Get.put(CatatMeterController(catatmeterProvider: CatatMeterProvider()));
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<CatatMeterController>(
      init: CatatMeterController(catatmeterProvider: CatatMeterProvider()),
      builder: (controller) {
        return Scaffold(
          appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //listview bulan
                    Center(
                      child: (controller.meterMonthResult.isEmpty)
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40.0),
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
                                  child: Text('Tambahkan bulan terlebih dahulu',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#707793')
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      'kemudian baru lakukan pencatatan pada setiap',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#707793')
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('pelanggan.',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#707793')
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      )),
                                ),
                              ],
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.only(top: 10),
                              itemCount: controller.meterMonthResult.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10.0, right: 10.0),
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0.0, 8.0),
                                            color: Color.fromRGBO(
                                                0, 99, 248, 0.16),
                                            blurRadius: 24,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        color: Colors.white),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(10),
                                      dense: false,
                                      title: Text(
                                        penentuBulan(controller
                                                .meterMonthResult[index]
                                                .month_of) +
                                            " " +
                                            controller
                                                .meterMonthResult[index].year_of
                                                .toString(),
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          "0 dari 18 pelanggan",
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793')
                                                .withOpacity(0.7),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      leading: CircleAvatar(
                                        maxRadius: 30,
                                        //background leading pict ada 3 jenis clear, touble, masalah
                                        backgroundColor:
                                            HexColor('#FF801').withOpacity(0.1),
                                        // child: Icon(icon),
                                      ),
                                      trailing: GestureDetector(
                                        onTap: () => {},
                                        child: Icon(
                                          EvaIcons.arrowForward,
                                          color: HexColor('#FFCC00'),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
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
              DatePicker.showPicker(
                context,
                pickerModel: CustomMonthPicker(
                  minTime: DateTime(2020, 1, 1),
                  maxTime: DateTime.now(),
                  currentTime: DateTime.now(),
                ),
                theme: DatePickerTheme(
                    headerColor: HexColor('#FFCC00'),
                    backgroundColor: Colors.white,
                    itemStyle: TextStyle(
                        color: HexColor('#0063F8'),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    doneStyle:
                        const TextStyle(color: Colors.white, fontSize: 16)),
                onConfirm: (dates) {
                  var yearRaw = DateFormat('yyyy').format(dates);
                  var monthRaw = DateFormat('MM').format(dates);
                  int year = int.parse(yearRaw);
                  int month = int.parse(monthRaw);
                  controller.month_Of.value = month;
                  controller.year_Of.value = year;
                  logger.d(year.toString() + "-" + month.toString());
                  //penentuBulan(month);
                  catatMeterBulanController.addCatatMeterBulan();
                },
                onChanged: (dates) {
                  // var yearRaw = DateFormat('yyyy').format(dates);
                  // var monthRaw = DateFormat('MM').format(dates);
                  // int year = int.parse(yearRaw);
                  // int month = int.parse(monthRaw);
                  // logger.i(month.toString() + "-" + year.toString());
                },
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
