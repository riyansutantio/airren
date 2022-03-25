import 'package:airen/app/modules/session/controllers/session_controller.dart';
import 'package:airen/app/modules/session/views/register_view.dart';
import 'package:airen/app/modules/session/views/widget_bottom_nav_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import 'widget_appbar_session.dart';

class LoginView extends GetView {
  final SessionController sessionController = Get.put(SessionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSession(
          title: 'Sign In', firstSubtitle: 'Masuk dengan nomor HP yang sudah', secondSubtitle: 'Anda daftarkan'),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AirenTextFormFieldBase(
                      textInputType: TextInputType.phone,
                      suffix: Icon(
                        EvaIcons.phoneOutline,
                        color: HexColor('#0063F8'),
                      ),
                      hintText: 'Phone Number',
                      obscureText: false,
                      passwordVisibility: false,
                      controller: sessionController,
                      textEditingController: sessionController.phoneNumberController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: buildElevatedButtonCustom(),
                  )
                ],
              ),
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
      ),
      bottomNavigationBar:
          buildBottomNav(firstText: 'Belum punya akun?', secondText: 'Daftar sekarang', function: () => Get.to(RegisterView())),
    );
  }

  ElevatedButton buildElevatedButtonCustom() {
    return ElevatedButton(
        onPressed: () {},
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
