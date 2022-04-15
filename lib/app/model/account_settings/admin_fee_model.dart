import 'dart:convert';

AdminFeeModel adminFeeModelFromJson(String str) => AdminFeeModel.fromJson(json.decode(str));

class AdminFeeModel {
  AdminFeeModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory AdminFeeModel.fromJson(Map<String, dynamic> json) => AdminFeeModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.pam,
  });

  final Pam? pam;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
      );
}

class Pam {
  Pam({
    this.id,
    this.name,
    this.photoName,
    this.photoPath,
    this.dateStart,
    this.dateEnd,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.detailAddress,
    this.blocked,
    this.blockedAt,
    this.charge,
    this.chargeDueDate,
    this.minUsage,
    this.adminFee,
    this.isPostpaid,
    this.createdAt,
    this.updatedAt,
    this.province,
    this.regency,
    this.district,
  });

  final int? id;
  final String? name;
  final dynamic photoName;
  final String? photoPath;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final int? provinceId;
  final int? regencyId;
  final int? districtId;
  final String? detailAddress;
  final int? blocked;
  final dynamic blockedAt;
  final dynamic charge;
  final dynamic chargeDueDate;
  final dynamic minUsage;
  final int? adminFee;
  final int? isPostpaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Location? province;
  final Location? regency;
  final Location? district;

  factory Pam.fromJson(Map<String, dynamic> json) => Pam(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photoName: json["photo_name"],
        photoPath: json["photo_path"] == null ? null : json["photo_path"],
        dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
        dateEnd: json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        provinceId: json["province_id"] == null ? null : json["province_id"],
        regencyId: json["regency_id"] == null ? null : json["regency_id"],
        districtId: json["district_id"] == null ? null : json["district_id"],
        detailAddress: json["detail_address"] == null ? null : json["detail_address"],
        blocked: json["blocked"] == null ? null : json["blocked"],
        blockedAt: json["blocked_at"],
        charge: json["charge"],
        chargeDueDate: json["charge_due_date"],
        minUsage: json["min_usage"],
        adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
        isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        province: json["province"] == null ? null : Location.fromJson(json["province"]),
        regency: json["regency"] == null ? null : Location.fromJson(json["regency"]),
        district: json["district"] == null ? null : Location.fromJson(json["district"]),
      );
}

class Location {
  Location({
    this.name,
  });

  final String? name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"] == null ? null : json["name"],
      );
}
