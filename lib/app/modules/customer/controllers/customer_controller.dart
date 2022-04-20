import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../model/customer/customerModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../../widgets/snack_bar_notification.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../../home/controllers/home_controller.dart';
import '../providers/customer_provider.dart';

class CustomerController extends GetxController {
  CustomerController({required this.p});
  //TODO: Implement CustomerController
  CustomerProviders? p;
  final boxUser = GetStorage();
  final isLoadingCusUser = false.obs;
  final cusUserResult = <CustomerModel>[].obs;
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((e) => e[0]).take(2).join()
      : '';
  final nameController = TextEditingController();
  final phoneNumberCusController = TextEditingController();
  final addressCusController = TextEditingController();
  final meterCusController = TextEditingController();
  final nameDetailController = TextEditingController();
  final phoneDetailNumberCusController = TextEditingController();
  final addressDetailCusController = TextEditingController();
  final meterDetailCusController = TextEditingController();
  final activeDetailCusController = TextEditingController();
  final uniqueIdDetailCusController = TextEditingController();
  RxInt isRadio = 1.obs;
  var menuItem = <MenuItemModel>[
    MenuItemModel(
        title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(
        title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(
        title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(
        title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
    MenuItemModel(
        title: 'Catat meter', assets: 'catatmetericon.svg', id: '01234'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '11235'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '22323'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '34554'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '423456'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '554324'),
  ];

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getCusUsers();
  }

  Future addCustomers() async {
    final res = await p!.addCusManage(
        bearer: boxUser.read(tokenBearer),
        address: addressCusController.text,
        name: nameController.text,
        phoneNumber: phoneNumberCusController.text,
        meter: meterCusController.text);
    logger.i(nameController.text);
    if (res!.status! == 'success') {
      await getCusUsers();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil ditambahkan');
    } else {
      snackBarNotificationFailed(title: 'Gagal ditambahkan');
    }
  }

  Future updateManageCus({ required String name,
      required String phoneNumber,
      required String address,
      required String meter}) async {
    final res = await p!.updateCusManage(
        bearer: boxUser.read(tokenBearer),
        address: address,
        name: name,
        phoneNumber:phoneNumber,active: isRadio.value,
        meter: meter);
    logger.i(nameController.text);
    if (res!.status! == 'success') {
      await getCusUsers();
      await clearCondition();
      Get.back();
      snackBarNotificationSuccess(title: 'Berhasil diubah');
    } else {
      snackBarNotificationFailed(title: 'Gagal diubah');
    }
  }

  Future getCusUsers() async {
    try {
      isLoadingCusUser.value = true;
      final res = await p!.getCusUser(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        cusUserResult.assignAll(res.data!.cusMs!);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingCusUser.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() async {
    await getCusUsers();
  }

  void increment() => count.value++;
  void getPdf(String uniqueId, String name) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.GridView(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 7,
                children: [
                  pw.Column(children: [
                    pw.BarcodeWidget(
                        data: uniqueId,
                        barcode: pw.Barcode.qrCode(),
                        height: 55,
                        width: 55),
                    pw.Text('$name',
                        style: pw.TextStyle(
                            fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Text('$uniqueId'),
                  ])
                ])
          ]; // Center
        }));

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airrenQR-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  void getPdfAll() async {
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
                children: cusUserResult
                    .map((e) => pw.Column(children: [
                          pw.BarcodeWidget(
                              data: e.uniqueId!,
                              barcode: pw.Barcode.qrCode(),
                              height: 30,
                              width: 30),
                          pw.Text('${e.uniqueId}'),
                        ]))
                    .toList())
          ]; // Center
        })); // Page

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/airrenQR-$formatted.pdf');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  Future<void> clearCondition() async {
    nameController.clear();
    addressCusController.clear();
    phoneNumberCusController.clear();
    meterCusController.clear();
  }
}
