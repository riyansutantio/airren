import 'package:airen/app/modules/session/controllers/session_controller.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/modules/session/views/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import 'widget_appbar_session.dart';

class LoginView extends GetView<SessionController> {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSession(
          title: 'Autentikasi',
          firstSubtitle: 'Silakan masuk atau daftar ke aplikasi ',
          secondSubtitle: 'dengan akun Google Anda'),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    sessionController.googleSignOut();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: SvgPicture.asset('assets/airrenof.svg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 15.0),
                  child: GestureDetector(
                    onTap: (){
                      sessionController.signInWithGoogle();
                    },
                    child: Container(
                      height: 50,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: HexColor('#0063F8').withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ], borderRadius: BorderRadius.circular(15), color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/gicon.svg'),
                            const SizedBox(width: 8),
                            Text('Lanjutkan dengan Google', style: GoogleFonts.montserrat(
                              color: HexColor('#0063F8'),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ))
                          ],
                        )),
                  ),
                ),
                Image.asset('assets/wavebottom.png', width: double.infinity,),
              ],
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
      ),
      // bottomNavigationBar:
      //     buildBottomNav(firstText: 'Belum punya akun?', secondText: 'Daftar sekarang', function: () => Get.to(RegisterView())),
    );
  }

  ElevatedButton buildElevatedButtonCustom() {
    return ElevatedButton(
        onPressed: () {
          Get.to(OtpView());
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
