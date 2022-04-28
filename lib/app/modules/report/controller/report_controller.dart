import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import '../../../utils/utils.dart';
import '../provider/report_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportController extends GetxController {
  ReportController({required this.p});
  ReportProvider? p;
  void getPdfMonth() async {
    final pdf = pw.Document();

    var url =
        "https://cms.airren.tbrdev.my.id/storage/2022/04/28/b1df8e9d569650dab3fe9405b3746881.jpg";
    var response = await http.get(Uri.parse(url));
    var data = response.bodyBytes;
    final imageA = pw.MemoryImage(
      data,
    );
    final air = pw.MemoryImage(
      (await rootBundle.load('assets/air.png')).buffer.asUint8List(),
    );
    final imageB = pw.MemoryImage(
      (await rootBundle.load('assets/logoairen.png')).buffer.asUint8List(),
    );
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
                                  child:
                                      pw.Image(imageA, width: 60, height: 60)),
                              pw.SizedBox(width: 30),
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Umbul Pams",
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
                                                  'Detail Adress, Kecamatan mapanget,\nKota Manado, Provinsi sulawesi utara',
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
                                    "Priode Januari 2021",
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
                                      "Rp. ${rupiah(6000000)}",
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
                                          width: 50,
                                          height: 56,
                                          child: pw.Center(
                                              child: pw.Text("No",
                                                  style: pw.TextStyle(
                                                      fontSize: 14,
                                                      color: PdfColors.white,
                                                      fontWeight: pw
                                                          .FontWeight.bold)))),
                                      pw.SizedBox(
                                          width: 120,
                                          height: 56,
                                          child: pw.Text("Deskripsi",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 120,
                                          height: 56,
                                          child: pw.Text("Nominal (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                      pw.SizedBox(
                                          width: 140,
                                          height: 56,
                                          child: pw.Text("Saldo (Rp)",
                                              style: pw.TextStyle(
                                                  fontSize: 14,
                                                  color: PdfColors.white,
                                                  fontWeight:
                                                      pw.FontWeight.bold))),
                                    ])),
                                    // pw.ListView.builder(itemBuilder: itemBuilder, itemCount: itemCount)
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
