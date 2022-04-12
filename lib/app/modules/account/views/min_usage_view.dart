import 'package:airen/app/modules/account/controllers/account_controller.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';

class MinUsageView extends GetView<AccountController> {
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
                      'Minimal Penggunaan',
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
                              accountController.addMinUsage();
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
                        child: AirenTextFormFieldBase(
                          suffixIcon: Icon(EvaIcons.compassOutline, color: HexColor('#0063F8').withOpacity(0.5),),
                          textInputType: TextInputType.number,
                          hintText: 'Posisi meter',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: accountController,
                          textEditingController: accountController.meterPositionController,
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Posisi meter harus diisi";
                            } else if (val.length > 10) {
                              return "Posisi meter maksimal 9999999999";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 12),
                        child: Text(
                          'Bila penggunaan air oleh pelanggan kurang dari angka di atas, maka tetap dihitung sesuai angka yang telah diinputkan',
                          style: GoogleFonts.montserrat(
                            color: HexColor('#707793'),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 24),
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
      ),
    );
  }

  ElevatedButton buildElevatedButtonCustom() {
    return ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            accountController.addMinUsage();
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
