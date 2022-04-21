import 'dart:convert';

AddCatatMeterBulanModel addCatatMeterBulanModelFromJson(String str) => AddCatatMeterBulanModel.fromJson(json.decode(str));

class AddCatatMeterBulanModel {
  AddCatatMeterBulanModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory AddCatatMeterBulanModel.fromJson(Map<String, dynamic> json) => AddCatatMeterBulanModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.catatMeterBulan,
  });

  final CatatMeterBulan? catatMeterBulan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    catatMeterBulan: json["catatMeterBulan"] == null ? null : CatatMeterBulan.fromJson(json["catatMeterBulan"]),
  );
}

class CatatMeterBulan {
  CatatMeterBulan({
  this.month_of,
  this.year_of,
  });

  
  final int? month_of;
  final int? year_of;

  factory CatatMeterBulan.fromJson(Map<String, dynamic> json) => CatatMeterBulan(
    month_of: json["month_of"] == null ? null : json["month_of"],
    year_of: json["year_of"] == null ? null : json["year_of"],
  );
}