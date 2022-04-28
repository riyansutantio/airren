
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
  final isLoadingSearch = false.obs;
  RxInt isRadio = 1.obs;
  final searchValue = ''.obs;
  final isSearch = false.obs;
  final cusUserResult = <CustomerModel>[].obs;
  String getInitials(String name) => name.isNotEmpty
      ? name.trim().split(' ').map((e) => e[0]).take(2).join()
      : '';

  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final phoneNumberCusController = TextEditingController();
  final addressCusController = TextEditingController();
  final meterCusController = TextEditingController();
  final nameDetailController = TextEditingController();
  final idDetailController = TextEditingController();
  TextEditingController? phoneDetailNumberCusController =
      TextEditingController();
  TextEditingController? addressDetailCusController = TextEditingController();
  final meterDetailCusController = TextEditingController();
  final activeDetailCusController = TextEditingController();
  final uniqueIdDetailCusController = TextEditingController();

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

  Future updateManageCus(
      {required String name,
      required String phoneNumber,
      required String address,
      required String id,
      required String meter}) async {
    final res = await p!.updateCusManage(
        bearer: boxUser.read(tokenBearer),
        address: address,
        name: name,
        phoneNumber: phoneNumber,
        active: isRadio.value,
        id: id,
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

  Future searchManage() async {
    isLoadingCusUser.value = true;
    final res = await p!.getSearchCus(
        bearer: boxUser.read(tokenBearer), searchValue: searchValue.value);
    // logger.wtf(res!.data!.data!.toList());

    cusUserResult.assignAll(res!.data!.cusMs!);
  }

  @override
  void onReady() {
    super.onReady();
    debounce(searchValue, (String? val) {
      print(val!.length);
      if (cusUserResult.value.isNotEmpty  && val.isNotEmpty) {
        isLoadingSearch.value = true;
      } else {
        isLoadingSearch.value = false;
      }
      return searchManage();
    }, time: 500.milliseconds);
  }

  Widget noListCustomer() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/emptylist.png",
            width: 77,
            height: 90,
          ),
          const SizedBox(height: 30),
          Text(
            "Belum ada pelanggan",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Tambahkan pelanggan baru melalui\n tombol biru di bawah.",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                color: HexColor('#707793'),
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget noListSearch() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/search.png",
            width: 77,
            height: 90,
          ),
          const SizedBox(height: 30),
          Text(
            "Tidak ditemukan",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Belum ada pelanggan yang bisa ditemukan\ndari kata kunci di atas.",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                color: HexColor('#707793'),
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  @override
  void onClose() async {
    await getCusUsers();
  }

  void increment() => count.value++;
  void getPdf(String uniqueId, String name) async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(5),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.GridView(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 7,
                children: [
                  pw.Container(
                      padding: pw.EdgeInsets.only(
                          left: 6, right: 6, bottom: 2, top: 2),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                            color: PdfColor.fromHex('#000'), width: 1),
                      ),
                      child: pw.Column(children: [
                        pw.BarcodeWidget(
                            padding: pw.EdgeInsets.only(top: 4),
                            data: uniqueId,
                            barcode: pw.Barcode.qrCode(),
                            height: 80,
                            width: 80),
                        pw.Text(
                            name.length <= 9
                                ? name
                                : name.substring(0, 9) + '..',
                            style: pw.TextStyle(
                                fontSize: 14, fontWeight: pw.FontWeight.bold)),
                        pw.Text('$uniqueId'),
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

  void getPdfAll() async {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        margin: pw.EdgeInsets.all(5),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.GridView(
                crossAxisCount: 5,
                childAspectRatio: 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 7,
                children: cusUserResult
                    .map((e) => pw.Container(
                        padding: pw.EdgeInsets.only(
                            left: 6, right: 6, bottom: 2, top: 2),
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                              color: PdfColor.fromHex('#000'), width: 1),
                        ),
                        child: pw.Column(children: [
                          pw.BarcodeWidget(
                              padding: pw.EdgeInsets.only(top: 4),
                              data: e.uniqueId!,
                              barcode: pw.Barcode.qrCode(),
                              height: 80,
                              width: 80),
                          pw.Text(
                              e.name!.length <= 9
                                  ? '${e.name}'
                                  : '${e.name!.substring(0, 9)}' + '..',
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('${e.uniqueId}'),
                        ])))
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
