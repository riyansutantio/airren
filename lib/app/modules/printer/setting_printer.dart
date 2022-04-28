import 'package:airen/app/model/register_model.dart';
import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../model/invoice_pam.dart';
import '../../model/meter_transactionAll_model.dart';
import '../error_handling/views/error_handling_view.dart';
import '../payment/providers/payment_providers.dart';
import 'controller/print_controller.dart';

class Print extends GetView<PrintController> {
  Print(
      {this.pam,
      this.tm,
      this.result,
      this.fee,
      this.totalPrice,
      this.phoneNumber,
      this.charge,
      this.resultTotal});
  final Pam? pam;
  final TransactionAllModel? tm;
  final List<CostDetail>? result;
  final int? totalPrice;
  final int? fee;
  final int? charge;
  final int? resultTotal;
  final String? phoneNumber;

  CatatMeterController? catatmeter;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrintController>(
      init: PrintController(p: PaymentProviders()),
      builder: (controller) {
        return Obx(() => Scaffold(
              key: controller.scaffoldKey,
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
                                onPressed: () {
                                  Get.back();
                                  catatmeter?.clearCondition();
                                },
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      EvaIcons.bluetoothOutline,
                                      color: HexColor('#0063F8'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Bluetooth",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: HexColor('#3C3F58')),
                                    ),
                                  )
                                ],
                              ),
                              ClipOval(
                                  child: Material(
                                color: HexColor('#05C270'), // Button color
                                child: InkWell(
                                  splashColor: Colors.white, // Splash color
                                  onTap: () {
                                    AppSettings.openBluetoothSettings();
                                  },
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: Center(
                                      child: Text(
                                        "On",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      EvaIcons.radio,
                                      color: HexColor('#0063F8'),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Auto Connect",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: HexColor('#3C3F58')),
                                        ),
                                      ),
                                      Text(
                                        "Jika auto connect digunakan,\nbluetooth dan printer harus\nkeadaan menyala!",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: HexColor('#707793')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Switch(
                                value: controller.isSwitched.value,
                                onChanged: (value) {
                                  controller.isSwitched.value = value;
                                  if (value == false) {
                                    controller.pConnected!.value = 0;
                                  } else {
                                    controller.pConnected!.value = 1;
                                  }
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      EvaIcons.printerOutline,
                                      color: HexColor('#0063F8'),
                                    ),
                                  ),
                                  Form(
                                    key: controller.formkey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Device",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: HexColor('#3C3F58')),
                                          ),
                                        ),
                                        Text(
                                          "Silakan pilih printernya\nterlebih dahulu",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor('#707793')),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              96,
                                          height: 48,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: HexColor('#0063F8')
                                                  .withOpacity(0.7)),
                                          child:
                                              DropdownButton<BluetoothDevice?>(
                                            underline: SizedBox(),
                                            hint: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Select',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            isExpanded: true,
                                            items: controller.getDeviceItems(),
                                            onChanged: (value) {
                                              controller.device.value = value!;
                                              print(controller.device.value);
                                            },
                                            value: controller.device.value,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              96,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                child: const SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      EvaIcons.refreshOutline,
                                                      color: Colors.white,
                                                    )),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                Color>(HexColor(
                                                                    '#FFCC00')
                                                                .withOpacity(
                                                                    0.3)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ))),
                                                onPressed: () {
                                                  controller
                                                      .scaffoldKey.currentState!
                                                      .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 2),
                                                    content: Row(
                                                      children: <Widget>[
                                                        CircularProgressIndicator(),
                                                        Text("  Refresh...")
                                                      ],
                                                    ),
                                                  ));
                                                  controller
                                                      .initPlatformState();
                                                },
                                              ),
                                              ElevatedButton(
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      290,
                                                  height: 30,
                                                  child: const Center(
                                                    child: Text("Connect",
                                                        style: TextStyle(
                                                            fontSize: 14)),
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                Color>(HexColor(
                                                                    '#05C270')
                                                                .withOpacity(
                                                                    0.3)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ))),
                                                onPressed:
                                                    controller.connected!.value
                                                        ? controller.disconnect
                                                        : controller.connect,
                                              ),
                                              ElevatedButton(
                                                child: const SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      EvaIcons.checkmark,
                                                      color: Colors.white,
                                                    )),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<
                                                                Color>(HexColor(
                                                                    '#0063F8')
                                                                .withOpacity(
                                                                    0.3)),
                                                    shape: MaterialStateProperty
                                                        .all<RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ))),
                                                onPressed: () {
                                                  controller.savePrint(
                                                      controller
                                                          .addressDevice!.value,
                                                      controller
                                                          .nameDevice!.value);
                                                  controller.updatePrint();
                                                  print(controller
                                                          .addressDevice!
                                                          .value +
                                                      ' ' +
                                                      controller
                                                          .nameDevice!.value);
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 31,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  controller.tesPrint(
                                      result: result,
                                      tm: tm,
                                      totalPrice: totalPrice,
                                      fee: fee,
                                      charge: charge,
                                      totalResult: resultTotal,
                                      phoneNumber: phoneNumber,
                                      pam: pam);
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.2),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      color: HexColor('#FF8801'),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    height: 48,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text(
                                        'Cetak sekarang',
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
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
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
  //                     child: const Text('Test Print',
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
