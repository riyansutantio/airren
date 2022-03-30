import 'package:airen/app/modules/session/controllers/session_controller.dart';
import 'package:airen/app/modules/session/providers/session_provider.dart';
import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:airen/app/modules/session/views/widget_bottom_nav_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_timer/flutter_otp_timer.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../utils/constant.dart';

class OtpView extends GetView {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBarSession(
          buttonBack: Row(
            children: const [
              Icon(EvaIcons.arrowBack, color: Colors.white),
              SizedBox(
                width: 15,
              )
            ],
          ),
          title: 'OTP Verification code',
          firstSubtitle: 'Mohon masukkan kode OTP yang sudah ',
          secondSubtitle: 'kami kirimkan ke nomor Anda'),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0, bottom: 20),
                      child: OTPTextField(
                        otpFieldStyle: OtpFieldStyle(borderColor: Colors.blue),
                        length: 5,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 50,
                        style: GoogleFonts.montserrat(
                          color: HexColor('#707793'),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (val) {
                          print('yang ke $val');
                        },
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldStyle: FieldStyle.box,
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0, bottom: 20),
                      child: buildElevatedButtonCustom(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 20.0, right: 8.0, bottom: 20),
                      child: Center(
                        child: Text(
                          'OTP salah. Anda punya 3 kesempatan lagi.',
                          style: GoogleFonts.montserrat(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 48,
                        width: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: HexColor('#FF8801').withOpacity(0.1),
                        ),
                        child: Center(
                          child: Text(
                            '00 : 20',
                            style: GoogleFonts.montserrat(
                              color: HexColor('#FF8801'),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
      ),
      bottomNavigationBar: buildBottomNav(firstText: 'Belum mendapatkan?', secondText: 'Kirim ulang'),
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
                'Konfirmasi',
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
