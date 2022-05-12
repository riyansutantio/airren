import 'package:airen/app/model/pam_user/pam_user_model.dart';
import 'package:airen/app/modules/data_master/controllers/data_master_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../providers/master_data_provider.dart';

class PamManageDetailView extends GetView<DataMasterController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataMasterController dataMasterController = Get.put(DataMasterController(masterDataProvider: MasterDataProvider()));

  List<RolePam> roles;
  int? admin;

  PamManageDetailView({required this.roles, required this.admin});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallbackWithFunc(func: controller.clearCondition()),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 20),
                          child: Icon(EvaIcons.arrowBack, color: Colors.white),
                        ),
                      ),
                      Text(
                        'Detail Pengelola',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 16),
                        child: GestureDetector(
                            onTap: () {
                              Get.to(ErrorHandlingView());
                            },
                            child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 19, right: 20),
                        child: GestureDetector(
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                dataMasterController.updateManagePam();
                              }
                            },
                            child: const Icon(EvaIcons.checkmark, color: Colors.white)),
                      ),
                    ],
                  )
                ],
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
            ),
            preferredSize: Size.fromHeight(56),
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
            child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Obx(() => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                              child: AirenTextFormFieldBase(
                                textInputType: TextInputType.text,
                                hintText: 'Nama Pengelola',
                                suffixIcon: Icon(EvaIcons.personOutline, color: HexColor('#0063F8')),
                                obscureText: false,
                                passwordVisibility: false,
                                controller: dataMasterController,
                                textEditingController: dataMasterController.nameDetailController,
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Nama pengelola harus diisi";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                              child: AirenTextFormFieldBase(
                                textInputType: TextInputType.phone,
                                suffixIcon: Icon(EvaIcons.phoneOutline, color: HexColor('#0063F8')),
                                hintText: 'Nomor HP',
                                obscureText: false,
                                passwordVisibility: false,
                                controller: dataMasterController,
                                textEditingController: dataMasterController.phoneNumberDetailPamController,
                                prefixText: SizedBox(
                                  child: Center(
                                    widthFactor: 0.0,
                                    child: Text(
                                      '62',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#707793'),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Nomor HP harus diisi";
                                  } else if (val.length < 7) {
                                    return "Nomor HP tidak valid";
                                  } else if (val.length > 14) {
                                    return "Nomor HP tidak valid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                              child: AirenTextFormFieldBase(
                                textInputType: TextInputType.emailAddress,
                                suffixIcon: Icon(EvaIcons.emailOutline, color: HexColor('#0063F8')),
                                hintText: 'email',
                                obscureText: false,
                                passwordVisibility: false,
                                controller: dataMasterController,
                                textEditingController: dataMasterController.emailPamDetailController,
                                returnValidation: (val) {
                                  if (!val!.isEmail) {
                                    return "Email tidak valid";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12, bottom: 32),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email yang digunakan harus email dari Google',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#707793'),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            if (dataMasterController.checkBoxPembayaran.value == false &&
                                dataMasterController.checkBoxCatatMeter.value == false)
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 23),
                                child: Container(
                                  height: 39,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    color: HexColor('#FF3B3B').withOpacity(0.1),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Anda harus menentukan rolenya',
                                        style: GoogleFonts.montserrat(
                                          color: HexColor('#FF3B3B'),
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            (admin == 1)
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 16),
                                    child: Container(
                                      decoration: BoxDecoration(boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color: Color.fromRGBO(0, 99, 248, 0.16),
                                          blurRadius: 24,
                                        ),
                                      ], borderRadius: BorderRadius.circular(16), color: Colors.white),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                                child: Text(
                                                  'Tentukan Role',
                                                  style: GoogleFonts.montserrat(
                                                    color: HexColor('#707793'),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                                child: Text(
                                                  controller.rolesUser.map((element) => element).join(' & '),
                                                  style: GoogleFonts.montserrat(
                                                    color: HexColor('#0063F8'),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset('assets/edit.svg'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(Container(
                                          decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                            color: Colors.white,
                                          ),
                                          child: Wrap(
                                            children: [
                                              Obx(() => Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12.0),
                                                        child: Container(
                                                          width: 70,
                                                          height: 5,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius.all(Radius.circular(40)),
                                                            color: Colors.amber,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 30.0),
                                                        child: Text(
                                                          'Tentukan Role',
                                                          style: GoogleFonts.montserrat(
                                                            color: HexColor('#3C3F58'),
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      if (dataMasterController.checkBoxPembayaran.value == false &&
                                                          dataMasterController.checkBoxCatatMeter.value == false)
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 24),
                                                          child: Container(
                                                            height: 39,
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                              color: HexColor('#FF3B3B').withOpacity(0.1),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(left: 16.0),
                                                              child: Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  'Anda harus menentukan rolenya',
                                                                  style: GoogleFonts.montserrat(
                                                                    color: HexColor('#FF3B3B'),
                                                                    fontSize: 12,
                                                                    fontWeight: FontWeight.normal,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      Theme(
                                                        data: ThemeData(
                                                            checkboxTheme: CheckboxThemeData(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)))),
                                                        child: ListTile(
                                                          leading: (dataMasterController.checkBoxCatatMeter.value == true)
                                                              ? SvgPicture.asset('assets/addcheck.svg')
                                                              : SvgPicture.asset('assets/removecheck.svg'),
                                                          title: Text(
                                                            'Entry meter',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#707793'),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            'Jadikan sebagai petugas catat meter',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#707793'),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                          onTap: () {
                                                           if (dataMasterController.checkBoxCatatMeter.value == true){
                                                             controller.rolesUser.remove('Catat Meter PAM');
                                                             dataMasterController.checkBoxCatatMeter.toggle();
                                                           } else {
                                                             controller.rolesUser.add('Catat Meter PAM');
                                                             dataMasterController.checkBoxCatatMeter.toggle();
                                                           }
                                                            logger.i(dataMasterController.checkBoxCatatMeter.value);
                                                          },
                                                        ),
                                                      ),
                                                      Theme(
                                                        data: ThemeData(
                                                            checkboxTheme: CheckboxThemeData(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5)))),
                                                        child: ListTile(
                                                          leading: (dataMasterController.checkBoxPembayaran.value == true)
                                                              ? SvgPicture.asset('assets/addcheck.svg')
                                                              : SvgPicture.asset('assets/removecheck.svg'),
                                                          title: Text(
                                                            'Bendahara',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#707793'),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          subtitle: Text(
                                                            'Jadikan sebagai petugas penerima pembayaran',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#707793'),
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                          onTap: (){
                                                           if  (dataMasterController.checkBoxPembayaran.value == true){
                                                             controller.rolesUser.remove('Bendahara PAM');
                                                             dataMasterController.checkBoxPembayaran.toggle();
                                                           } else {
                                                             controller.rolesUser.add('Bendahara PAM');
                                                             dataMasterController.checkBoxPembayaran.toggle();
                                                           }
                                                            logger.i(dataMasterController.checkBoxPembayaran.value);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 40.0, top: 32),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: Text('Batal',
                                                              style: GoogleFonts.montserrat(
                                                                color: HexColor('#0063F8'),
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                              )),
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: HexColor('#0063F8').withOpacity(0.2),
                                                          ),
                                                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.back();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: Text('Simpan',
                                                              style: GoogleFonts.montserrat(
                                                                color: Colors.white,
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.bold,
                                                              )),
                                                          decoration: BoxDecoration(boxShadow: const [
                                                            BoxShadow(
                                                              offset: Offset(0.0, 8.0),
                                                              color: Color.fromRGBO(0, 99, 248, 0.2),
                                                              blurRadius: 24,
                                                            ),
                                                          ], color: HexColor('#0063F8'), borderRadius: BorderRadius.circular(10)),
                                                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(0.0, 8.0),
                                            color: Color.fromRGBO(0, 99, 248, 0.16),
                                            blurRadius: 24,
                                          ),
                                        ], borderRadius: BorderRadius.circular(16), color: Colors.white),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                                  child: Text(
                                                    'Tentukan Role',
                                                    style: GoogleFonts.montserrat(
                                                      color: HexColor('#707793'),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                                  child: Text(
                                                    controller.rolesUser.map((element) => element).join(' & '),
                                                    style: GoogleFonts.montserrat(
                                                      color: HexColor('#0063F8'),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset('assets/edit.svg'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            if (admin == 1)
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 16),
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ], borderRadius: BorderRadius.circular(16), color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                            child: Text(
                                              'Tentukan Status',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                            child: Text(
                                              controller.radioValueActivated.value == 0 ? "Aktif" : 'Nonaktif',
                                              style: GoogleFonts.montserrat(
                                                color: controller.radioValueActivated.value == 0
                                                    ? HexColor('#05C270')
                                                    : HexColor('#FF3B3B'),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SvgPicture.asset('assets/edit.svg'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 16),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(Container(
                                      decoration: const BoxDecoration(
                                        borderRadius:
                                            BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                        color: Colors.white,
                                      ),
                                      child: Wrap(
                                        children: [
                                          Obx(() => Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 12.0),
                                                    child: Container(
                                                      width: 70,
                                                      height: 5,
                                                      decoration: const BoxDecoration(
                                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                                        color: Colors.amber,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 30.0),
                                                    child: Text(
                                                      'Status Pengelola',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#3C3F58'),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: controller.radioValueActivatedActiveDp.value == true
                                                        ? SvgPicture.asset('assets/activecustomer.svg')
                                                        : SvgPicture.asset('assets/deactivecustomer.svg'),
                                                    title: Text(
                                                      'Aktif',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      'diperbolehkan untuk masuk ke aplikasi',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#707793'),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller.radioValueActivatedActiveDp.toggle();
                                                      if (controller.radioValueActivated.value == 0) {
                                                        controller.radioValueActivated.value = 1;
                                                      } else {
                                                        controller.radioValueActivated.value = 0;
                                                      }
                                                      logger.w(controller.radioValueActivated.value);
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: controller.radioValueActivatedActiveDp.value == true
                                                        ? SvgPicture.asset('assets/deactivecustomer.svg')
                                                        : SvgPicture.asset('assets/activecustomer.svg'),
                                                    title: Text(
                                                      'Nonaktif',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      'Tidak diperbolehkan untuk masuk ke aplikasi',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#707793'),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      controller.radioValueActivatedActiveDp.toggle();
                                                      if (controller.radioValueActivated.value == 0) {
                                                        controller.radioValueActivated.value = 1;
                                                      } else {
                                                        controller.radioValueActivated.value = 0;
                                                      }
                                                      logger.w(controller.radioValueActivated.value);
                                                    },
                                                  ),
                                                ],
                                              )),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 40.0, top: 32),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: Text('Batal',
                                                          style: GoogleFonts.montserrat(
                                                            color: HexColor('#0063F8'),
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: HexColor('#0063F8').withOpacity(0.2),
                                                      ),
                                                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Container(
                                                      child: Text('Simpan',
                                                          style: GoogleFonts.montserrat(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          )),
                                                      decoration: BoxDecoration(boxShadow: const [
                                                        BoxShadow(
                                                          offset: Offset(0.0, 8.0),
                                                          color: Color.fromRGBO(0, 99, 248, 0.2),
                                                          blurRadius: 24,
                                                        ),
                                                      ], color: HexColor('#0063F8'), borderRadius: BorderRadius.circular(10)),
                                                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 99, 248, 0.16),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 24,
                                      ),
                                    ], borderRadius: BorderRadius.circular(16), color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                              child: Text(
                                                'Tentukan Status',
                                                style: GoogleFonts.montserrat(
                                                  color: HexColor('#707793'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 25.0),
                                              child: Text(
                                                controller.radioValueActivated.value == 0 ? "Aktif" : 'Nonaktif',
                                                style: GoogleFonts.montserrat(
                                                  color: controller.radioValueActivated.value == 0
                                                      ? HexColor('#05C270')
                                                      : HexColor('#FF3B3B'),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset('assets/edit.svg'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            (admin == 1)
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20, top: 32),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset('assets/deletedisable.svg'),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Ink(
                                              padding: const EdgeInsets.only(right: 15, left: 15),
                                              decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      offset: Offset(0.0, 8.0),
                                                      color: Color.fromRGBO(0, 99, 248, 0.2),
                                                      blurRadius: 24,
                                                    ),
                                                  ],
                                                  gradient: LinearGradient(colors: gradientColorAirren),
                                                  borderRadius: BorderRadius.circular(10)),
                                              child: SizedBox(
                                                height: 48,
                                                child: Center(
                                                  child: Text(
                                                    'Simpan',
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
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))))
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20, top: 32),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              Get.bottomSheet(Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                                  color: Colors.white,
                                                ),
                                                child: Wrap(
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 12.0),
                                                          child: Container(
                                                            width: 70,
                                                            height: 5,
                                                            decoration: const BoxDecoration(
                                                              borderRadius: BorderRadius.all(Radius.circular(40)),
                                                              color: Colors.amber,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 30.0),
                                                          child: SvgPicture.asset('assets/deletemanage.svg'),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 24.0),
                                                          child: Text(
                                                            'Anda Yakin ?',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#3C3F58'),
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 16.0),
                                                          child: Text(
                                                            'Data akan dihapus secara permanen.',
                                                            style: GoogleFonts.montserrat(
                                                              color: HexColor('#707793'),
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.normal,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Benarkah ingin menghapusnya?',
                                                          style: GoogleFonts.montserrat(
                                                            color: HexColor('#707793'),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.normal,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 32.0, bottom: 40),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    child: Text('Batal',
                                                                        style: GoogleFonts.montserrat(
                                                                          color: HexColor('#0063F8'),
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.bold,
                                                                        )),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: HexColor('#0063F8').withOpacity(0.2),
                                                                    ),
                                                                    padding: const EdgeInsets.only(
                                                                        left: 20, right: 20, bottom: 10, top: 10),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  dataMasterController.deleteManagePam();
                                                                  Get.back();
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Container(
                                                                    child: Text('Ya, hapus',
                                                                        style: GoogleFonts.montserrat(
                                                                          color: Colors.white,
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.bold,
                                                                        )),
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.red,
                                                                    ),
                                                                    padding: const EdgeInsets.only(
                                                                        left: 20, right: 20, bottom: 10, top: 10),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ));
                                            },
                                            child: SvgPicture.asset('assets/delete.svg')),
                                        if (dataMasterController.checkBoxPembayaran.value != false ||
                                            dataMasterController.checkBoxCatatMeter.value != false)
                                          buildElevatedButtonCustom(),
                                      ],
                                    ),
                                  )
                          ],
                        )),
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.white)),
          ),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButtonCustom() {
    return ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            dataMasterController.updateManagePam();
          }
        },
        child: Ink(
          padding: const EdgeInsets.only(right: 15, left: 15),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 8.0),
              color: Color.fromRGBO(0, 99, 248, 0.2),
              blurRadius: 24,
            ),
          ], gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 48,
            child: Center(
              child: Text(
                'Simpan',
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
            padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  }
}
