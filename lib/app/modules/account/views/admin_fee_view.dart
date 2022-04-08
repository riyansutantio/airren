import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/account_controller.dart';
import '../providers/account_provider.dart';

class AdminFeeView extends GetView {
  final AccountController accountController = Get.put(AccountController(accountProvider: AccountProvider()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: const Icon(EvaIcons.arrowBack), color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Biaya admin',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Get.to(ErrorHandlingView());
                        },
                        child: const Icon(EvaIcons.bellOutline, color: Colors.white)),

                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            accountController.adminFee();
                          }
                        },
                        child: const Icon(EvaIcons.checkmark, color: Colors.white)),
                    const SizedBox(width: 10),
                  ],
                )
              ],
            ),
          ),
          decoration:
          BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
        child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AirenTextFormFieldBase(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/tarif.svg', color: Colors.blue),
                        ),
                        textInputType: TextInputType.number,
                        hintText: 'Nominal',
                        obscureText: false,
                        passwordVisibility: false,
                        controller: accountController,
                        textEditingController: accountController.adminFeeController,
                        textInputFormatter: [
                          CurrencyTextInputFormatter(locale: 'id', symbol: 'Rp. ', decimalDigits: 0)
                        ],
                        returnValidation: (val) {
                          if (val!.isEmpty) {
                            return "Nominal harus diisi";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Selalu dibebankan kepada pelanggan pada setiap tagihan yang sudah diterbitkan',
                        style: GoogleFonts.montserrat(
                          color: HexColor('#707793'),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: buildElevatedButtonCustom(),
                    )
                  ],
                ),
              ),
            ),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                color: Colors.white)),
      ),
    );
  }
  ElevatedButton buildElevatedButtonCustom() {
    return ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            accountController.adminFee();
          }
        },
        child: Ink(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.0, 8.0),
                color: Color.fromRGBO(0, 99, 248, 0.2),
                blurRadius: 24,
              ),
            ],
            gradient: LinearGradient(colors: gradientColorAirren),
            borderRadius: BorderRadius.circular(10)
          ),
          child: SizedBox(
            height: 48,
            width: double.infinity,
            child: Center(
              child: Text(
                'Simpan',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  }

}
