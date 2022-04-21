import 'dart:convert';

CusUserModel CusUserModelFromJson(String str) =>
    CusUserModel.fromJson(json.decode(str));

class CusUserModel {
  CusUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory CusUserModel.fromJson(Map<String, dynamic> json) => CusUserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.cusMs,
  });

  final List<CustomerModel>? cusMs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cusMs: json["consumers"] == null
            ? null
            : List<CustomerModel>.from(
                json["consumers"].map((x) => CustomerModel.fromJson(x))),
      );
}

class CustomerModel {
  CustomerModel(
      {this.name,
      this.uniqueId,
      this.pamId,
      this.address,
      this.phoneNumber,
      this.meter,
      this.active,
      this.createdAt,
      this.updatedAt});

  final String? name;
  final String? uniqueId;
  final String? address;
  final String? phoneNumber;
  final String? meter;
  final int? active;
  final int? pamId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        name: json["name"] == null ? null : json["name"],
        uniqueId: json["unique_id"] == null ? null : json["unique_id"],
        address: json["full_address"] == null ? null : json["full_address"],
        meter: json["start_meter"] == null ? null : json["start_meter"],
        active: json["is_active"] == null ? null : json["is_active"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        pamId: json["pam_id"] == null ? null : json["pam_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
