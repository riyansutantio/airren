import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../utils/constant.dart';
import '../../../../widgets/loginTextFormFieldBase.dart';
import '../../controllers/transaction_controller.dart';
import '../../provider/transaction_provider.dart';

class AddIncome extends GetView<TransactionController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TransactionController dataCustomerController = Get.put(
    TransactionController(p: TransactionProvider()),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor:  HexColor('#5433FF'), statusBarBrightness: Brightness.dark,
  systemNavigationBarDividerColor:  HexColor('#5433FF'), 
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
                      'Tambah Pemasukan',
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
                              dataCustomerController.addIncomes();
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
        preferredSize: Size.fromHeight(56),
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
                            left: 20.0, right: 20, top: 40),
                        child: AirenTextFormFieldBase(
                          suffixIcon: Icon(EvaIcons.editOutline,
                              color: HexColor('#0063F8')),
                          textInputType: TextInputType.text,
                          hintText: 'Nama',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.nameController,
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Nama  harus diisi";
                            } else if (val.length < 3) {
                              return "Nama  harus lebih dari 3 karakter";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 24),
                        child: AirenTextFormFieldBase(
                          textInputType: TextInputType.number,
                          suffixIcon: Icon(EvaIcons.pricetagsOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Nominal',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.nominalController,
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
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Nominal harus diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 24),
                        child: AirenTextFormFieldBase(
                          suffixIcon: Icon(EvaIcons.fileTextOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Catatan Singkat',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.deskriptionController,
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Deskripsi harus diisi";
                            }
                            return null;
                          },
                        ),
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
            dataCustomerController.addIncomes();
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
