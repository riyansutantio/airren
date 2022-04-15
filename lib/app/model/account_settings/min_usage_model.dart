import 'dart:convert';

MinUsageModel minUsageModelFromJson(String str) => MinUsageModel.fromJson(json.decode(str));

class MinUsageModel {
  MinUsageModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory MinUsageModel.fromJson(Map<String, dynamic> json) => MinUsageModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.pam,
  });

  final PamResultMinUsage? pam;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pam: json["pam"] == null ? null : PamResultMinUsage.fromJson(json["pam"]),
  );
}

class PamResultMinUsage {
  PamResultMinUsage({
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
    this.isPostpaid,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic photoName;
  final dynamic photoPath;
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
  final String? minUsage;
  final int? isPostpaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory PamResultMinUsage.fromJson(Map<String, dynamic> json) => PamResultMinUsage(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    photoName: json["photo_name"],
    photoPath: json["photo_path"],
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
    minUsage: json["min_usage"] == null ? null : json["min_usage"],
    isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
