import 'package:blue_thermal_printer/blue_thermal_printer.dart';

class AppPrint {
  BlueThermalPrinter con = BlueThermalPrinter.instance;

  String stripe1 = '==============================';
  String stripe2 = '------------------------------';
  String pesan3 = 'Test Print Berhasil';
  String pesan4 = '';

  testPrint() async {
    con.isConnected.then((isConnected) {
      if (isConnected!) {
        con.printNewLine();
        con.printCustom("ALTA POS2", 1, 1);
        con.printCustom("PEKALONGAN", 1, 1);
        con.printCustom(stripe2, 3, 1);
        con.printCustom(stripe2, 3, 1);
        con.printNewLine();
        con.printCustom(pesan3, 2, 1);
        con.printCustom(stripe2, 3, 1);
        con.printNewLine();
        con.printNewLine();
        con.printNewLine();
      }
    });
  }
}

class Printer {
  int? id;
  String? _name;
  String? _address;
  int? _connected;

  Printer(this._name, this._address, this._connected);

  Printer.map(dynamic obj) {
    this._name = obj['name'];
    this._address = obj['address'];
    this._connected = obj['connected'];
  }

  String? get name => _name;
  String? get address => _address;
  int? get connected => _connected;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = _name;
    map['address'] = _address;
    map['connected'] = _connected;

    return map;
  }

  void setPrintId(int? id) {
    this.id = id;
  }
}