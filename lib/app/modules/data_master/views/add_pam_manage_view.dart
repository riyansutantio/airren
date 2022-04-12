import 'package:airen/app/modules/data_master/controllers/data_master_controller.dart';
import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';

class AddPamManageView extends GetView<DataMasterController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataMasterController dataMasterController = Get.put(DataMasterController(masterDataProvider: MasterDataProvider()));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      'Tambah Pengelola',
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
                              dataMasterController.addManagePam();
                            }
                          },
                          child: const Icon(EvaIcons.checkmark, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
          ),
          preferredSize: Size.fromHeight(56),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              height: double.infinity,
              child: Form(
                key: _formKey,
                child: Obx(() => SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                            child: AirenTextFormFieldBase(
                              suffixIcon: Icon(EvaIcons.personOutline, color: HexColor('#0063F8')),
                              textInputType: TextInputType.text,
                              hintText: 'Nama Pengelola',
                              obscureText: false,
                              passwordVisibility: false,
                              controller: dataMasterController,
                              textEditingController: dataMasterController.nameController,
                              returnValidation: (val) {
                                if (val!.isEmpty) {
                                  return "Nama administrator PAM harus diisi";
                                } else if (val.length < 3) {
                                  return "Nama administrator PAM harus lebih dari 3";
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
                              textEditingController: dataMasterController.phoneNumberPamController,
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
                                } else if (val[0] == "0") {
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
                              hintText: 'Email',
                              obscureText: false,
                              passwordVisibility: false,
                              controller: dataMasterController,
                              textEditingController: dataMasterController.emailPamController,
                              returnValidation: (val) {
                                if (!val!.isEmail) {
                                  return "Email tidak valid";
                                } else if (val.isEmpty) {
                                  return "Email harus diisi";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 24.0, bottom: 25),
                            child: Container(
                              height: 2,
                              color: HexColor('#F0F5F9'),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
                            child: GestureDetector(
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
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      (dataMasterController.checkBoxCatatMeter.value == true)
                                          ? SvgPicture.asset('assets/addcheck.svg')
                                          : SvgPicture.asset('assets/removecheck.svg'),
                                      const Text(''),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10.0),
                                          child: Text(
                                            'Catat Meter',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Jadikan sebagai petugas catat meter',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
                            child: GestureDetector(
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
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      (dataMasterController.checkBoxPembayaran.value == true)
                                          ? SvgPicture.asset('assets/addcheck.svg')
                                          : SvgPicture.asset('assets/removecheck.svg'),
                                      const SizedBox(height: 40),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10.0),
                                          child: Text(
                                            'Bendahara',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          height: 40,
                                          child: Text(
                                            'Jadikan sebagai petugas penerima pembayaran',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793'),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (dataMasterController.checkBoxPembayaran.value != false ||
                              dataMasterController.checkBoxCatatMeter.value != false)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20, bottom: 8.0),
                              child: buildElevatedButtonCustom(),
                            ),
                        ],
                      ),
                    )),
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white)),
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
            dataMasterController.addManagePam();
          }
        },
        child: Ink(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 8.0),
              color: Color.fromRGBO(0, 99, 248, 0.2),
              blurRadius: 24,
            ),
          ], gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 48,
            width: double.infinity,
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
