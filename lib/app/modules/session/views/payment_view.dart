import 'package:airen/app/modules/session/views/login_view.dart';
import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/constant.dart';
import '../../../utils/willPopCallBack.dart';
import '../controllers/session_controller.dart';
import '../providers/session_provider.dart';

class PaymentView extends GetView {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallbackDc(func: sessionController.googleSignOut()),
      child: Scaffold(
        appBar: buildAppBarSession(
            buttonBack: GestureDetector(
              onTap: () async {
                await sessionController.googleSignOut();
                Get.back();
              },
              child: Row(
                children: const [
                  Icon(EvaIcons.arrowBack, color: Colors.white),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            title: 'Payment required',
            firstSubtitle: 'Anda diharuskan membayar terlebih',
            secondSubtitle: 'dahulu saat menggunakan pertama kali'),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              child: Stack(
                children: [
                  Positioned(
                    bottom: -130,
                    right: -200,
                    child: Transform(
                      transform: Matrix4.rotationZ(0.9),
                      child: Container(height: 400, color: HexColor('#F0F5F9'), width: 200),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    logger.i(sessionController.boxPrice.read(priceInit));
                                  },
                                  child: Text('${sessionController.idrFormatter(value: sessionController.boxPrice.read(priceInit))}',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#0063F8'),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                Text('Lisensi untuk 30 hari',
                                    style: GoogleFonts.montserrat(
                                      color: HexColor('#707793'),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                            Image.asset('assets/license.png')
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: HexColor('#0063F8').withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ], borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text('Mohon transfer sejumlah sekian ke',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      Text('nomor rekening di bawah',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset('assets/bri.svg'),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Text('9988 6655 2289',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#0063F8'),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Text('A.n Bangun Karya Mandiri',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset('assets/mandiri.svg'),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Text('9988 6655 2289',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#0063F8'),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Text('A.n Bangun Karya Mandiri',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          sessionController.sendWhatsAppConfirm(phone: '6287847536123', bill: '40000', nomerOrder: '1212d3242', time: 'hari ini');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/wa.svg'),
                                  Center(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: ' Konfirmasi lewat WA',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ])),
                                  ),
                                ],
                              ),
                              height: 48.0,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [HexColor('#23C861'), HexColor('#118578')]),
                                  borderRadius:
                                      const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                  color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white)),
        ),
      ),
    );
  }
}
