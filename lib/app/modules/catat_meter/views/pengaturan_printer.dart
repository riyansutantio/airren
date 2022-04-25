import 'package:airen/app/model/catat_meter/add_catat_meter_bulan_model.dart';
import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/modules/catat_meter/controllers/catat_meter_controller.dart';
import 'package:airen/app/modules/catat_meter/provider/catat_meter_provider.dart';
import 'package:airen/app/modules/catat_meter/views/catat_meter_bulan_view.dart';
import 'package:airen/app/modules/catat_meter/views/month_picker.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_list_view/group_list_view.dart';
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
        return Obx(
          () => Scaffold(
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
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Column(
                    children: [],
                  )),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
            ),
          ),
        );
      },
    );
  }
}
