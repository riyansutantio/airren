import 'package:airen/app/modules/account/controllers/account_controller.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';

class AboutUsView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0063F8'),
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 5.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: const Icon(EvaIcons.arrowBack), color: Colors.white),
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
                GestureDetector(
                  onTap: (){
                    Get.to(ErrorHandlingView());
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(EvaIcons.bellOutline, color: Colors.white)
                   )
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: [
              Image.asset('assets/abtappbar.png', fit: BoxFit.cover),
              Image.asset('assets/logoof.png', width: 150.0),
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
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10, bottom: 10),
                child: Html(
                  customTextAlign: (_) => TextAlign.justify,
                    data: """${controller.resultAboutUs.value.content}""",
                    customTextStyle: (node, TextStyle baseStyle) {
                      return baseStyle.merge(TextStyle(color: HexColor('#707793'), fontFamily: 'Montserrat', fontSize: 14));
                    }),
              ),
              // Text('${controller.resultTermAboutUsHelp.value.content}')
            ],
          ),
        ),
      ),
    );
  }
}
