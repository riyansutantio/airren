import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';

PreferredSize buildAppBarSession(
    {Widget? buttonBack = const SizedBox(), String? title, String? firstSubtitle, String? secondSubtitle}) {
  return PreferredSize(
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
                      buttonBack!,
                      Text(
                        '$title',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '$firstSubtitle',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '$secondSubtitle',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
