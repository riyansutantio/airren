import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

SnackbarController? snackBarNotification(
    {String? title, String? subTitle, String? titleText, String? messageText, Color? color}) {
  return Get.showSnackbar(GetSnackBar(
    icon: Icon(EvaIcons.checkmark),
    title: title,
  ));
}

SnackbarController? snackBarNotificationSuccess({String? title}) {
  return Get.showSnackbar(GetSnackBar(
    shouldIconPulse: false,
    padding: const EdgeInsets.all(25),
    snackStyle: SnackStyle.GROUNDED,
    backgroundColor: HexColor('#05C270'),
    icon: const Icon(EvaIcons.checkmark, color: Colors.white,),
    messageText: Text('$title', style: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),),
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 1),
  ));
}

SnackbarController? snackBarNotificationFailed({String? title}) {
  return Get.showSnackbar(GetSnackBar(
    shouldIconPulse: false,
    padding: const EdgeInsets.all(25),
    snackStyle: SnackStyle.GROUNDED,
    backgroundColor: HexColor('#FF3B3B'),
    icon: const Icon(EvaIcons.close, color: Colors.white,),
    messageText: Text('$title', style: GoogleFonts.montserrat(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),),
    duration: const Duration(seconds: 2),
    animationDuration: const Duration(seconds: 1),
  ));
}
