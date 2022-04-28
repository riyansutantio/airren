import 'package:airen/app/model/register_model.dart';
import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';
import '../controller/report_controller.dart';
import '../provider/report_provider.dart';

class ReportView extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportController>(
      init: ReportController(p: ReportProvider()),
      builder: (controller) {
        return Scaffold(
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
                              'Pengaturan Printer',
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
                                      "Bulanan",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#FFCC00')),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Silakan pilih bulannya\n terlebih dahulu",
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
                                        HexColor('#FFCC00').withOpacity(0.15))
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: HexColor('#FFCC00')
                                          .withOpacity(0.05)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "2022",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#707793')),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            EvaIcons.arrowIosDownwardOutline,
                                            color: HexColor('#FFCC00'),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: HexColor('#FFCC00')
                                          .withOpacity(0.05)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Febuari",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#707793')),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            EvaIcons.arrowIosDownwardOutline,
                                            color: HexColor('#FFCC00'),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.getPdfMonth();
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      offset: Offset(0.0, 8.0),
                                                      color: Color.fromRGBO(
                                                          0, 99, 248, 0.2),
                                                      blurRadius: 24,
                                                    ),
                                                  ],
                                                  color: HexColor('#FFCC00'),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: SizedBox(
                                                  width: 48,
                                                  height: 48,
                                                  child: Icon(
                                                    EvaIcons
                                                        .cloudDownloadOutline,
                                                    color: HexColor('#ffffff'),
                                                  ))),
                                        )
                                      ]),
                                )
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
                      const SizedBox(
                        height: 30,
                      ),
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
                                      "Tahunan",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#05C270')),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Silakan pilih tahunnya\nterlebih dahulu",
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
                                        HexColor('#05C270').withOpacity(0.15))
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 178,
                                  decoration: BoxDecoration(
                                      color: HexColor('#FFCC00')
                                          .withOpacity(0.05)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "2022",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#707793')),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            EvaIcons.arrowIosDownwardOutline,
                                            color: HexColor('#05C270'),
                                          ),
                                        ),
                                      ]),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: BoxDecoration(
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0.0, 8.0),
                                              color: Color.fromRGBO(
                                                  0, 99, 248, 0.2),
                                              blurRadius: 24,
                                            ),
                                          ],
                                          color: HexColor('#05C270'),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SizedBox(
                                          width: 48,
                                          height: 48,
                                          child: Icon(
                                            EvaIcons.cloudDownloadOutline,
                                            color: HexColor('#ffffff'),
                                          ))),
                                )
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
                      )
                    ],
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
            ));
      },
    );
  }

  // Widget settingPast() {
  //   return Scaffold(
  //     key: _scaffoldKey,
  //     appBar: AppBar(
  //         title: const Text(
  //           'Setting Printer',
  //           style: const TextStyle(
  //               fontWeight: FontWeight.w600,
  //               color: Colors.white,
  //               fontSize: 16.0),
  //         ),
  //         backgroundColor: Colors.lightBlue,
  //         leading: IconButton(
  //           icon: const Icon(Icons.arrow_back),
  //           color: Colors.white,
  //           onPressed: () {
  //             back();
  //           },
  //         )),
  //     body: Container(
  //       width: MediaQuery.of(context).size.width,
  //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
  //       child: Form(
  //         key: formkey,
  //         child: ListView(
  //           children: <Widget>[
  //             Column(
  //               children: <Widget>[
  //                 const SizedBox(
  //                   height: 10.0,
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     RaisedButton(
  //                       color: Colors.green,
  //                       onPressed: () {
  //                         AppSettings.openBluetoothSettings();
  //                       },
  //                       child: const Text(
  //                         'Nyalakan Bluetooth',
  //                         style: const TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                     const Text('Auto Connect'),
  //                     Switch(
  //                       value: isSwitched,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           isSwitched = value;
  //                           if (value == false) {
  //                             pConnected = 0;
  //                           } else {
  //                             pConnected = 1;
  //                           }
  //                         });
  //                       },
  //                       activeTrackColor: Colors.lightGreenAccent,
  //                       activeColor: Colors.green,
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   padding:
  //                       const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
  //                   child: const Text('Pilih Bluetooth Device Printer'),
  //                 ),
  //                 Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisSize: MainAxisSize.max,
  //                     children: <Widget>[
  //                       SafeArea(
  //                         top: false,
  //                         left: false,
  //                         right: false,
  //                         bottom: false,
  //                         child: Container(
  //                           child:
  //                         ),
  //                       ),
  //                     ]),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 Container(
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: <Widget>[],
  //                   ),
  //                 ),
  //                 Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: <Widget>[
  //                     RaisedButton(
  //                       color: Colors.brown,
  //                       onPressed: () {

  //                       },
  //                       child: const Text(
  //                         'Refresh',
  //                         style: const TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                     // SizedBox(
  //                     //   width: 20,
  //                     // ),

  //                     RaisedButton(
  //                       color: _connected ? Colors.red : Colors.green,
  //                       onPressed: s
  //                       child: Text(
  //                         _connected ? 'Disconnect' : 'Connect',
  //                         style: const TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                     // SizedBox(
  //                     //   width: 20,
  //                     // ),
  //                     RaisedButton(
  //                       color: Colors.blue,
  //                       onPressed: () {

  //                       },
  //                       child: const Text(
  //                         'Simpan Printer',
  //                         style: const TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 Container(
  //                   padding:
  //                       const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
  //                   child: const Center(
  //                     child: Text(
  //                         'Jika auto connect di gunakan, Bluetooth Device dan Printer harus menyala !'),
  //                   ),
  //                 ),
  //                 Container(
  //                   padding:
  //                       const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
  //                   child: Center(
  //                     child:
  //                         Text(_connected ? 'Connected to ' + nameDevice : ''),
  //                   ),
  //                 ),
  //                 Container(
  //                   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
  //                   child: Center(
  //                     child: Text(
  //                         _connected ? 'Connected to ' + addressDevice : ''),
  //                   ),
  //                 ),
  //                 Container(
  //                   width: double.infinity,
  //                   padding:
  //                       const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
  //                   child: RaisedButton(
  //                     color: Colors.green,
  //                     onPressed: () {
  //                       _appPrint!.testPrint();
  //                     },
  //                     child: const Text('Test ReportView',
  //                         style: TextStyle(color: Colors.white)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
