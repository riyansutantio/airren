// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

class ProvinceModel {
  ProvinceModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataProvince? data;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DataProvince.fromJson(json["data"]),
  );
}

class DataProvince {
  DataProvince({
    this.provinces,
  });

  final List<Province>? provinces;

  factory DataProvince.fromJson(Map<String, dynamic> json) => DataProvince(
    provinces: json["provinces"] == null ? null : List<Province>.from(json["provinces"].map((x) => Province.fromJson(x))),
  );
}

class Province {
  Province({
    this.id,
    this.name,
  });

  final int? id;
  final String? name;


  factory Province.fromJson(Map<String, dynamic> json) => Province(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );
}
