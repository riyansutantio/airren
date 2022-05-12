import 'dart:io';
import 'dart:typed_data';

import 'package:airen/app/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../model/pdfTransaction.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../provider/pdfTransaction_provider.dart';

class PdfTransactionController extends GetxController {
  PdfTransactionController({required this.p});
  PdfTransactionProvider? p;

  List<PopupMenuItem<int>>? resultmonth = [];
  List<PopupMenuItem<int>>? result = [];
  List<PopupMenuItem<int>>? status = [];

  final pdfTrans = <TransModel>[].obs;
  final boxUser = GetStorage();
  final resultYears = '${DateTime.now().year}'.obs;
  final resultMonths = '2'.obs;
  final resultStatus = 'income'.obs;
  final month = <String>[].obs;
  final years = <String>[].obs;
  @override
  void onInit() async {
    super.onInit();
    status!.add(PopupMenuItem(
      value: 1,
      child: Text(
        "Pemasukan",
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: HexColor('#3C3F58'),
        ),
      ),
    ));
    status!.add(PopupMenuItem(
      value: 2,
      child: Text(
        "Pengeluaran",
        style: GoogleFonts.montserrat(
          fontSize: 14,
          color: HexColor('#3C3F58'),
        ),
      ),
    ));
    for (int i = 1; i < monthsAll.length; i++) {
      month.add(i.toString());
      resultmonth!.add(PopupMenuItem(
        value: i,
        child: Text(
          " ${monthsAll[i - 1]}",
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: HexColor('#3C3F58'),
          ),
        ),
      ));
    }
    int? daysCount = DateTime.now().year;
    int count = 0;
    int i = daysCount;

    while (daysCount! > 1999) {
      print(count);
      years.add(daysCount.toString());
      result!.add(PopupMenuItem(
        value: daysCount,
        child: Text(
          years[count],
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: HexColor('#3C3F58'),
          ),
        ),
      ));

      count = count + 1;
      daysCount = daysCount - 1;
    }
  }

  Future getPdfTransactions() async {
    try {
      final res = await p!.getPdfTransaction(
          bearer: boxUser.read(tokenBearer),
          month: resultMonths.value,
          type: resultStatus.value,
          year: resultYears.value);
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        pdfTrans.assignAll(res.data!.pdfTransaction!);

        getPdfMonth(
            res.data!.title,
            res.data!.totalTransactions,
            res.data!.priode,
            res.data!.pamOwner,
            res.data!.pamTreasurer,
            res.data!.printDate,
            res.data!.printDayname,
            res.data!.pam,
            res.data!.pdfTransaction);
      }
    } catch (e) {
      logger.e(e);
    } finally {}
  }

  void getPdfMonth(
      String? title,
      int? total,
      String? priode,
      String? pamOwner,
      String? pamTreasurer,
      String? printDate,
      String? printDayname,
      Pam? pam,
      List<TransModel>? pdfTransaksi) async {
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
                              "$title",
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
                                ]),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 46,
                                color: PdfColor.fromHex('#0063F8'),
                                child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.SizedBox(
                                          width: 30,
                                          height: 46,
                                          child: pw.Center(
                                              child: pw.Text("No",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColors.white,
                                                      fontWeight: pw
                                                          .FontWeight.bold)))),
                                      pw.SizedBox(
                                          width: 30,
                                          height: 46,
                                          child: pw.Center(
                                              child: pw.Text("Tgl.",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColors.white,
                                                      fontWeight: pw
                                                          .FontWeight.bold)))),
                                      pw.SizedBox(
                                          width: 160,
                                          child: pw.Text("Nama Transaksi",
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
                                          child: pw.Text("Keterangan",
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
                                                  child: pw.Text("${index + 1}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColor.fromHex(
                                                                  '#707793'),
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .normal)))),
                                          pw.SizedBox(
                                              width: 30,
                                              height: 46,
                                              child: pw.Center(
                                                  child: pw.Text(
                                                      "${pdfTransaksi![index].createdAt!.day}",
                                                      style: pw.TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              PdfColors.white,
                                                          fontWeight: pw
                                                              .FontWeight
                                                              .bold)))),
                                          pw.SizedBox(
                                              width: 160,
                                              child: pw.Text(
                                                  "${pdfTransaksi[index].name}",
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
                                                      rupiah(pdfTransaksi[index]
                                                          .amount),
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
                                                  pdfTransaksi[index]
                                                          .description ??
                                                      '',
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColor.fromHex(
                                                          '#707793'),
                                                      fontWeight: pw
                                                          .FontWeight.normal))),
                                        ]))),
                                itemCount: pdfTransaksi!.length),
                            pw.Row(
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.SizedBox(
                                    width: 30,
                                    height: 36,
                                  ),
                                  pw.SizedBox(
                                    width: 30,
                                    height: 46,
                                  ),
                                  pw.SizedBox(
                                      width: 160,
                                      child: pw.Text("Total Pemasukan :",
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              color:
                                                  PdfColor.fromHex('#3C3F58'),
                                              fontWeight: pw.FontWeight.bold))),
                                  pw.SizedBox(
                                      width: 120,
                                      child: pw.Center(
                                          child: pw.Text(rupiah(total),
                                                style: pw.TextStyle(
                                              fontSize: 14,
                                              color:
                                                  PdfColor.fromHex('#3C3F58'),
                                              fontWeight: pw.FontWeight.bold)))),
                                  pw.SizedBox(
                                    width: 140,
                                  ),
                                ]),
                            pw.SizedBox(height: 30),
                            pw.Container(
                                height: 5, color: PdfColor.fromHex('#FFCC00')),
                            pw.SizedBox(height: 30),
                            pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
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
                                                child: pw.Text("$printDayname",
                                                    style: pw.TextStyle(
                                                        fontSize: 22,
                                                        color: PdfColor.fromHex(
                                                            '#0063F8'),
                                                        fontWeight: pw
                                                            .FontWeight.bold))),
                                            pw.SizedBox(
                                                width: 70,
                                                child: pw.Text("$printDate",
                                                    style: pw.TextStyle(
                                                        fontSize: 14,
                                                        color: PdfColor.fromHex(
                                                            '#707793'),
                                                        fontWeight: pw
                                                            .FontWeight.bold)))
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
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(
                                          height: 55,
                                        ),
                                        pw.Opacity(
                                            opacity: 0.4,
                                            child: pw.Text(
                                                ".......................",
                                                style: pw.TextStyle(
                                                    fontSize: 16,
                                                    color: PdfColor.fromHex(
                                                        '#3C3F58'))))
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
                                        pw.Text(pamTreasurer ?? '',
                                            style: pw.TextStyle(
                                                fontSize: 16,
                                                color:
                                                    PdfColor.fromHex('#3C3F58'),
                                                fontWeight:
                                                    pw.FontWeight.bold)),
                                        pw.SizedBox(
                                          height: 55,
                                        ),
                                        pw.Opacity(
                                            opacity: 0.4,
                                            child: pw.Text(
                                                ".......................",
                                                style: pw.TextStyle(
                                                    fontSize: 16,
                                                    color: PdfColor.fromHex(
                                                        '#3C3F58'))))
                                      ]))
                                ])
                          ]))
                ])
          ]; // Center
        }));

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airren-Transaksi-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}
