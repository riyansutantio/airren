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

import '../../../utils/utils.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/data_master_controller.dart';

class DataMasterView extends GetView<DataMasterController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataMasterController>(
      init: DataMasterController(masterDataProvider: MasterDataProvider()),
      builder: (controller) {
        return Obx(() => Scaffold(
              backgroundColor: Colors.blue,
              appBar: (controller.isSearch.value)
                  ? buildAppBarSearch(context, controller)
                  : buildAppBarDefault(context),
              body: WillPopScope(
                onWillPop: () =>
                    willPopWithFuncOnly(func: controller.closeSearchAppBar()),
                child: Container(
                  child: Column(
                    children: [
                      if (controller.isSearch.value == false)
                        SizedBox(
                          height: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.toPengelola();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const SizedBox(),
                                        controller.masterData.value == 0
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/pengelolaiconon.svg'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Pengelola',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  if (controller
                                                          .masterData.value ==
                                                      0)
                                                    Container(
                                                      width: 35,
                                                      height: 5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/pengelolaiconoff.svg',
                                                      color: Colors.white
                                                          .withOpacity(0.5)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Pengelola',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.toBaseFee();
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 90,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        controller.masterData.value == 1
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/tarifdasariconon.svg',
                                                      color: Colors.white),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Tarif Dasar Air',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
                                                  if (controller
                                                          .masterData.value ==
                                                      1)
                                                    Container(
                                                      width: 35,
                                                      height: 5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/tarifdasariconon.svg',
                                                      color: Colors.white
                                                          .withOpacity(0.5)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Tarif Dasar Air',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: Colors.white
                                                            .withOpacity(0.5),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ),
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
                        ),
                      const SizedBox(height: 5),
                      (controller.masterData.value == 0)
                          ? buildExpandedPengelola()
                          : buildExpandedBasePrice()
                    ],
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
                ),
              ),
              floatingActionButton: (controller.isSearch.value)
                  ? const SizedBox()
                  : FloatingActionButton(
                      onPressed: () {
                        (controller.masterData.value == 0)
                            ? Get.to(AddPamManageView())
                            : Get.to(AddBaseFeeView());
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
            ));
      },
    );
  }

  PreferredSize buildAppBarSearch(
      BuildContext context, DataMasterController controller) {
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
                  hintText: 'Cari..',
                  obscureText: false,
                  passwordVisibility: false,
                  controller: controller,
                  textEditingController: controller.searchController,
                  returnValidation: (val) {
                    if (val!.isEmpty) {
                      return "Tarif dasar harus terisi";
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ))
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
            boxShadow: const []),
      ),
      preferredSize: Size.fromHeight(Get.height * 0.1),
    );
  }

  AppBar buildAppBarDefault(BuildContext context) {
    return AppBar(
        elevation: 0,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Center(
            child: Text(
              'Master data',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {
                  Get.to(ErrorHandlingView());
                },
                child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                controller.isSearch.value = true;
              },
              child: const Icon(
                EvaIcons.search,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
        ));
  }

  Expanded buildExpandedBasePrice() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: (controller.baseFeeResult.isEmpty)
            ? Column(
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
                  (controller.isSearch.value)
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Tidak ditemukan',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Belum ada tarif dasar',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                  (controller.isSearch.value)
                      ? Align(
                          alignment: Alignment.center,
                          child: Text('Belum ada tarif dasar air yang sesuai ',
                              style: GoogleFonts.montserrat(
                                color: HexColor("#707793").withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text('Tambahkan tarif dasar penggunaan air',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793').withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                  (controller.isSearch.value)
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('kata kunci di atas.',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793').withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        )
                      : Text('melalui tombol di bawah.',
                          style: GoogleFonts.montserrat(
                            color: HexColor('#707793').withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                ],
              )
            : ListView.builder(
                itemCount: controller.baseFeeResult.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.idBaseFeeController.text =
                            controller.baseFeeResult[index].id.toString();
                        controller.amountDetailController.text =
                            rpFormatterWithOutSymbol(
                                value:
                                    controller.baseFeeResult[index].amount!)!;
                        controller.meterDetailPositionController.text =
                            controller.baseFeeResult[index].meterPosition
                                .toString();
                        Get.to(BaseFeeDetailView());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 16.0),
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
                              leading: CircleAvatar(
                                  backgroundColor:
                                      HexColor('#0063F8').withOpacity(0.1),
                                  maxRadius: 25,
                                  child: Icon(EvaIcons.dropletOutline,
                                      color: HexColor('#0063F8'))),
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
                                        child: Text(
                                            '${controller.baseFeeResult[index].meterPosition}',
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

  Expanded buildExpandedPengelola() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.white),
        child: (controller.pamUserResult.isEmpty)
            ? Column(
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
                  (controller.isSearch.value)
                      ? Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Tidak ditemukan',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Belum ada tarif dasar',
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                  (controller.isSearch.value)
                      ? Align(
                          alignment: Alignment.center,
                          child: Text('Belum ada pengelola pams yang sesuai ',
                              style: GoogleFonts.montserrat(
                                color: HexColor("#707793").withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Text('Tambahkan tarif dasar penggunaan air',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793').withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        ),
                  (controller.isSearch.value)
                      ? Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('kata kunci di atas.',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793').withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              )),
                        )
                      : Text('melalui tombol di bawah.',
                          style: GoogleFonts.montserrat(
                            color: HexColor('#707793').withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                ],
              )
            : ListView.builder(
                itemCount: controller.pamUserResult.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        controller.nameDetailController.text =
                            controller.pamUserResult[index].name!;
                        controller.phoneNumberDetailPamController.text =
                            controller.pamUserResult[index].phoneNumber!;
                        controller.emailPamDetailController.text =
                            controller.pamUserResult[index].email!;
                        controller.idManagePamController.text =
                            controller.pamUserResult[index].id.toString();
                        if (controller.pamUserResult[index].blocked! == 1) {
                          controller.radioValueActivated.value = 1;
                          controller.radioValueActivatedActiveDp.value = false;
                        } else {
                          controller.radioValueActivated.value = 0;
                          controller.radioValueActivatedActiveDp.value = true;
                        }
                        controller
                            .checkRole(controller.pamUserResult[index].roles);
                        controller.rolesUser.assignAll(controller
                            .pamUserResult[index].roles!
                            .map((e) => e.name!));
                        Get.to(PamManageDetailView(
                          admin: controller.pamUserResult[index].isOwner,
                          roles: controller.pamUserResult[index].roles!,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 16.0, right: 16.0),
                        child: Container(
                          child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              dense: false,
                              title: Text(
                                '${controller.pamUserResult[index].name}',
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  controller.pamUserResult[index].roles!
                                      .map((e) => e.name)
                                      .join(" & "),
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#707793'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              leading: CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor:
                                      controller.pamUserResult[index].isOwner ==
                                              1
                                          ? HexColor('#FF8801').withOpacity(0.1)
                                          : (controller.pamUserResult[index]
                                                      .blocked ==
                                                  1)
                                              ? Colors.red.withOpacity(0.1)
                                              : Colors.green.withOpacity(0.1),
                                  child: Text(
                                    controller.getInitials(controller
                                        .pamUserResult[index].name!
                                        .toUpperCase()),
                                    style: GoogleFonts.montserrat(
                                      color: controller.pamUserResult[index]
                                                  .isOwner ==
                                              1
                                          ? HexColor('#FF8801')
                                          : (controller.pamUserResult[index]
                                                      .blocked ==
                                                  1)
                                              ? Colors.red
                                              : Colors.green,
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
}
