import 'package:airen/app/modules/session/views/register_step_two_view.dart';
import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../routes/app_pages.dart';
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
      onWillPop: () =>
          willPopCallbackWithFunc(func: sessionController.googleDisconnect()).whenComplete(() => Get.offAllNamed(Routes.SESSION)),
      child: Scaffold(
        appBar: buildAppBarSession(
            buttonBack: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      sessionController.googleDisconnect().whenComplete(() => Get.offAllNamed(Routes.SESSION));
                    },
                    child: const Icon(EvaIcons.arrowBack, color: Colors.white)),
                const SizedBox(
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
                                textEditingController: sessionController.namePamController,
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Nama pam harus diisi";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AirenTextFormFieldBase(
                                enabled: true,
                                textInputType: TextInputType.none,
                                suffixIcon: Icon(
                                  EvaIcons.arrowIosDownwardOutline,
                                  color: HexColor('#0063F8').withOpacity(0.5),
                                ),
                                hintText: 'Provinsi',
                                obscureText: false,
                                passwordVisibility: false,
                                controller: sessionController,
                                textEditingController: sessionController.provinceController,
                                returnValidation: (val) {
                                  if (val!.isEmpty) {
                                    return "Provinsi harus dipilih";
                                  }
                                  return null;
                                },
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
                                                        fontWeight: FontWeight.normal,
                                                      )),
                                                ),
                                              )),
                                      decoration: const BoxDecoration(
                                          borderRadius:
                                              BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                          color: Colors.white)));
                                },
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AirenTextFormFieldBase(
                                  enabled: (sessionController.selectedProvince.isEmpty) ? false : true,
                                  textInputType: TextInputType.none,
                                  suffixIcon: Icon(
                                    EvaIcons.arrowIosDownwardOutline,
                                    color: HexColor('#0063F8').withOpacity(0.5),
                                  ),
                                  hintText: 'Kabupaten',
                                  obscureText: false,
                                  passwordVisibility: false,
                                  controller: sessionController,
                                  textEditingController: sessionController.regencyController,
                                  returnValidation: (val) {
                                    if (val!.isEmpty) {
                                      return "Kabupaten harus dipilih";
                                    }
                                    return null;
                                  },
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
                                                          fontWeight: FontWeight.normal,
                                                        )),
                                                  ),
                                                )),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                            color: Colors.white)));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AirenTextFormFieldBase(
                                  enabled: (sessionController.selectedRegency.isEmpty) ? false : true,
                                  textInputType: TextInputType.none,
                                  suffixIcon: Icon(
                                    EvaIcons.arrowIosDownwardOutline,
                                    color: HexColor('#0063F8').withOpacity(0.5),
                                  ),
                                  hintText: 'Kecamatan',
                                  obscureText: false,
                                  passwordVisibility: false,
                                  controller: sessionController,
                                  textEditingController: sessionController.districtController,
                                  returnValidation: (val) {
                                    if (val!.isEmpty) {
                                      return "Kecamatan harus dipilih";
                                    }
                                    return null;
                                  },
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
                                                          fontWeight: FontWeight.normal,
                                                        )),
                                                  ),
                                                )),
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                            color: Colors.white)));
                                  },
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
                                    return "Detail alamat harus diisi";
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
