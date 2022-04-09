import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
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

class ChargeView extends GetView {
  final AccountController accountController = Get.put(AccountController(accountProvider: AccountProvider()));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 20),
                        child: Icon(EvaIcons.arrowBack, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Denda',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 16),
                      child: GestureDetector(
                          onTap: () {
                            Get.to(ErrorHandlingView());
                          },
                          child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 19, right: 20),
                      child: GestureDetector(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              accountController.addCharge();
                            }
                          },
                          child: const Icon(EvaIcons.checkmark, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
            decoration:
                BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
          ),
          preferredSize: Size.fromHeight(56),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                      child: AirenTextFormFieldBase(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/tarif.svg'),
                        ),
                        textInputType: TextInputType.number,
                        hintText: 'Nominal',
                        obscureText: false,
                        passwordVisibility: false,
                        controller: accountController,
                        textEditingController: accountController.amountChargeController,
                        prefixText: SizedBox(
                          child: Center(
                            widthFactor: 0.0,
                            child: Text(
                              'Rp',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793'),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        textInputFormatter: [CurrencyTextInputFormatter(locale: 'id', symbol: '', decimalDigits: 0)],
                        returnValidation: (val) {
                          if (val!.isEmpty) {
                            return "Nominal harus diisi";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Periode denda adalah bulanan',
                            style: GoogleFonts.montserrat(
                              color: HexColor('#707793'),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                      child: AirenTextFormFieldBase(
                        suffixIcon: Icon(
                          EvaIcons.arrowIosDownwardOutline,
                          color: HexColor('#0063F8'),
                        ),
                        textInputType: TextInputType.none,
                        hintText: 'Jatuh Tempo',
                        obscureText: false,
                        passwordVisibility: false,
                        controller: accountController,
                        textEditingController: accountController.dueDateController,
                        returnValidation: (val) {
                          if (val!.isEmpty) {
                            return "Jatuh tempo harus diisi";
                          }
                          return null;
                        },
                        onTap: () {
                          Get.bottomSheet(Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 70,
                                        height: 5,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40)),
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 31,
                                        itemBuilder: (context, index) => GestureDetector(
                                              onTap: () {
                                                accountController.dueDateController.text = 'Tanggal ${index + 1}';
                                                Get.until((route) => Get.isBottomSheetOpen == false);
                                              },
                                              child: ListTile(
                                                title: Text('Tanggal ${index + 1}',
                                                    style: GoogleFonts.montserrat(
                                                      color: HexColor('#707793'),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    )),
                                              ),
                                            )),
                                  ],
                                ),
                              ),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                  color: Colors.white)));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
                      child: buildElevatedButtonCustom(context),
                    )
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white)),
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButtonCustom(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            accountController.addCharge();
          }
        },
        child: Ink(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(0.0, 8.0),
              color: Color.fromRGBO(0, 99, 248, 0.2),
              blurRadius: 24,
            ),
          ], gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(10)),
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
