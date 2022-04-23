import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

class AirenTextFormFieldBase extends StatelessWidget {
  const AirenTextFormFieldBase(
      {Key? key,
      required this.textEditingController,
      required this.controller,
      required this.obscureText,
      this.hintText,
      required this.passwordVisibility,
      this.suffixIcon,
      this.prefixText2,
      this.textInputFormatter,
      this.returnValidation,
      this.logic,
      this.textInputAction,
      this.textInputType,
      this.prefix,
      this.prefixText,
      this.enabled,
      this.onChange,
      this.onTap,
      this.suffix,
      this.autofocus=false,
      this.onSubmit})
      : super(key: key);

  final TextEditingController textEditingController;
  final GetxController controller;
  final bool obscureText;
  final bool? enabled;
  final String? hintText;
  final Widget? prefixText;
  final bool passwordVisibility;
  final Widget? suffixIcon;
  final Widget? prefix;
  final String? prefixText2;
  final Widget? suffix;
  final List<TextInputFormatter>? textInputFormatter;
  final String? Function(String? val)? returnValidation;
  final String? Function(String? val)? onSubmit;
  final String? Function(String? val)? onChange;
  final String? logic;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final VoidCallback? onTap;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChange,
      enabled: enabled,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      validator: returnValidation,
      inputFormatters: textInputFormatter,
      controller: textEditingController,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixText: prefixText2,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: GoogleFonts.montserrat(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        prefixStyle: const TextStyle(color: Colors.black),
        prefixIcon: prefixText,
        labelStyle: GoogleFonts.montserrat(
          color: HexColor('#707793'),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          color: HexColor('#707793'),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HexColor('#F0F5F9'),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 3,
            color: HexColor('#F0F5F9'),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: HexColor('#F0F5F9'),
        suffixIcon: suffixIcon,
        suffix: suffix,
        prefix: prefix,
      ),
      style: GoogleFonts.montserrat(
        color: HexColor('#707793'),
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter =
        NumberFormat.simpleCurrency(locale: "id", decimalDigits: 0);

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText.replaceAll('Rp', ''),
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}
