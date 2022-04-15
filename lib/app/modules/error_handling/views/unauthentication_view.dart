import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constant.dart';
import '../../../utils/willPopCallBack.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';
import '../../session/views/widget_appbar_session.dart';

class UnauthenticationView extends GetView {
  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          willPopCallbackWithFunc(func: sessionController.googleDisconnect()).whenComplete(() => Get.offAllNamed(Routes.SESSION)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.25),
          child: AppBar(
            leading: const SizedBox(),
            elevation: 0,
            backgroundColor: HexColor('#0063F8'),
            flexibleSpace: Stack(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
                    ),
                    Positioned(top: -80, right: -15, child: SvgPicture.asset('assets/dot2.svg'))
                  ],
                ),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    sessionController.googleDisconnect().whenComplete(() => Get.offAllNamed(Routes.SESSION)),
                                icon: const Icon(EvaIcons.arrowBack),
                                color: Colors.white),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                'Tidak diperbolehkan',
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10.0),
                  Flexible(child: SvgPicture.asset('assets/unauth.svg')),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Text(
                        'Biasanya disebabkan karena keterlambatan dalam pembayaran atau bisa juga karena pelanggaran kebijakan privasi serta syarat dan ketentuan dari kami.',
                        style: GoogleFonts.montserrat(
                          color: HexColor('#707793'),
                          height: 1.5,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Image.asset(
                      'assets/wavebottom.png',
                      width: double.infinity,
                    ),
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
