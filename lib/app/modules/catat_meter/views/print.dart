import 'package:airen/app/modules/error_handling/bindings/error_handling_binding.dart';
import 'package:airen/app/modules/error_handling/views/error_handling_view.dart';
import 'package:app_settings/app_settings.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/printer_model.dart';

class Print extends StatefulWidget {
  static const routeName = '/print';

  @override
  _PrintState createState() => _PrintState();
}

class _PrintState extends State<Print> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  final formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppPrint? _appPrint;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false, _onBluetooth = false;

  late SharedPreferences preferences;

  // Printer _printer;

  String nameDevice = '', addressDevice = '', prefPrint = '';

  int? pId = 1, pType = 0, pConnected = 0;
  String? pName = '', pAddress = '';

  bool conn = false;
  bool isSwitched = false;

  savePrint(String printAddress, String printName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString('print', printAddress);
      preferences.setString('printer_name', printName);
      preferences.commit();
    });
  }

  pref() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      prefPrint = (preferences.getString('print') ?? 'AddresPrint');
    });
  }

  Future<void> getPrint() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      pAddress = (preferences.getString('print') ?? 'AddresPrint');
      pName = (preferences.getString('printer_name') ?? '');
      pConnected = 1;
    });
  }

  Future updatePrint() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      pAddress = (preferences.getString('print') ?? 'AddresPrint');
      pName = (preferences.getString('printer_name') ?? '');
      pConnected = 1;
    });
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

  void back() {
    Navigator.of(context).pop();
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => Dashboard()));
  }

  // Future<bool> _onWillPop() {
  //   back();
  // }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    getPrint();
    if (pConnected == 0) {
      setState(() => isSwitched = false);
    } else {
      setState(() => isSwitched = true);
    }
    initPlatformState();
    _appPrint = AppPrint();
    super.initState();
  }

  Future<void> initPlatformState() async {
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected!) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Pengaturan Printer',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (xontext) => ErrorHandlingView()));
                          },
                          child: const Icon(EvaIcons.bellOutline,
                              color: Colors.white)),
                    ],
                  ),
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
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formkey,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 25, 5, 10),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.bluetooth,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bluetooth',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  AppSettings.openBluetoothSettings();
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Nyalakan Bluetooth',
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              indent: MediaQuery.of(context).size.width * 0.15,
                              color: Colors.grey,
                              height: 1,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.wifi,
                                color: Colors.blue,
                                size: 30,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Auto Connect',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "Jika auto connect digunakan, bluetooth dan printer harus dalam keadaan menyala!",
                                        maxLines: 4,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value;
                                    if (value == false) {
                                      pConnected = 0;
                                    } else {
                                      pConnected = 1;
                                    }
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              indent: MediaQuery.of(context).size.width * 0.12,
                              color: Colors.grey,
                              height: 1,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.print,
                                      color: Colors.blue, size: 30),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pilih thermal printer',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Silahkan pilih thermal printernya terlebih dahulu.",
                                            maxLines: 4,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SafeArea(
                                top: false,
                                left: false,
                                right: false,
                                bottom: false,
                                child: Container(
                                  child: DropdownButton(
                                    items: _getDeviceItems(),
                                    onChanged: (dynamic value) {
                                      setState(() {
                                        _device = value;
                                      });
                                    },
                                    value: _device,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _scaffoldKey.currentState!
                                      // ignore: deprecated_member_use
                                      .showSnackBar(new SnackBar(
                                    duration: new Duration(seconds: 2),
                                    content: new Row(
                                      children: <Widget>[
                                        new CircularProgressIndicator(),
                                        new Text("  Refresh...")
                                      ],
                                    ),
                                  ));
                                  initPlatformState();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: SvgPicture.asset('assets/reset.svg'),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                  primary: HexColor('#FFCC00').withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    _connected ? _disconnect : _connect,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Text(
                                    _connected ? 'Disconnect' : 'Connect',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                  primary: HexColor('#05C270').withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  savePrint(addressDevice, nameDevice);
                                  updatePrint();
                                  print(addressDevice + ' ' + nameDevice);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.blue,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                  primary: HexColor('#0063F8').withOpacity(0.1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Divider(
                              indent: MediaQuery.of(context).size.width * 0.15,
                              color: Colors.grey,
                              height: 1,
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 20),
                        child: Center(
                          child: Text(
                              _connected ? 'Connected to ' + nameDevice : ''),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Center(
                          child: Text(_connected
                              ? 'Connected to ' + addressDevice
                              : ''),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ElevatedButton(
                          onPressed: () {
                            _appPrint!.tesPrint();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: HexColor('#FF8801'),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                            child: Text(
                              "Cetak Sekarang",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              color: Colors.white),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        setState(() {
          nameDevice = device.name!;
          addressDevice = device.address!;
          pName = device.name;
          pAddress = device.address;
          check();
        });
        items.add(DropdownMenuItem(
          child: Text(device.name!),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device == null) {
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = true);
  }
}
