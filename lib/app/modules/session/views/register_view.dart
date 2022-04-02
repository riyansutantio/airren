import 'package:airen/app/modules/session/views/register_step_two_view.dart';
import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../controllers/session_controller.dart';
import '../providers/session_provider.dart';

class RegisterView extends GetView {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallbackWithFunc(func: sessionController.googleSignOut()),
      child: Scaffold(
        appBar: buildAppBarSession(
            buttonBack: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(EvaIcons.arrowBack, color: Colors.white)),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            title: 'Register',
            firstSubtitle: 'Mohon masukkan informasi PAMS Anda',
            secondSubtitle: ''),
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
                                hintText: 'Nama PAMS',
                                obscureText: false,
                                passwordVisibility: false,
                                controller: sessionController,
                                textEditingController: sessionController.nameController,
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Nama Pams harus terisi";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  sessionController.regencyController.clear();
                                  sessionController.districtController.clear();
                                  Get.bottomSheet(Container(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: sessionController.resultProvince.length,
                                          itemBuilder: (context, index) => GestureDetector(
                                                onTap: () {
                                                  sessionController.selectedProvince.value =
                                                      sessionController.resultProvince[index].id.toString();
                                                  sessionController.provinceController.text =
                                                      sessionController.resultProvince[index].name!;
                                                  sessionController.getRegency(
                                                      id: sessionController.resultProvince[index].id.toString());
                                                  Get.until((route) => Get.isBottomSheetOpen == false);
                                                },
                                                child: ListTile(
                                                  title: Text('${sessionController.resultProvince[index].name}',
                                                      style: GoogleFonts.montserrat(
                                                        color: HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                      )),
                                                ),
                                              )),
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                          color: Colors.white)));
                                },
                                child: AirenTextFormFieldBase(
                                  enabled: false,
                                  textInputType: TextInputType.text,
                                  suffixIcon: Icon(
                                    EvaIcons.chevronDown,
                                    color: HexColor('#0063F8'),
                                  ),
                                  hintText: 'Provinsi',
                                  obscureText: false,
                                  passwordVisibility: false,
                                  controller: sessionController,
                                  textEditingController: sessionController.provinceController,
                                  returnValidation: (val) {
                                    if (val!.isEmpty) {
                                      return "Provinsi harus terpilih";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            if (sessionController.resultRegency.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    sessionController.districtController.clear();
                                    Get.bottomSheet(Container(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: sessionController.resultRegency.length,
                                            itemBuilder: (context, index) => GestureDetector(
                                                  onTap: () {
                                                    sessionController.selectedRegency.value =
                                                        sessionController.resultRegency[index].id.toString();
                                                    sessionController.regencyController.text =
                                                        sessionController.resultRegency[index].name!;
                                                    sessionController.getDistrict(
                                                        id: sessionController.resultRegency[index].id.toString());
                                                    Get.until((route) => Get.isBottomSheetOpen == false);
                                                  },
                                                  child: ListTile(
                                                    title: Text('${sessionController.resultRegency[index].name}',
                                                        style: GoogleFonts.montserrat(
                                                          color: HexColor('#707793'),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        )),
                                                  ),
                                                )),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                            color: Colors.white)));
                                  },
                                  child: AirenTextFormFieldBase(
                                    enabled: false,
                                    textInputType: TextInputType.phone,
                                    suffixIcon: Icon(
                                      EvaIcons.chevronDown,
                                      color: HexColor('#0063F8'),
                                    ),
                                    hintText: 'Kabupaten',
                                    obscureText: false,
                                    passwordVisibility: false,
                                    controller: sessionController,
                                    textEditingController: sessionController.regencyController,
                                    returnValidation: (val) {
                                      if (val!.isEmpty) {
                                        return "Kabupaten harus terpilih";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            if (sessionController.resultDistrict.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(Container(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: sessionController.resultDistrict.length,
                                            itemBuilder: (context, index) => GestureDetector(
                                                  onTap: () {
                                                    sessionController.selectedDistrict.value =
                                                        sessionController.resultDistrict[index].id.toString();
                                                    sessionController.districtController.text =
                                                        sessionController.resultDistrict[index].name!;
                                                    // sessionController.getDistrict(
                                                    //     id: sessionController.resultRegency[index].id.toString());
                                                    Get.until((route) => Get.isBottomSheetOpen == false);
                                                  },
                                                  child: ListTile(
                                                    title: Text('${sessionController.resultDistrict[index].name}',
                                                        style: GoogleFonts.montserrat(
                                                          color: HexColor('#707793'),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500,
                                                        )),
                                                  ),
                                                )),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                            color: Colors.white)));
                                  },
                                  child: AirenTextFormFieldBase(
                                    enabled: false,
                                    textInputType: TextInputType.phone,
                                    suffixIcon: Icon(
                                      EvaIcons.chevronDown,
                                      color: HexColor('#0063F8'),
                                    ),
                                    hintText: 'Kecamatan',
                                    obscureText: false,
                                    passwordVisibility: false,
                                    controller: sessionController,
                                    textEditingController: sessionController.districtController,
                                    returnValidation: (val) {
                                      if (val!.isEmpty) {
                                        return "Kecamatan harus terpilih";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: AirenTextFormFieldBase(
                            //     textInputType: TextInputType.phone,
                            //     suffix: Icon(
                            //       EvaIcons.chevronDown,
                            //       color: HexColor('#0063F8'),
                            //     ),
                            //     hintText: 'Kelurahan',
                            //     obscureText: false,
                            //     passwordVisibility: false,
                            //     controller: sessionController,
                            //     textEditingController: sessionController.kelurahanController,
                            //     returnValidation: (val){
                            //       if (val!.isEmpty){
                            //         return "Kelurahan harus terpilih";
                            //       }
                            //       return null;
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AirenTextFormFieldBase(
                                textInputType: TextInputType.text,
                                hintText: 'Detail Alamat',
                                obscureText: false,
                                passwordVisibility: false,
                                controller: sessionController,
                                textEditingController: sessionController.addressDetailController,
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Detail Alamat harus terisi";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildElevatedButtonCustom(),
                            ),
                          ],
                        )),
                  ),
                ),
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
            Get.to(RegisterStepTwoView());
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
                'Selanjutnya',
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
