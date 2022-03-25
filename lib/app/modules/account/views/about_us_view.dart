import 'package:airen/app/modules/account/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AboutUsView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0063F8'),
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.arrow_back), color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Tentang airen',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/notif.png',
                  width: 30,
                )
              ],
            ),
          ),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Image.asset('assets/abtappbar.png', fit: BoxFit.cover),
              Image.asset('assets/logo.png', width: 150.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'version 1.0.0',
                  style: GoogleFonts.montserrat(
                    color: HexColor('#707793'),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Html(data: """${controller.resultAboutUs.value.content}"""),
              ),
              // Text('${controller.resultTermAboutUsHelp.value.content}')
            ],
          ),
        ),
      ),
    );
  }
}
