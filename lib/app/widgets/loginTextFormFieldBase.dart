import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AirenTextFormFieldBase extends StatelessWidget {
  const AirenTextFormFieldBase(
      {Key? key,
      required this.textEditingController,
      required this.controller,
      required this.obscureText,
      this.hintText,
      required this.passwordVisibility,
      this.suffix,
      this.textInputFormatter,
      this.returnValidation,
      this.logic,
      this.textInputAction,
      this.textInputType,
      this.prefix,
      this.prefixText,
      this.enabled})
      : super(key: key);

  final TextEditingController textEditingController;
  final GetxController controller;
  final bool obscureText;
  final bool? enabled;
  final String? hintText;
  final Widget? prefixText;
  final bool passwordVisibility;
  final Widget? suffix;
  final Widget? prefix;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String? val)? returnValidation;
  final String? logic;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: returnValidation,
      inputFormatters: textInputFormatter,
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorStyle: GoogleFonts.montserrat(
          color: Colors.red,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        prefixStyle: TextStyle(color: Colors.black),
        prefixIcon: prefixText,
        labelStyle: GoogleFonts.montserrat(
          color: HexColor('#707793'),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: HexColor('#F0F5F9'),
        suffixIcon: suffix,
        prefix: prefix,
      ),
      style: GoogleFonts.montserrat(
        color: HexColor('#707793'),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
