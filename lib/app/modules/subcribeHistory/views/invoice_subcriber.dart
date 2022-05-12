import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/history_subcriberModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../../printer/setting_printer.dart';
import '../controllers/history_controller.dart';
import '../controllers/invoice_sub_controller.dart';
import '../providers/history_providers.dart';

class SubcriberInvoice extends GetView<InvoiceSubcribe> {
  SubcriberInvoice({required this.data});
  historySub? data;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceSubcribe>(
      init: InvoiceSubcribe(p: HistorySubProviders(), data: data),
      builder: (controller) {
        return Scaffold(
            appBar: PreferredSize(
              child: Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(EvaIcons.arrowBack),
                              color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              'Invoice',
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
                              child: const Icon(EvaIcons.bellOutline,
                                  color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
                    boxShadow: const []),
              ),
              preferredSize: Size.fromHeight(Get.height * 0.1),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            SizedBox(
                                              width: 84,
                                              height: 84,
                                              child: Opacity(
                                                opacity: 0.1,
                                                child: CircleAvatar(
                                                  maxRadius: 30,
                                                  backgroundColor:
                                                      HexColor('#0063F8'),
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  width: 48,
                                                  height: 54,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 48,
                                                        height: 54,
                                                        child: SvgPicture.asset(
                                                          'assets/airrenof.svg',
                                                          width: 48,
                                                          height: 54,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Airren",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 16,
                                                  color: HexColor('#3C3F58'),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "Kecamatan Karanganyar,\nKabupaten Karanganyar,\nProvinsi Jawa Tengah",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#707793')
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.normal),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "0813 9099 0019",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#707793')
                                                      .withOpacity(0.7),
                                                  fontWeight: FontWeight.normal),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                width: MediaQuery.of(context).size.width,
                                height: 88,
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Invoice ID",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#3C3F58'),
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text("${data!.uniqueId}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#707793'),
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Diterbitkan",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#3C3F58'),
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Text(
                                              "${data!.createdAt!.day}-${data!.createdAt!.month.toString().padLeft(2, '0')}-${data!.createdAt!.year} ${data!.createdAt!.hour.toString().padLeft(2, '0')}.${data!.createdAt!.minute}",
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  color: HexColor('#707793'),
                                                  fontWeight: FontWeight.w400)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                width: MediaQuery.of(context).size.width,
                                height: 120,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ditagihkan kepada",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#3C3F58'),
                                                fontWeight: FontWeight.bold)),
                                        Container(
                                          child: Text(
                                            data!.status == 'valid'
                                                ? "Lunas"
                                                : "Belum Lunas",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: data!.status == 'valid'
                                                    ? HexColor('#05C270')
                                                    : HexColor('#FF3B3B')),
                                          ),
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: data!.status == 'valid'
                                                  ? HexColor('#05C270')
                                                      .withOpacity(0.1)
                                                  : HexColor('#FF3B3B')
                                                      .withOpacity(0.1)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text("${data!.name}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793'),
                                            fontWeight: FontWeight.w400,
                                            height: 1.5)),
                                    Text(
                                        "${data!.ownerName} (${data!.ownerPhoneNumber})",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793'),
                                            fontWeight: FontWeight.w400,
                                            height: 1.5)),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                width: MediaQuery.of(context).size.width,
                                height: 110,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Deskripsi",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#3C3F58'),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text("${data!.descriptios} (30 hari)",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793'),
                                            fontWeight: FontWeight.w400,
                                            height: 1.5)),
                                    Text(
                                        "${data!.dateStart!.day} ${months[data!.dateStart!.month - 1]} ${data!.dateStart!.year} sd. ${data!.dateEnd!.day} ${months[data!.dateEnd!.month - 1]} ${data!.dateEnd!.year}",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color: HexColor('#707793'),
                                            fontWeight: FontWeight.w400,
                                            height: 1.5)),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, top: 8),
                                width: MediaQuery.of(context).size.width,
                                height: 140,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Rincian biaya",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                color: HexColor('#3C3F58'),
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Harga / pelanggan",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#707793'),
                                                fontWeight: FontWeight.w400)),
                                        Text("Rp ${rupiah(data!.price)}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#707793'),
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Jumlah pelanggan",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#707793'),
                                                fontWeight: FontWeight.w400)),
                                        Text(
                                            (data!.price! / data!.totalAmount!)
                                                .toStringAsFixed(0),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#707793'),
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Total biaya",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#707793'),
                                                fontWeight: FontWeight.w400)),
                                        Text("Rp ${rupiah(data!.totalAmount!)}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                height: 1.7,
                                                color: HexColor('#0063F8'),
                                                fontWeight: FontWeight.w800)),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0.0, 8.0),
                                      color: Color.fromRGBO(0, 99, 248, 0.16),
                                      blurRadius: 24,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 24,
                                    top: 8.0),
                                child: data!.status == 'valid'
                                    ? null
                                    : Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: HexColor('#0063F8')
                                                    .withOpacity(0.2),
                                                spreadRadius: 5,
                                                blurRadius: 10,
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Colors.white),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                      'Mohon transfer sejumlah sekian ke',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color:
                                                            HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                  Text(
                                                      'salah satu nomor rekening di bawah :',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color:
                                                            HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/bri.svg'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 8.0),
                                                    child: Text(
                                                        '1063 0100 0630 303',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: HexColor(
                                                              '#0063F8'),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  Text(
                                                      'A.n Bangun Karya Mandiri',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color:
                                                            HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/mandiri.svg'),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0,
                                                            bottom: 8.0),
                                                    child: Text(
                                                        '138 00 1570767 7',
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          color: HexColor(
                                                              '#0063F8'),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  Text(
                                                      'A.n Bangun Karya Mandiri',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color:
                                                            HexColor('#707793'),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          )),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      HexColor('#5433FF'),
                      HexColor('#0063F8')
                    ])),
                  ),
                  data!.status == 'valid' ? Container() : Container(
                    height: 48.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        gradient: LinearGradient(colors: [
                          HexColor('#0063F8'),
                          HexColor('#5433FF')
                        ])),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Text(
                        'Konfirmasi Sekarang',
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
