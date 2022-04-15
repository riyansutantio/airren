import 'dart:convert';

RegencyModel regencyModelFromJson(String str) => RegencyModel.fromJson(json.decode(str));

class RegencyModel {
  RegencyModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory RegencyModel.fromJson(Map<String, dynamic> json) => RegencyModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.regencies,
  });

  final List<Regency>? regencies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    regencies: json["regencies"] == null ? null : List<Regency>.from(json["regencies"].map((x) => Regency.fromJson(x))),
  );
}

class Regency {
  Regency({
    this.id,
    this.provinceId,
    this.name,
  });

  final int? id;
  final int? provinceId;
  final String? name;

  factory Regency.fromJson(Map<String, dynamic> json) => Regency(
    id: json["id"] == null ? null : json["id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    name: json["name"] == null ? null : json["name"],
  );
}
