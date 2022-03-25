import 'package:airen/app/modules/session/views/widget_appbar_session.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';

class PaymentView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarSession(
          buttonBack: Row(
            children: [
              Icon(EvaIcons.arrowBack, color: Colors.white),
              SizedBox(
                width: 15,
              )
            ],
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
                    child: Container(
                        height: 400,
                        color: HexColor('#F0F5F9'), width: 200),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('IDR 60.000',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#0063F8'),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
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
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#0063F8').withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],                          borderRadius: BorderRadius.circular(20.0), color: Colors.white),
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
                              Image.asset('assets/bca.png'),
                              Text('9988 6655 2289',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#0063F8'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('atas nama Airen',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#707793'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back),
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
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                            color: Colors.white))
                  ],
                ),
              ],
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
      ),
    );
  }
}
