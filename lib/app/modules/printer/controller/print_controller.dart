import 'package:airen/app/model/register_model.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../model/invoice_pam.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../model/printer.dart';
import '../../../utils/utils.dart';
import '../../payment/providers/payment_providers.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PrintController extends GetxController {
  PrintController({required this.p});
  PaymentProviders? p;

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  AppPrint? _appPrint;
  final devices = <BluetoothDevice>[].obs;
  final device = Rxn<BluetoothDevice>();
  RxBool? connected = false.obs, onBluetooth = false.obs;

  late SharedPreferences preferences;

  // Printer _printer;

  RxString? nameDevice = ''.obs, addressDevice = ''.obs, prefPrint = ''.obs;

  RxInt? pId = 1.obs, pType = 0.obs, pConnected = 0.obs;
  RxString? pName = ''.obs, pAddress = ''.obs;

  RxBool conn = false.obs;
  RxBool isSwitched = false.obs;
  void tesPrint(
      {Pam? pam,
      TransactionAllModel? tm,
      List<CostDetail>? result,
      int? totalPrice,
      int? charge,
      int? totalResult,
      String? phoneNumber,
      int? fee}) async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large texts
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT

    bluetooth.isConnected.then((isConnected) {
      if (isConnected!) {
        if (pam != null) {
          if (pam.name != null && pam.name!.isNotEmpty) {
            bluetooth.printCustom("${pam.name}", 0, 1);
          }
          if (pam.detailAddress != null && pam.detailAddress!.isNotEmpty) {
            bluetooth.printCustom("${pam.detailAddress}", 0, 1);
          }
          if (phoneNumber != null && phoneNumber.isNotEmpty) {
            bluetooth.printCustom(phoneNumber, 0, 1);
          }
        }
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printCustom("Di tagihkan Kepada", 0, 1);
        if (tm != null) {
          if (tm.name != null && tm.name!.isNotEmpty) {
            bluetooth.printCustom("${tm.name}", 0, 1);
          }
          if (tm.address != null && tm.address!.isNotEmpty) {
            bluetooth.printCustom("${tm.address}", 0, 1);
          }
          if (tm.uniqueId != null && tm.uniqueId!.isNotEmpty) {
            bluetooth.printCustom("${tm.uniqueId}", 0, 1);
          }
        }
        bluetooth.printNewLine();

        bluetooth.printCustom("RINCIAN PEMAKAIAN", 0, 1);
        if (tm != null) {
          if (tm.meterLast != null && tm.meterLast!.isNotEmpty) {
            bluetooth.printLeftRight("METER AWAL", "${tm.meterLast}", 0);
          } else {
            bluetooth.printLeftRight("METER AWAL", " ", 0);
          }
          if (tm.meterNow != null && tm.meterNow!.isNotEmpty) {
            bluetooth.printLeftRight("METER AKHIR", "${tm.meterNow}", 0);
          } else {
            bluetooth.printLeftRight("METER AKHIR", " ", 0);
          }
          if (tm.meterNow != null && tm.meterNow!.isNotEmpty) {
            bluetooth.printLeftRight(
                "VOLUME",
                (double.parse(tm.meterNow!) - double.parse(tm.meterLast!))
                    .toString(),
                0);
          } else {
            bluetooth.printLeftRight("VOLUME", " ", 0);
          }
        }
        bluetooth.printNewLine();
        bluetooth.printCustom("RINCIAN BIAYA", 0, 1);
        result!.map((product) {
          String qtyBrg = product.meter.toString();
          String hrgBrg = rupiah(product.cost?.toInt());
          // double subtotal = product.transactionQuantity *
          //     product.transactionSinglePrice.toDouble();
          String subtotal = rupiah(int.parse(product.total!.toString()));
          // String subtot = rupiah(subtotal.toInt());
          if (qtyBrg.length <= 9) {
            bluetooth.printLeftRight("$qtyBrg    x   $hrgBrg", subtotal, 0);
          } else {
            bluetooth.printLeftRight("$qtyBrg   x   $hrgBrg", subtotal, 0);
          }
        }).toList();
        bluetooth.printLeftRight("Subtotal      Rp ", "$totalPrice", 0);
        bluetooth.printLeftRight("Biaya Admin   Rp ", "$fee", 0);
        bluetooth.printLeftRight("Biaya Denda   Rp ", "$charge", 0);
        bluetooth.printLeftRight("Total         Rp ", "$totalResult", 0);

        bluetooth.printNewLine();

        if (tm!.status == 'paid') {
          bluetooth.printCustom("== Lunas ==", 0, 1);
        } else if (tm.status == 'unpaid') {
          bluetooth.printCustom("== Belum Lunas ==", 0, 1);
        } else {
          bluetooth.printCustom("== Denda ==", 0, 1);
        }
        bluetooth.printNewLine();
        bluetooth.printCustom("--------------------------------", 1, 1);
        bluetooth.printNewLine();
        bluetooth.printCustom("AIRREN", 0, 1);
        bluetooth.printNewLine();
      }
    });
  }

  savePrint(String printAddress, String printName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('print', printAddress);
    preferences.setString('printer_name', printName);
    preferences.commit();
  }

  void connect() {
    if (device == null) {
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(device.value!).catchError((error) {
            connected!.value = false;
          });
          connected!.value = true;
        }
      });
    }
  }

  void disconnect() {
    bluetooth.disconnect();
    connected!.value = true;
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices2 = [];
    try {
      devices.value = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          connected!.value = true;

          break;
        case BlueThermalPrinter.DISCONNECTED:
          connected!.value = false;

          break;
        default:
          break;
      }
    });

    if (isConnected!) {
      connected!.value = true;
    }
  }

  pref() async {
    preferences = await SharedPreferences.getInstance();

    prefPrint!.value = (preferences.getString('print') ?? 'AddresPrint');
  }

  Future<void> getPrint() async {
    preferences = await SharedPreferences.getInstance();

    pAddress!.value = (preferences.getString('print') ?? 'AddresPrint');
    pName!.value = (preferences.getString('printer_name') ?? '');
    pConnected!.value = 1;
    //  device?.value = BluetoothDevice(pName?.value, pAddress?.value);
  }

  Future updatePrint() async {
    preferences = await SharedPreferences.getInstance();

    pAddress!.value = (preferences.getString('print') ?? 'AddresPrint');
    pName!.value = (preferences.getString('printer_name') ?? '');
    pConnected!.value = 1;
  }

  List<DropdownMenuItem<BluetoothDevice>> getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (devices.isEmpty) {
      items.add(const DropdownMenuItem(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Select'),
        ),
      ));
    } else {
      devices.value.forEach((device) {
        nameDevice!.value = device.name!;
        addressDevice!.value = device.address!;
        pName!.value = device.name!;
        pAddress!.value = device.address!;
        check();

        items.add(DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(device.name!),
          ),
          value: device,
        ));
      });
    }
    return items;
  }

  @override
  void onInit() async {
    super.onInit();
    await getPrint();
    if (pConnected == 0) {
      isSwitched.value = false;
    } else {
      isSwitched.value = true;
    }
    initPlatformState();
    _appPrint = AppPrint();
  }

  check() {
    // print("Cek Addr $pAddress");
    final form = formkey.currentState!;
    if (form.validate()) {
      form.save();
      // print("Addres Print $pAddress");
      updatePrint();
    }
  }
}
