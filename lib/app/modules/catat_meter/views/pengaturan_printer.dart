import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';

class PengaturanPrinter extends GetView<CatatMeterController> {
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
                          GestureDetector(
                            onTap: () {
                              Get.back();
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
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.bluetooth,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "Bluetooth",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Switch(
                                  value: controller.switchBluetooth.value,
                                  onChanged: (val) => catatMeterBulanController
                                      .toggleBluetooth(),
                                  activeColor: Colors.green,
                                  activeTrackColor:
                                      Colors.green.withOpacity(0.5),
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor:
                                      Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Divider(
                            indent: MediaQuery.of(context).size.width * 0.15,
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.wifi,
                                    color: Colors.blue,
                                    size: 30.0,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Auto Connect",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Jika auto connect digunakan, bluetooth dan printer harus dalam keadaan menyala!",
                                            maxLines: 4,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => Switch(
                                  value: controller.switchAutoConnect.value,
                                  onChanged: (val) =>
                                      catatMeterBulanController.toggleAuto(),
                                  activeColor: Colors.green,
                                  activeTrackColor:
                                      Colors.green.withOpacity(0.5),
                                  inactiveThumbColor: Colors.white,
                                  inactiveTrackColor:
                                      Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Divider(
                            indent: MediaQuery.of(context).size.width * 0.15,
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.print,
                                color: Colors.blue,
                                size: 30.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Auto Connect",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Silakan pilih printernya terlebih dahulu",
                                        maxLines: 4,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            DropdownButton<BluetoothDevice>(
                                value: controller.selectedDevice,
                                hint: const Text("Select Thermal Printer"),
                                onChanged: (device) {
                                  controller.selectedDevice = device;
                                },
                                items: controller.device
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name!),
                                          value: e,
                                        ))
                                    .toList()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  width: 55,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: SvgPicture.asset('assets/reset.svg'),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    elevation: 0,
                                    primary:
                                        HexColor('#FFCC00').withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // controller.printer
                                    //     .connect(controller.selectedDevice!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 10),
                                    child: Text(
                                      "Connect",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    elevation: 0,
                                    primary:
                                        HexColor('#05C270').withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 10, 15, 10),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Colors.white,
                                    elevation: 0,
                                    primary:
                                        HexColor('#0063F8').withOpacity(0.1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Divider(
                            indent: MediaQuery.of(context).size.width * 0.15,
                            color: Colors.grey,
                            height: 1,
                            thickness: 1,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: HexColor('#FF8801'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Text(
                                "Cetak Sekarang",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
          ),
        );
      },
    );
  }
}
