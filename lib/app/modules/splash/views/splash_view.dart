import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                SizedBox(),
              ],
            ),
            Image.asset('assets/logosplash.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/logoname.png'),
                  const SizedBox(height: 10),
                  Text(
                    'By Bangun Karya Mandiri',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
      ),
    );
  }
}
