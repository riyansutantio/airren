import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../utils/utils.dart';
import '../../home/controllers/home_controller.dart';

class CustomerController extends GetxController {
  //TODO: Implement CustomerController

  var menuItem = <MenuItemModel>[
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
  ];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    logger.i('test');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void getPdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.GridView(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: menuItem
                    .map((e) => pw.Column(
                  children: [
                    pw.BarcodeWidget(data: e.id!, barcode: pw.Barcode.qrCode(), height: 30, width: 30),
                    pw.Text('${e.title}'),
                  ]
                ))
                    .toList())
          ]; // Center
        })); // Page

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airrenQR-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }
}
