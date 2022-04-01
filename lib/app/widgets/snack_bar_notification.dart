import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

SnackbarController snackBarNotification({String? title, String? subTitle, String? titleText, String? messageText, Color? color}) {
  return Get.snackbar('$title', '$subTitle',
      colorText: Colors.white,
      titleText: Text(
        '$titleText',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      messageText: Text(
        '$messageText',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      icon: const Icon(EvaIcons.checkmark, color: Colors.white),
      backgroundColor: color,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 10,
      snackStyle: SnackStyle.GROUNDED,
      margin: const EdgeInsets.all(0));
}
