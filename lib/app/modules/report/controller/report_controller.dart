import 'dart:io';
import 'dart:typed_data';

import 'package:airen/app/model/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../../../model/report_ofMonth.dart';
import '../../../model/report_ofYear.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../provider/report_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:date_util/date_util.dart';

class ReportController extends GetxController {
  ReportController({required this.p});
  ReportProvider? p;
  final isLoading = false.obs;
  final resultYears = '${DateTime.now().year}'.obs;
  final resultMonths = '1'.obs;
  final years = <String>[].obs;
  final month = <String>[].obs;
  final result = <ReportMonthactionsModel>[].obs;
  final resultYearslist = <ReportYearactionsModel>[].obs;
  final boxUser = GetStorage();
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    final daysCount = DateTime.now().year;
    for (int i = 1990; i < daysCount + 1; i++) {
      years.add(i.toString());
    }
    for (int i = 1; i < monthsAll.length; i++) {
      month.add(i.toString());
    }
    print(month);
  }

  Future getReportMonths() async {
    try {
      isLoading.value = true;
      final res = await p!.getReportMonth(
          bearer: boxUser.read(tokenBearer),
          month: resultMonths.value,
          year: resultYears.value);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        result.assignAll(res.data!.reportMonth!);
        getPdfMonth(
            res.data!.priode,
            res.data!.pamOwner,
            res.data!.pamTreasurer,
            res.data!.printDate,
            res.data!.pam,
            res.data!.reportMonth);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future getReportYears() async {
    try {
      isLoading.value = true;
      final res = await p!.getReportYear(
          bearer: boxUser.read(tokenBearer), year: resultYears.value);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        resultYearslist.assignAll(res.data!.reportYear!);
        getPdfYear(res.data!.priode, res.data!.pamOwner, res.data!.pamTreasurer,
            res.data!.printDate, res.data!.pam, res.data!.reportYear);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.value = false;
    }
  }

  void getPdfMonth(
      String? priode,
      String? pamOwner,
      String? pamTreasurer,
      String? printDate,
      Pam? pam,
      List<ReportMonthactionsModel>? reportMonth) async {
    final pdf = pw.Document();

    var url = "pam!.photoPath";
    var response = await http.get(Uri.parse(url));
    var data = response.bodyBytes;
    pw.MemoryImage? imageA;

    final air = pw.MemoryImage(
      (await rootBundle.load('assets/air.png')).buffer.asUint8List(),
    );
    final imageB = pw.MemoryImage(
      (await rootBundle.load('assets/logoairen.png')).buffer.asUint8List(),
    );
    try {
      imageA = pw.MemoryImage(
        data,
      );
    } catch (e) {
      imageA = pw.MemoryImage(
          (await rootBundle.load('assets/default.jpg')).buffer.asUint8List());
    }
    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      padding: pw.EdgeInsets.all(25),
                      color: PdfColor.fromHex('#F2F3F8'),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Row(children: [
                              pw.ClipRRect(
                                  verticalRadius: 30,
                                  horizontalRadius: 30,
                                  child: imageA == null
                                      ? pw.SizedBox(
                                          width: 60,
                                          height: 60,
                                        )
                                      : pw.Image(imageA,
                                          width: 60, height: 60)),
                              pw.SizedBox(width: 30),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("${pam!.name}",
                                        style: pw.TextStyle(
                                            fontSize: 22,
                                            color: PdfColor.fromHex('#3C3F58'),
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Padding(
                                            padding: pw.EdgeInsets.only(
                                                right: 4, top: 4),
                                            child: pw.Image(air,
                                                width: 25, height: 25),
                                          ),
                                          pw.Padding(
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Text(
                                                  '${pam.detailAddress}, ${pam.district!.name},\n${pam.regency!.name}, ${pam.province!.name}',
                                                  style: pw.TextStyle(
                                                    fontSize: 12,
                                                    color: PdfColor.fromHex(
                                                        '#707793'),
                                                  )))
                                        ])
                                  ])
                            ]),
                            pw.Image(imageB, width: 60, height: 60),
                          ])),
                  pw.Container(
                      padding: pw.EdgeInsets.all(25),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Laporan Bulanan",
                              style: pw.TextStyle(
                                  fontSize: 36,
                                  color: PdfColor.fromHex('#3D3A41'),
                                  height: 2.4,
                                  fontWeight: pw.FontWeight.normal),
                            ),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "$priode",
                                    style: pw.TextStyle(
                                        fontSize: 24,
                                        color: PdfColor.fromHex('#3D3A41'),
                                        height: 2.4,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.Row(children: [
                                    pw.Text(
                                      "Saldo : ",
                                      style: pw.TextStyle(
                                          fontSize: 22,
                                          color: PdfColor.fromHex('#3D3A41'),
                                          height: 2.4,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      "Rp. ${rupiah(reportMonth![reportMonth.length - 1].balance)}",
                                      style: pw.TextStyle(
                                          fontSize: 22,
                                          color: PdfColor.fromHex('#FF8801'),
                                          height: 2.4,
                                          fontWeight: pw.FontWeight.bold),
                                    )
                                  ])
                                ]),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 56,
                                color: PdfColor.fromHex('#0063F8'),
                                child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.SizedBox(
                                          width: 30,
                                          height: 56,
                                          child: pw.Center(
                                              child: pw.Text("No",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColors.white,
                                                      fontWeight: pw
                                                          .FontWeight.bold)))),
                                      pw.SizedBox(
                                          width: 160,
                                          child: pw.Text("Deskripsi",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 120,
                                          child: pw.Text("Nominal (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 140,
                                          child: pw.Text("Saldo (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                    ])),
                            pw.ListView.builder(
                                padding: pw.EdgeInsets.zero,
                                itemBuilder: ((context, index) => pw.Container(
                                    height: 36,
                                    child: pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.SizedBox(
                                              width: 30,
                                              height: 36,
                                              child: pw.Center(
                                                  child: pw.Text(
                                                      reportMonth[index].desc ==
                                                              "Total"
                                                          ? ''
                                                          : "${index + 1}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  '#707793'),
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)))),
                                          pw.SizedBox(
                                              width: 160,
                                              child: pw.Text(
                                                  "${reportMonth[index].desc}",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColor.fromHex(
                                                          '#707793'),
                                                      fontWeight: pw
                                                          .FontWeight.normal))),
                                          pw.SizedBox(
                                              width: 120,
                                              child: pw.Center(
                                                  child: pw.Text(
                                                      "${rupiah(reportMonth[index].amount)}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  '#707793'),
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)))),
                                          pw.SizedBox(
                                              width: 140,
                                              child: pw.Text(
                                                  "${rupiah(reportMonth[index].balance)}",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColor.fromHex(
                                                          '#707793'),
                                                      fontWeight: pw
                                                          .FontWeight.normal))),
                                        ]))),
                                itemCount: reportMonth.length),
                            // pw.Container(
                            //     height: 36,
                            //     child: pw.Row(
                            //         crossAxisAlignment:
                            //             pw.CrossAxisAlignment.center,
                            //         mainAxisAlignment:
                            //             pw.MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           pw.SizedBox(
                            //             width: 50,
                            //             height: 36,
                            //           ),
                            //           pw.SizedBox(
                            //               width: 120,
                            //               child: pw.Text("Total",
                            //                   style: pw.TextStyle(
                            //                       fontSize: 14,
                            //                       color: PdfColor.fromHex(
                            //                           '#707793'),
                            //                       fontWeight:
                            //                           pw.FontWeight.bold))),
                            //           pw.SizedBox(
                            //               width: 120,
                            //               child: pw.Center(
                            //                   child: pw.Text("2.000.000",
                            //                       style: pw.TextStyle(
                            //                           fontSize: 14,
                            //                           color: PdfColor.fromHex(
                            //                               '#707793'),
                            //                           fontWeight: pw
                            //                               .FontWeight.bold)))),
                            //           pw.SizedBox(
                            //               width: 140,
                            //               child: pw.Text("5.000.000",
                            //                   style: pw.TextStyle(
                            //                       fontSize: 14,
                            //                       color: PdfColor.fromHex(
                            //                           '#707793'),
                            //                       fontWeight:
                            //                           pw.FontWeight.bold))),
                            //         ])),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.SizedBox(
                                      width: 110,
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.SizedBox(
                                                width: 100,
                                                child: pw.Text("$printDate",
                                                    style: pw.TextStyle(
                                                        fontSize: 17,
                                                        color: PdfColor.fromHex(
                                                            '#0063F8'),
                                                        fontWeight: pw
                                                            .FontWeight.bold))),
                                          ])),
                                  pw.SizedBox(
                                      width: 180,
                                      child: pw.Column(children: [
                                        pw.Text("Pemilik Pams",
                                            style: pw.TextStyle(
                                                fontSize: 14,
                                                color:
                                                    PdfColor.fromHex('#707793'),
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Text("$pamOwner",
                                            style: pw.TextStyle(
                                                fontSize: 16,
                                                color:
                                                    PdfColor.fromHex('#3C3F58'),
                                                fontWeight: pw.FontWeight.bold))
                                      ])),
                                  pw.SizedBox(
                                      width: 180,
                                      child: pw.Column(children: [
                                        pw.Text("Bendahara",
                                            style: pw.TextStyle(
                                                fontSize: 14,
                                                color:
                                                    PdfColor.fromHex('#707793'),
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Text("$pamTreasurer",
                                            style: pw.TextStyle(
                                                fontSize: 16,
                                                color:
                                                    PdfColor.fromHex('#3C3F58'),
                                                fontWeight: pw.FontWeight.bold))
                                      ]))
                                ])
                          ]))
                ])
          ]; // Center
        }));

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airrenQR-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  void getPdfYear(
      String? priode,
      String? pamOwner,
      String? pamTreasurer,
      String? printDate,
      Pam? pam,
      List<ReportYearactionsModel>? reportMonth) async {
    final pdf = pw.Document();

    var url = "${pam!.photoPath}";
    var response = await http.get(Uri.parse(url));
    var data = response.bodyBytes;
    pw.MemoryImage? imageA;
    final air = pw.MemoryImage(
      (await rootBundle.load('assets/air.png')).buffer.asUint8List(),
    );
    final imageB = pw.MemoryImage(
      (await rootBundle.load('assets/logoairen.png')).buffer.asUint8List(),
    );
    try {
      imageA = pw.MemoryImage(
        data,
      );
    } catch (e) {
      imageA = pw.MemoryImage(
          (await rootBundle.load('assets/default.jpg')).buffer.asUint8List());
    }
    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.zero,
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                      padding: pw.EdgeInsets.all(25),
                      color: PdfColor.fromHex('#F2F3F8'),
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Row(children: [
                              pw.ClipRRect(
                                  verticalRadius: 30,
                                  horizontalRadius: 30,
                                  child: imageA == null
                                      ? pw.SizedBox(
                                          width: 60,
                                          height: 60,
                                        )
                                      : pw.Image(imageA,
                                          width: 60, height: 60)),
                              pw.SizedBox(width: 30),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("${pam.name}",
                                        style: pw.TextStyle(
                                            fontSize: 22,
                                            color: PdfColor.fromHex('#3C3F58'),
                                            fontWeight: pw.FontWeight.bold)),
                                    pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Padding(
                                            padding: pw.EdgeInsets.only(
                                                right: 4, top: 4),
                                            child: pw.Image(air,
                                                width: 25, height: 25),
                                          ),
                                          pw.Padding(
                                              padding: pw.EdgeInsets.all(4),
                                              child: pw.Text(
                                                  '${pam.detailAddress}, ${pam.district!.name},\n${pam.regency!.name}, ${pam.province!.name}',
                                                  style: pw.TextStyle(
                                                    fontSize: 12,
                                                    color: PdfColor.fromHex(
                                                        '#707793'),
                                                  )))
                                        ])
                                  ])
                            ]),
                            pw.Image(imageB, width: 60, height: 60),
                          ])),
                  pw.Container(
                      padding: pw.EdgeInsets.all(25),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Laporan Tahunan",
                              style: pw.TextStyle(
                                  fontSize: 36,
                                  color: PdfColor.fromHex('#3D3A41'),
                                  height: 2.4,
                                  fontWeight: pw.FontWeight.normal),
                            ),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Periode $priode",
                                    style: pw.TextStyle(
                                        fontSize: 24,
                                        color: PdfColor.fromHex('#3D3A41'),
                                        height: 2.4,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.Row(children: [
                                    pw.Text(
                                      "Saldo : ",
                                      style: pw.TextStyle(
                                          fontSize: 22,
                                          color: PdfColor.fromHex('#3D3A41'),
                                          height: 2.4,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.Text(
                                      "Rp. ${rupiah(reportMonth![reportMonth.length - 1].balance)}",
                                      style: pw.TextStyle(
                                          fontSize: 22,
                                          color: PdfColor.fromHex('#FF8801'),
                                          height: 2.4,
                                          fontWeight: pw.FontWeight.bold),
                                    )
                                  ])
                                ]),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 56,
                                color: PdfColor.fromHex('#0063F8'),
                                child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.SizedBox(
                                          width: 30,
                                          height: 56,
                                          child: pw.Center(
                                              child: pw.Text("No",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColors.white,
                                                      fontWeight: pw
                                                          .FontWeight.bold)))),
                                      pw.SizedBox(
                                          width: 160,
                                          child: pw.Text("Deskripsi",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 120,
                                          child: pw.Text("Nominal (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 140,
                                          child: pw.Text("Saldo (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                    ])),
                            pw.ListView.builder(
                                padding: pw.EdgeInsets.zero,
                                itemBuilder: ((context, index) => pw.Container(
                                    height: 36,
                                    child: pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.SizedBox(
                                              width: 30,
                                              height: 36,
                                              child: pw.Center(
                                                  child: pw.Text(
                                                      reportMonth[index].desc ==
                                                              "Total"
                                                          ? ''
                                                          : "${index + 1}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  '#707793'),
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)))),
                                          pw.SizedBox(
                                              width: 160,
                                              child: pw.Text(
                                                  "${reportMonth[index].desc}",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColor.fromHex(
                                                          '#707793'),
                                                      fontWeight: pw
                                                          .FontWeight.normal))),
                                          pw.SizedBox(
                                              width: 120,
                                              child: pw.Center(
                                                  child: pw.Text(
                                                      "${rupiah(reportMonth[index].amount)}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  '#707793'),
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)))),
                                          pw.SizedBox(
                                              width: 140,
                                              child: pw.Text(
                                                  "${rupiah(reportMonth[index].balance)}",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColor.fromHex(
                                                          '#707793'),
                                                      fontWeight: pw
                                                          .FontWeight.normal))),
                                        ]))),
                                itemCount: reportMonth.length),
                            // pw.Container(
                            //     height: 36,
                            //     child: pw.Row(
                            //         crossAxisAlignment:
                            //             pw.CrossAxisAlignment.center,
                            //         mainAxisAlignment:
                            //             pw.MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           pw.SizedBox(
                            //             width: 50,
                            //             height: 36,
                            //           ),
                            //           pw.SizedBox(
                            //               width: 120,
                            //               child: pw.Text("Total",
                            //                   style: pw.TextStyle(
                            //                       fontSize: 14,
                            //                       color: PdfColor.fromHex(
                            //                           '#707793'),
                            //                       fontWeight:
                            //                           pw.FontWeight.bold))),
                            //           pw.SizedBox(
                            //               width: 120,
                            //               child: pw.Center(
                            //                   child: pw.Text("2.000.000",
                            //                       style: pw.TextStyle(
                            //                           fontSize: 14,
                            //                           color: PdfColor.fromHex(
                            //                               '#707793'),
                            //                           fontWeight: pw
                            //                               .FontWeight.bold)))),
                            //           pw.SizedBox(
                            //               width: 140,
                            //               child: pw.Text("5.000.000",
                            //                   style: pw.TextStyle(
                            //                       fontSize: 14,
                            //                       color: PdfColor.fromHex(
                            //                           '#707793'),
                            //                       fontWeight:
                            //                           pw.FontWeight.bold))),
                            //         ])),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.SizedBox(
                                      width: 110,
                                      child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.SizedBox(
                                                width: 100,
                                                child: pw.Text("$printDate",
                                                    style: pw.TextStyle(
                                                        fontSize: 17,
                                                        color: PdfColor.fromHex(
                                                            '#0063F8'),
                                                        fontWeight: pw
                                                            .FontWeight.bold))),
                                          ])),
                                  pw.SizedBox(
                                      width: 180,
                                      child: pw.Column(children: [
                                        pw.Text("Pemilik Pams",
                                            style: pw.TextStyle(
                                                fontSize: 14,
                                                color:
                                                    PdfColor.fromHex('#707793'),
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Text("$pamOwner",
                                            style: pw.TextStyle(
                                                fontSize: 16,
                                                color:
                                                    PdfColor.fromHex('#3C3F58'),
                                                fontWeight: pw.FontWeight.bold))
                                      ])),
                                  pw.SizedBox(
                                      width: 180,
                                      child: pw.Column(children: [
                                        pw.Text("Bendahara",
                                            style: pw.TextStyle(
                                                fontSize: 14,
                                                color:
                                                    PdfColor.fromHex('#707793'),
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.Text("$pamTreasurer",
                                            style: pw.TextStyle(
                                                fontSize: 16,
                                                color:
                                                    PdfColor.fromHex('#3C3F58'),
                                                fontWeight: pw.FontWeight.bold))
                                      ]))
                                ])
                          ]))
                ])
          ]; // Center
        }));

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airrenQR-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}
