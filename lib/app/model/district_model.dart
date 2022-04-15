import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

class DistrictModel {
  DistrictModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataDistrict? data;

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DataDistrict.fromJson(json["data"]),
  );
}

class DataDistrict {
  DataDistrict({
    this.districts,
  });

  final List<District>? districts;

  factory DataDistrict.fromJson(Map<String, dynamic> json) => DataDistrict(
    districts: json["districts"] == null ? null : List<District>.from(json["districts"].map((x) => District.fromJson(x))),
  );
}

class District {
  District({
    this.id,
    this.regencyId,
    this.name,
  });

  final int? id;
  final int? regencyId;
  final String? name;

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"] == null ? null : json["id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    name: json["name"] == null ? null : json["name"],
  );
}
