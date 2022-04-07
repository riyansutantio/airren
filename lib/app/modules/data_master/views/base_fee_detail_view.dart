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
import '../controllers/data_master_controller.dart';
import '../providers/master_data_provider.dart';

class BaseFeeDetailView extends GetView {
  final DataMasterController dataMasterController = Get.put(DataMasterController(masterDataProvider: MasterDataProvider()));
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
                        'Detail tarif dasar air',
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
                        onTap: () {
                          Get.to(ErrorHandlingView());
                        },
                        child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
                    const SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {
                          dataMasterController.updateBaseFee();
                        },
                        child: const Icon(EvaIcons.checkmark, color: Colors.white)),
                    const SizedBox(width: 8),
                  ],
                ),
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
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 25),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AirenTextFormFieldBase(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('assets/tarif.svg'),
                          ),
                          textInputType: TextInputType.number,
                          hintText: 'Nominal',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataMasterController,
                          textEditingController: dataMasterController.amountDetailController,
                          textInputFormatter: [CurrencyTextInputFormatter(locale: 'id', symbol: '', decimalDigits: 0)],
                          prefixText: SizedBox(
                            child: Center(
                              widthFactor: 0.0,
                              child: Text(
                                'Rp',
                                style: GoogleFonts.montserrat(
                                  color: HexColor('#707793'),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
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
                        child: AirenTextFormFieldBase(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset('assets/meter.svg', color: Colors.blue),
                          ),
                          textInputType: TextInputType.number,
                          hintText: 'Pada posisi meter',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataMasterController,
                          textEditingController: dataMasterController.meterDetailPositionController,
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Meter harus diisi";
                            } else if (val.length >= 10) {
                              return "Posisi meter maksimal 9999999999";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                                      color: Colors.white,
                                    ),
                                    child: Wrap(
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: SvgPicture.asset('assets/deletemanage.svg'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Anda Yakin ?',
                                                style: GoogleFonts.montserrat(
                                                  color: HexColor('#3C3F58'),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Data akan dihapus secara permanen.',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              'Benarkah ingin menghapusnya?',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
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
                                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      dataMasterController.deleteBaseFee();
                                                      Get.back();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Container(
                                                        child: Text('Ya, hapus',
                                                            style: GoogleFonts.montserrat(
                                                              color: Colors.white,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.bold,
                                                            )),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.red,
                                                        ),
                                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
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
                                },
                                child: SvgPicture.asset('assets/delete.svg')),
                            buildElevatedButtonCustom()
                          ],
                        ),
                      )
                    ],
                  ),
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
            dataMasterController.updateBaseFee();
          }
        },
        child: Ink(
          padding: EdgeInsets.only(right: 15, left: 15),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: gradientColorAirren), borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            height: 48,
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
            padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))));
  }
}
