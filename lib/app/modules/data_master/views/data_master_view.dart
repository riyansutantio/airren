import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:airen/app/modules/data_master/views/add_base_fee_view.dart';
import 'package:airen/app/modules/data_master/views/add_pam_manage_view.dart';
import 'package:airen/app/modules/data_master/views/base_fee_detail_view.dart';
import 'package:airen/app/modules/data_master/views/pam_manage_detail_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/data_master_controller.dart';

class DataMasterView extends GetView<DataMasterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataMasterController>(
      init: DataMasterController(masterDataProvider: MasterDataProvider()),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: PreferredSize(
                child: Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Master data',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/notif.png',
                              width: 24,
                            ),
                            const SizedBox(width: 20),
                            const Icon(
                              EvaIcons.search,
                              color: Colors.white,
                              size: 24,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
                ),
                preferredSize: Size.fromHeight(Get.height * 0.1),
              ),
              body: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toPengelola();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const SizedBox(),
                                SvgPicture.asset(
                                    'assets/${controller.masterData.value == 0 ? 'pengelolatab' : 'pengelolauntab'}.svg'),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.toTarifDasar();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/${controller.masterData.value == 1 ? 'tarifdasartab' : 'tarifdasaruntab'}.svg'),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    (controller.masterData.value == 0) ? buildExpandedPengelola() : buildExpandedBasePrice()
                  ],
                ),
                decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    (controller.masterData.value == 0) ? Get.to(AddPamManageView()) : Get.to(AddBaseFeeView());
                  },
                  child: Icon(Icons.add),
                  backgroundColor: HexColor('#0063F8')),
            ));
      },
    );
  }

  Expanded buildExpandedBasePrice() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: controller.baseFeeResult.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.idBaseFeeController.text = controller.baseFeeResult[index].id.toString();
                        controller.amountDetailController.text = controller.baseFeeResult[index].amount.toString();
                        controller.meterDetailPositionController.text = controller.baseFeeResult[index].meterPosition.toString();
                        Get.to(BaseFeeDetailView());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                            dense: false,
                            title: Text(
                              '${controller.baseFeeResult[index].amount}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            leading: SvgPicture.asset('assets/icontarifdasar.svg'),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset('assets/meter.svg'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text('${controller.baseFeeResult[index].meterPosition}',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        )),
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
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 5.0,
                            spreadRadius: 0.1,
                          )
                        ], borderRadius: const BorderRadius.all(Radius.circular(16)), color: Colors.white),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  Expanded buildExpandedPengelola() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: controller.pamUserResult.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        controller.nameDetailController.text = controller.pamUserResult[index].name!;
                        controller.phoneNumberDetailPamController.text = controller.pamUserResult[index].phoneNumber!;
                        controller.emailPamDetailController.text = controller.pamUserResult[index].email!;
                        controller.idManagePamController.text = controller.pamUserResult[index].id.toString();
                        (controller.pamUserResult[index].blocked! == 0)
                            ? controller.radioValueActivated.value = 1
                            : controller.radioValueActivated.value = 0;
                        Get.to(PamManageDetailView());
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: ListTile(
                            dense: false,
                            title: Text(
                              '${controller.pamUserResult[index].name}',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: ListView.builder(
                                shrinkWrap: true,
                                itemCount: controller.pamUserResult[index].roles!.length,
                                itemBuilder: (context, indexRole) => Text(
                                      controller.pamUserResult[index].roles![indexRole].name!,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )),
                            leading: const CircleAvatar(backgroundColor: Colors.blue),
                            trailing: const Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.amber,
                              ),
                            )),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            blurRadius: 5.0,
                            spreadRadius: 0.1,
                          )
                        ], borderRadius: BorderRadius.all(Radius.circular(16)), color: Colors.white),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
