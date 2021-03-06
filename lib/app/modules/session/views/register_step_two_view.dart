import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../controllers/session_controller.dart';
import '../providers/session_provider.dart';

class RegisterStepTwoView extends GetView {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBarSession(
            buttonBack: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
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
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
            child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AirenTextFormFieldBase(
                            textInputType: TextInputType.text,
                            hintText: 'Nama Administrator (Pengelola)',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: sessionController,
                            textEditingController: sessionController.nameAdminPamController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Nama Administrator harus terisi";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AirenTextFormFieldBase(
                            textInputType: TextInputType.phone,
                            hintText: 'Phone Number',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: sessionController,
                            textEditingController: sessionController.phoneNumberController,
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
                                return "Nomor hp harus diisi";
                              } else if (val.length < 7) {
                                return "Nomor hp tidak valid";
                              } else if (val.length > 14) {
                                return "Nomor hp tidak valid";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AirenTextFormFieldBase(
                            enabled: false,
                            textInputType: TextInputType.phone,
                            hintText: 'email',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: sessionController,
                            textEditingController: sessionController.emailPamController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: buildElevatedButtonCustom(),
                        )
                      ],
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                    color: Colors.white)),
          ),
        ));
  }

  Widget buildElevatedButtonCustom() {
    return RoundedLoadingButton(
      height: 48,
      color: Colors.white,
      valueColor: Colors.blue,
      key: const Key('btnControllerRegister'),
      controller: sessionController.btnControllerRegister,
      onPressed: () {
        if (!_formKey.currentState!.validate()) {
         return sessionController.btnControllerRegister.stop();
        } else {
          // sessionController.btnControllerRegister.stop();
          sessionController.register();
        }
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(15)),
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
    );
  }
}
