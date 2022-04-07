import 'dart:convert';

BaseFeeModel baseFeeModelFromJson(String str) => BaseFeeModel.fromJson(json.decode(str));

class BaseFeeModel {
  BaseFeeModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory BaseFeeModel.fromJson(Map<String, dynamic> json) => BaseFeeModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.baseFees,
  });

  final List<BaseFeeResult>? baseFees;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    baseFees: json["baseFees"] == null ? null : List<BaseFeeResult>.from(json["baseFees"].map((x) => BaseFeeResult.fromJson(x))),
  );
}

class BaseFeeResult {
  BaseFeeResult({
    this.id,
    this.pamId,
    this.amount,
    this.meterPosition,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? pamId;
  final int? amount;
  final String? meterPosition;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory BaseFeeResult.fromJson(Map<String, dynamic> json) => BaseFeeResult(
    id: json["id"] == null ? null : json["id"],
    pamId: json["pam_id"] == null ? null : json["pam_id"],
    amount: json["amount"] == null ? null : json["amount"],
    meterPosition: json["meter_position"] == null ? null : json["meter_position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
