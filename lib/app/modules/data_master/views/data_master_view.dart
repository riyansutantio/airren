import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:airen/app/modules/data_master/views/add_base_fee_view.dart';
import 'package:airen/app/modules/data_master/views/add_pam_manage_view.dart';
import 'package:airen/app/modules/data_master/views/base_fee_detail_view.dart';
import 'package:airen/app/modules/data_master/views/pam_manage_detail_view.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../controllers/data_master_controller.dart';

class DataMasterView extends GetView<DataMasterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataMasterController>(
      init: DataMasterController(masterDataProvider: MasterDataProvider()),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: (controller.isSearchPengelola.value)
                  ? buildAppBarSearch(context, controller)
                  : buildAppBarDefault(context),
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
                          child: Container(
                            color: Colors.transparent,
                            height: 90,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const SizedBox(),
                                  controller.masterData.value == 0
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/pengelolaiconon.svg'),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'pengelola',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/pengelolaiconoff.svg', color: Colors.white.withOpacity(0.5)),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'pengelola',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white.withOpacity(0.5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white.withOpacity(0.5),
                                              ),
                                            )
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.toTarifDasar();
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 90,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  controller.masterData.value == 1
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/tarifdasariconon.svg', color: Colors.white),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'tarif dasar',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 40,
                                              height: 3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset('assets/tarifdasariconon.svg', color: Colors.white.withOpacity(0.5)),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'tarif dasar',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white.withOpacity(0.5),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(100),
                                                color: Colors.white.withOpacity(0.5),
                                              ),
                                              width: 40,
                                              height: 3,
                                            )
                                          ],
                                        ),
                                  const SizedBox(),
                                ],
                              ),
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
                  child: const Icon(Icons.add),
                  backgroundColor: HexColor('#0063F8')),
            ));
      },
    );
  }

  PreferredSize buildAppBarSearch(BuildContext context, DataMasterController controller) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  controller.isSearchPengelola.value = false;
                  controller.isLoadingBaseFee.value = false;
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
                  onSubmit: (val){
                    controller.isSearchPengelola.value = false;
                    controller.isLoadingBaseFee.value = false;
                    logger.i(val!);
                    return null;
                  },
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(EvaIcons.search),
                  ),
                  textInputType: TextInputType.text,
                  hintText: 'cari..',
                  obscureText: false,
                  passwordVisibility: false,
                  controller: controller,
                  textEditingController: controller.searchController,
                  returnValidation: (val) {
                    if (val!.isEmpty) {
                      return "tarif harus terisi";
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
              ))
            ],
          ),
        ),
        decoration:
            BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
      ),
      preferredSize: Size.fromHeight(Get.height * 0.1),
    );
  }

  AppBar buildAppBarDefault(BuildContext context) {
    return AppBar(
        leadingWidth: 200,
        leading: Center(
          child: Text(
            'Master data',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Image.asset(
            'assets/notif.png',
            width: 24,
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: (){
              controller.isSearchPengelola.value = true;
            },
            child: const Icon(
              EvaIcons.search,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
        ],
        flexibleSpace: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
        ));
  }

  Expanded buildExpandedBasePrice() {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)), color: Colors.white),
        child: (controller.baseFeeResult.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: SvgPicture.asset('assets/tarifkosong.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text('Belum ada tarif dasar',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text('Tambahkan tarif dasar penggunaan air',
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('melalui tombol di bawah.',
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ],
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: controller.baseFeeResult.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              controller.idBaseFeeController.text = controller.baseFeeResult[index].id.toString();
                              controller.amountDetailController.text = controller.baseFeeResult[index].amount.toString();
                              controller.meterDetailPositionController.text =
                                  controller.baseFeeResult[index].meterPosition.toString();
                              Get.to(BaseFeeDetailView());
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 5, bottom: 5),
                              child: ListTile(
                                  dense: false,
                                  title: Text(
                                    '${rpFormatter(value: controller.baseFeeResult[index].amount) ?? 0}',
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
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset('assets/meter.svg'),
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            child: Text('${controller.baseFeeResult[index].meterPosition}',
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
                        (controller.pamUserResult[index].blocked! == 1)
                            ? controller.radioValueActivated.value = 0
                            : controller.radioValueActivated.value = 1;
                        controller.checkRole(controller.pamUserResult[index].roles);
                        Get.to(PamManageDetailView(
                          roles: controller.pamUserResult[index].roles!,
                        ));
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
                            leading: CircleAvatar(
                                backgroundColor: Colors.blue.withOpacity(0.2),
                                child: Text(
                                  controller.pamUserResult[index].name![0].toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
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
                        ], borderRadius: BorderRadius.all(const Radius.circular(16)), color: Colors.white),
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
