import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/constant.dart';
import '../../../../widgets/loginTextFormFieldBase.dart';
import '../../controllers/transaction_controller.dart';
import '../../provider/transaction_provider.dart';

class FirstBlance extends GetView<TransactionController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TransactionController dataCustomerController = Get.put(
    TransactionController(p: TransactionProvider()),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#5433FF'),
      statusBarBrightness: Brightness.dark,
      systemNavigationBarDividerColor: HexColor('#5433FF'),
    ));
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
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 20.0, top: 15, bottom: 19, right: 20),
                        child: Icon(EvaIcons.arrowBack, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Tambah Saldo Awal',
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
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 15, bottom: 19, right: 16),
                      child: GestureDetector(
                          onTap: () {
                            // Get.to(ErrorHandlingView());
                          },
                          child: const Icon(EvaIcons.bellOutline,
                              color: Colors.white)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 19, right: 20),
                      child: GestureDetector(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              Get.bottomSheet(Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      topLeft: Radius.circular(40)),
                                  color: Colors.white,
                                ),
                                child: Wrap(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12.0),
                                          child: Container(
                                            width: 70,
                                            height: 5,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(40)),
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: SvgPicture.asset(
                                              'assets/quation.svg'),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 24.0),
                                          child: Text(
                                            'Konfirmasi',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#3C3F58'),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16.0),
                                          child: Text(
                                            'Pastikan nominal saldo awal yang di\n tulis sama dengan jumlah uang cash',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 32.0, bottom: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text('Batal',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: HexColor(
                                                              '#0063F8'),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: HexColor('#0063F8')
                                                          .withOpacity(0.2),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10,
                                                            top: 10),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  dataCustomerController
                                                      .addFirstBlances();
                                                  Get.back();
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text('Ya, benar',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          HexColor('#0063F8'),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10,
                                                            top: 10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                            }
                          },
                          child: const Icon(EvaIcons.checkmark,
                              color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
                boxShadow: const []),
          ),
          preferredSize: Size.fromHeight(Get.height * 0.1),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: gradientColorAirren)),
          child: Container(
              height: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 24),
                        child: AirenTextFormFieldBase(
                          textInputFormatter: [
                            CurrencyTextInputFormatter(
                                locale: 'id', symbol: '', decimalDigits: 0)
                          ],
                          textInputType: TextInputType.number,
                          suffixIcon: Icon(EvaIcons.pricetagsOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Nominal',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController: dataCustomerController
                              .nominalFirstBlanceController,
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
                          onChange: (s) {},
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Nominal harus diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Pastikan nominal saldo awal yang anda tulis sama\ndengan jumlah uang cash",
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: HexColor('#707793').withOpacity(0.7)),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, right: 20, left: 20, bottom: 8.0),
                        child: buildElevatedButtonCustom(),
                      ),
                    ],
                  ),
                ),
              ),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
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
            Get.bottomSheet(Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)),
                color: Colors.white,
              ),
              child: Wrap(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Container(
                          width: 70,
                          height: 5,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: SvgPicture.asset('assets/quation.svg'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Text(
                          'Konfirmasi',
                          style: GoogleFonts.montserrat(
                            color: HexColor('#3C3F58'),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Pastikan nominal saldo awal yang di\n tulis sama dengan jumlah uang cash',
                          style: GoogleFonts.montserrat(
                            color: HexColor('#707793'),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Batal',
                                      style: GoogleFonts.montserrat(
                                        color: HexColor('#0063F8'),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: HexColor('#0063F8').withOpacity(0.2),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                dataCustomerController.addFirstBlances();
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Text('Ya, benar',
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: HexColor('#0063F8'),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10, top: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
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
              borderRadius: BorderRadius.circular(10)),
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
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }
}
