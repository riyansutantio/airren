import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../controllers/account_controller.dart';
import '../providers/account_provider.dart';

class PamProfileView extends GetView {
  final AccountController accountController = Get.put(AccountController(accountProvider: AccountProvider()));
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      onTap: (){
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 20),
                        child: Icon(EvaIcons.arrowBack, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Detail Pams',
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
                              accountController.updatePamProfile();
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
          preferredSize: const Size.fromHeight(56),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                          child: AirenTextFormFieldBase(
                            textInputType: TextInputType.text,
                            suffixIcon: Icon(EvaIcons.dropletOutline, color: HexColor('#0063F8').withOpacity(0.5),),
                            hintText: 'Nama PAMS',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: accountController,
                            textEditingController: accountController.namePamController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Nama Pams harus diisi";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
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
                            controller: accountController,
                            textEditingController: accountController.provinceController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Provinsi harus dipilih";
                              }
                              return null;
                            },
                            onTap: () {
                              sessionController.getProvince();
                              Get.bottomSheet(Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sessionController.resultProvince.length,
                                      itemBuilder: (context, index) => GestureDetector(
                                        onTap: () {
                                          accountController.selectedProvince.value =
                                              sessionController.resultProvince[index].id.toString();
                                          accountController.provinceController.text =
                                          sessionController.resultProvince[index].name!;
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                          child: AirenTextFormFieldBase(
                            enabled: true,
                            textInputType: TextInputType.none,
                            suffixIcon: Icon(
                              EvaIcons.arrowIosDownwardOutline,
                              color: HexColor('#0063F8').withOpacity(0.5),
                            ),
                            hintText: 'Kabupaten',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: accountController,
                            textEditingController: accountController.regencyController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Kabupaten harus dipilih";
                              }
                              return null;
                            },
                            onTap: () async {
                              await sessionController.getRegency(
                                  id: accountController.selectedProvince.value);
                              Get.bottomSheet(Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sessionController.resultRegency.length,
                                      itemBuilder: (context, index) => GestureDetector(
                                        onTap: () {
                                          accountController.selectedRegency.value =
                                              sessionController.resultRegency[index].id.toString();
                                          accountController.regencyController.text =
                                          sessionController.resultRegency[index].name!;
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                          child: AirenTextFormFieldBase(
                            enabled: true,
                            textInputType: TextInputType.none,
                            suffixIcon: Icon(
                              EvaIcons.arrowIosDownwardOutline,
                              color: HexColor('#0063F8').withOpacity(0.5),
                            ),
                            hintText: 'Kecamatan',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: accountController,
                            textEditingController: accountController.districtController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Kecamatan harus dipilih";
                              }
                              return null;
                            },
                            onTap: () async {
                              await sessionController.getDistrict(
                                  id: accountController.selectedRegency.value);
                              Get.bottomSheet(Container(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: sessionController.resultDistrict.length,
                                      itemBuilder: (context, index) => GestureDetector(
                                        onTap: () {
                                          accountController.selectedDistrict.value =
                                              sessionController.resultDistrict[index].id.toString();
                                          accountController.districtController.text =
                                          sessionController.resultDistrict[index].name!;
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
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                          child: AirenTextFormFieldBase(
                            textInputType: TextInputType.text,
                            hintText: 'Detail Alamat',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: accountController,
                            textEditingController: accountController.addressDetailController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Detail alamat harus diisi";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                          child: buildElevatedButtonCustom(),
                        )
                      ],
                    ),
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
            accountController.updatePamProfile();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.0, 8.0),
                color: Color.fromRGBO(0, 99, 248, 0.2),
                blurRadius: 24,
              ),
            ],
            gradient: LinearGradient(colors: gradientColorAirren),
            borderRadius: BorderRadius.circular(10)
          ),
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
