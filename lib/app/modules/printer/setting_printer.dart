import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/printer.dart';


import 'package:app_settings/app_settings.dart';
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
      appBar: AppBar(
          title: Text(
            'Setting Printer',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16.0),
          ),
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              back();
            },
          )),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                        AppSettings.openBluetoothSettings();
                        },
                        child: Text(
                          'Nyalakan Bluetooth',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Text('Auto Connect'),
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
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                    child: Text('Pilih Bluetooth Device Printer'),
                  ),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
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
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.brown,
                        onPressed: () {
                          _scaffoldKey.currentState!.showSnackBar(new SnackBar(
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
                        child: Text(
                          'Refresh',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      RaisedButton(
                        color: _connected ? Colors.red : Colors.green,
                        onPressed: _connected ? _disconnect : _connect,
                        child: Text(
                          _connected ? 'Disconnect' : 'Connect',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          savePrint(addressDevice, nameDevice);
                          updatePrint();
                          print(addressDevice + ' ' + nameDevice);
                        },
                        child: Text(
                          'Simpan Printer',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                    child: Center(
                      child: Text(
                          'Jika auto connect di gunakan, Bluetooth Device dan Printer harus menyala !'),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                    child: Center(
                      child:
                          Text(_connected ? 'Connected to ' + nameDevice : ''),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Center(
                      child: Text(
                          _connected ? 'Connected to ' + addressDevice : ''),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
                    child: RaisedButton(
                      color: Colors.green,
                      onPressed: () {
                        _appPrint!.testPrint();
                      },
                      child: Text('Test Print',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
