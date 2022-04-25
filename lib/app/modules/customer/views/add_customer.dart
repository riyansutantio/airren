import 'package:airen/app/modules/data_master/controllers/data_master_controller.dart';
import 'package:airen/app/modules/data_master/providers/master_data_provider.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/constant.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/customer_controller.dart';
import '../providers/customer_provider.dart';

class AddCustomer extends GetView<CustomerController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CustomerController dataCustomerController = Get.put(
    CustomerController(p: CustomerProviders()),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor:  HexColor('#5433FF'), //or set color with: Color(0xFF0000FF)
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
                      'Tambah Pelanggan',
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
                              dataCustomerController.addCustomers();
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
              height: double.infinity,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 40),
                        child: AirenTextFormFieldBase(
                          suffixIcon: Icon(EvaIcons.personOutline,
                              color: HexColor('#0063F8')),
                          textInputType: TextInputType.text,
                          hintText: 'Nama Pelanggan',
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
                          suffixIcon: Icon(EvaIcons.pinOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Alamat',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.addressCusController,
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 24),
                        child: AirenTextFormFieldBase(
                          textInputType: TextInputType.phone,
                          suffixIcon: Icon(EvaIcons.phoneOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Nomor HP',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.phoneNumberCusController,
                          prefixText: SizedBox(
                            child: Center(
                              widthFactor: 0.0,
                              child: Text(
                                '62',
                                style: GoogleFonts.montserrat(
                                  color: HexColor('#707793'),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 24),
                        child: AirenTextFormFieldBase(textInputType: TextInputType.number,
                          suffixIcon: Icon(EvaIcons.compassOutline,
                              color: HexColor('#0063F8')),
                          hintText: 'Posisi  Meter',
                          obscureText: false,
                          passwordVisibility: false,
                          controller: dataCustomerController,
                          textEditingController:
                              dataCustomerController.meterCusController,
                          returnValidation: (val) {
                            if (val!.isEmpty) {
                              return "Meter harus diisi";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Posisi meter saat pertama kali pelanggan akan ditambahkan',
                            style: GoogleFonts.montserrat(
                              color: HexColor('#707793'),
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
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
            dataCustomerController.addCustomers();
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
