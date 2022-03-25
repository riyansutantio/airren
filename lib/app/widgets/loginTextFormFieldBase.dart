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
      this.validator, this.textInputAction, this.textInputType})
      : super(key: key);

  final TextEditingController textEditingController;
  final GetxController controller;
  final bool obscureText;
  final String? hintText;
  final bool passwordVisibility;
  final Widget? suffix;
  final List<TextInputFormatter>? textInputFormatter;
  final dynamic returnValidation;
  final String? logic;
  final Function? validator;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: returnValidation,
      inputFormatters: textInputFormatter,
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
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
      ),
      style: GoogleFonts.montserrat(
        color: HexColor('#707793'),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
