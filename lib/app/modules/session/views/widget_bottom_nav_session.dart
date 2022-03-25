import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constant.dart';

Container buildBottomNav({String? firstText, String? secondText, VoidCallback? function}) {
  return Container(
      child: Center(
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: '$firstText',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          TextSpan(
              text: ' $secondText',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = function),
        ])),
      ),
      height: 60.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColorAirren),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.white));
}
