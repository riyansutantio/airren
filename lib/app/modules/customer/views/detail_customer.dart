import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/customer/customerModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../utils/willPopCallBack.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/customer_controller.dart';
import '../providers/customer_provider.dart';

class CustomerDetailView extends GetView<CustomerController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CustomerController dataCustomerController =
      Get.put(CustomerController(p: CustomerProviders()));

  int? admin;

  CustomerDetailView({required this.admin});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          willPopCallbackWithFunc(func: controller.clearCondition()),
      child: SafeArea(
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
                        'Detail Pelanggan',
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
                              Get.to(ErrorHandlingView());
                            },
                            child: const Icon(EvaIcons.bellOutline,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 19, right: 20),
                        child: GestureDetector(
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              } else {
                                dataCustomerController.updateManageCus(
                                    name: dataCustomerController
                                        .nameDetailController.text,
                                    phoneNumber: dataCustomerController
                                        .phoneDetailNumberCusController.text,
                                    address: dataCustomerController
                                        .addressDetailCusController.text,
                                    meter: dataCustomerController
                                        .meterDetailCusController.text);
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
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradientColorAirren)),
            child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width - 80,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 30, top: 24),
                                child: AirenTextFormFieldBase(
                                  suffixIcon: Icon(EvaIcons.gridOutline,
                                      color: HexColor('#0063F8')),
                                  textInputType: TextInputType.text,
                                  hintText: 'Nama Invoice',
                                  obscureText: false,
                                  passwordVisibility: false,
                                  controller: dataCustomerController,
                                  textEditingController: dataCustomerController
                                      .uniqueIdDetailCusController,
                                  returnValidation: (val) {
                                    if (val!.isEmpty) {
                                      return "Nama administrator PAM harus diisi";
                                    } else if (val.length < 3) {
                                      return "Nama administrator PAM harus lebih dari 3";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                dataCustomerController.getPdf(
                                  dataCustomerController
                                      .uniqueIdDetailCusController.text,
                                  dataCustomerController
                                      .nameDetailController.text,
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.2),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      gradient: LinearGradient(
                                          colors: gradientColorAirren),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                      width: 48,
                                      height: 48,
                                      child: Icon(
                                        EvaIcons.cloudDownloadOutline,
                                        color: HexColor('#ffffff'),
                                      ))),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 24),
                          child: AirenTextFormFieldBase(
                            suffixIcon: Icon(EvaIcons.personOutline,
                                color: HexColor('#0063F8')),
                            textInputType: TextInputType.text,
                            hintText: 'Nama Pelanggan',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: dataCustomerController,
                            textEditingController:
                                dataCustomerController.nameDetailController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Nama administrator PAM harus diisi";
                              } else if (val.length < 3) {
                                return "Nama administrator PAM harus lebih dari 3";
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
                            textEditingController: dataCustomerController
                                .addressDetailCusController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Alamat tidak valid";
                              } else if (val.isEmpty) {
                                return "Alamat harus diisi";
                              }
                              return null;
                            },
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
                            textEditingController: dataCustomerController
                                .phoneDetailNumberCusController,
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
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Nomor HP harus diisi";
                              } else if (val.length < 7) {
                                return "Nomor HP tidak valid";
                              } else if (val.length > 14) {
                                return "Nomor HP tidak valid";
                              } else if (val[0] == "0") {
                                return "Nomor HP tidak valid";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 24),
                          child: AirenTextFormFieldBase(
                            suffixIcon: Icon(EvaIcons.compassOutline,
                                color: HexColor('#0063F8')),
                            hintText: 'Posisi  Meter',
                            obscureText: false,
                            passwordVisibility: false,
                            controller: dataCustomerController,
                            textEditingController:
                                dataCustomerController.meterDetailCusController,
                            returnValidation: (val) {
                              if (val!.isEmpty) {
                                return "Meter tidak valid";
                              } else if (val.isEmpty) {
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
                              'Posisi meter saat pertama kali pelanggan ini ditambahkan',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793'),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        if (admin == 1)
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, left: 20, bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.white),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0, left: 25.0),
                                        child: Text(
                                          'Status Pelanggan',
                                          style: GoogleFonts.montserrat(
                                            color: HexColor('#707793'),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Obx(() => Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                                left: 25.0),
                                            child: Text(
                                              controller.isRadio.value == 1
                                                  ? 'Aktif'
                                                  : 'Nonaktif',
                                              style: GoogleFonts.montserrat(
                                                color: dataCustomerController
                                                            .isRadio.value ==
                                                        1
                                                    ? HexColor('#05C270')
                                                    : HexColor('#FF3B3B'),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset('assets/edit.svg'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, left: 20, bottom: 16),
                              child: GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(Obx(() => Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(40),
                                              topLeft: Radius.circular(40)),
                                          color: Colors.white,
                                        ),
                                        child: Wrap(
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0),
                                                  child: Container(
                                                    width: 70,
                                                    height: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  40)),
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30.0),
                                                  child: Text(
                                                    'Status Pengelola',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#3C3F58'),
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: dataCustomerController
                                                              .isRadio.value ==
                                                          1
                                                      ? SvgPicture.asset(
                                                          'assets/activecustomer.svg')
                                                      : SvgPicture.asset(
                                                          'assets/deactivecustomer.svg'),
                                                  title: Text(
                                                    'Aktif',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#707793'),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Entry meter dapat melakukan pencatatan meter pada pelanggan ini',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#707793'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    dataCustomerController
                                                        .isRadio.value = 0;

                                                    if (dataCustomerController
                                                            .isRadio.value ==
                                                        0) {
                                                      dataCustomerController
                                                          .isRadio.value = 1;
                                                    } else {
                                                      dataCustomerController
                                                          .isRadio.value = 0;
                                                    }
                                                    logger.w(
                                                        dataCustomerController
                                                            .isRadio.value);
                                                  },
                                                ),
                                                ListTile(
                                                  leading: dataCustomerController
                                                              .isRadio.value ==
                                                          0
                                                      ? SvgPicture.asset(
                                                          'assets/activecustomer.svg')
                                                      : SvgPicture.asset(
                                                          'assets/deactivecustomer.svg'),
                                                  title: Text(
                                                    'Nonaktif',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#707793'),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    'Tidak diperbolehkan untuk masuk ke aplikasi',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#707793'),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    dataCustomerController
                                                        .isRadio.value = 1;

                                                    if (dataCustomerController
                                                            .isRadio.value ==
                                                        0) {
                                                      dataCustomerController
                                                          .isRadio.value = 1;
                                                    } else {
                                                      dataCustomerController
                                                          .isRadio.value = 0;
                                                    }
                                                    logger.w(
                                                        dataCustomerController
                                                            .isRadio.value);
                                                  },
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 40.0, top: 32),
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
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: Text('Batal',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              color: HexColor(
                                                                  '#0063F8'),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: HexColor(
                                                                  '#0063F8')
                                                              .withOpacity(0.2),
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 20,
                                                                right: 20,
                                                                bottom: 10,
                                                                top: 10),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.back();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: Text('Simpan',
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        decoration: BoxDecoration(
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                offset: Offset(
                                                                    0.0, 8.0),
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        99,
                                                                        248,
                                                                        0.2),
                                                                blurRadius: 24,
                                                              ),
                                                            ],
                                                            color: HexColor(
                                                                '#0063F8'),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
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
                                      )));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.16),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(16),
                                      color: Colors.white),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                                left: 25.0),
                                            child: Text(
                                              'Status Pelanggan',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Obx(() => Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0,
                                                    bottom: 8.0,
                                                    left: 25.0),
                                                child: Text(
                                                  controller.isRadio.value == 1
                                                      ? 'Aktif'
                                                      : 'Nonaktif',
                                                  style: GoogleFonts.montserrat(
                                                    color:
                                                        dataCustomerController
                                                                    .isRadio
                                                                    .value ==
                                                                1
                                                            ? HexColor(
                                                                '#05C270')
                                                            : HexColor(
                                                                '#FF3B3B'),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                            SvgPicture.asset('assets/edit.svg'),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        (admin == 1)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    right: 20.0, left: 20, top: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/deletedisable.svg'),
                                    ElevatedButton(
                                        onPressed: () {
                                          dataCustomerController.isRadio.value =
                                              dataCustomerController
                                                  .isRadio.value;
                                        },
                                        child: Ink(
                                          padding: const EdgeInsets.only(
                                              right: 15, left: 15),
                                          decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  offset: Offset(0.0, 8.0),
                                                  color: Color.fromRGBO(
                                                      0, 99, 248, 0.2),
                                                  blurRadius: 24,
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                  colors: gradientColorAirren),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))))
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0,
                                    right: 20,
                                    left: 20,
                                    bottom: 8.0),
                                child: buildElevatedButtonCustom(context),
                              )
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
      ),
    );
  }

  ElevatedButton buildElevatedButtonCustom(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return;
          } else {
            dataCustomerController.updateManageCus(
                name: dataCustomerController.nameDetailController.text,
                phoneNumber:
                    dataCustomerController.phoneDetailNumberCusController.text,
                address: dataCustomerController.addressDetailCusController.text,
                meter: dataCustomerController.meterDetailCusController.text);
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
