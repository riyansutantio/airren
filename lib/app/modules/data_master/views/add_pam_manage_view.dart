import 'package:airen/app/modules/data_master/controllers/data_master_controller.dart';
import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';

class AddPamManageView extends GetView {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DataMasterController dataMasterController = Get.put(DataMasterController(masterDataProvider: MasterDataProvider()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: const Icon(EvaIcons.arrowBack), color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Tambah Pengelola',
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
                    Image.asset(
                      'assets/notif.png',
                      width: 30,
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            dataMasterController.addManagePam();
                          }
                        },
                        child: const Icon(Icons.check, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Obx(() => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AirenTextFormFieldBase(
                              textInputType: TextInputType.text,
                              hintText: 'Nama Pengelola',
                              obscureText: false,
                              passwordVisibility: false,
                              controller: dataMasterController,
                              textEditingController: dataMasterController.nameController,
                              returnValidation: (val) {
                                if (val!.isEmpty) {
                                  return "Nama Administrator PAM harus terisi";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AirenTextFormFieldBase(
                              textInputType: TextInputType.phone,
                              hintText: 'Nomor HP',
                              obscureText: false,
                              passwordVisibility: false,
                              controller: dataMasterController,
                              textEditingController: dataMasterController.phoneNumberPamController,
                              prefixText: SizedBox(
                                child: Center(
                                  widthFactor: 0.0,
                                  child: Text(
                                    '+62',
                                    style: GoogleFonts.montserrat(
                                      color: HexColor('#707793'),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              returnValidation: (val) {
                                if (val!.isEmpty) {
                                  return "Nomor HP harus terisi";
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
                            padding: const EdgeInsets.all(8.0),
                            child: AirenTextFormFieldBase(
                              textInputType: TextInputType.emailAddress,
                              hintText: 'email',
                              obscureText: false,
                              passwordVisibility: false,
                              controller: dataMasterController,
                              textEditingController: dataMasterController.emailPamController,
                              returnValidation: (val) {
                                if (!val!.isEmail) {
                                  return "Email tidak valid";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Email yang digunakan harus email dari Google',
                                style: GoogleFonts.montserrat(
                                  color: HexColor('#707793'),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Container(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                          // Container(
                          //   width: double.infinity,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.all(Radius.circular(5)),
                          //     color: HexColor('#FF3B3B').withOpacity(0.1),
                          //   ),
                          //   padding: EdgeInsets.all(10),
                          //   child: Text(
                          //     'Anda harus menentukan rolenya',
                          //     style: GoogleFonts.montserrat(
                          //       color: HexColor('#FF3B3B'),
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.w500,
                          //     ),
                          //   ),
                          // ),
                          Theme(
                            data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: dataMasterController.checkBoxCatatMeter.value,
                              onChanged: (val) {
                                dataMasterController.checkBoxCatatMeter.value = val!;
                                logger.i(dataMasterController.checkBoxCatatMeter.value);
                              },
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
                            ),
                          ),
                          Theme(
                            data: ThemeData(
                                checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: dataMasterController.checkBoxPembayaran.value,
                              onChanged: (val) {
                                dataMasterController.checkBoxPembayaran.value = val!;
                                logger.i(dataMasterController.checkBoxPembayaran.value);
                              },
                              title: Text(
                                'Pembayaran',
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
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (dataMasterController.checkBoxPembayaran.value != false ||
                              dataMasterController.checkBoxCatatMeter.value != false)
                            buildElevatedButtonCustom(),
                        ],
                      )),
                ),
              ),
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
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
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(15)),
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
            padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
  }
}
