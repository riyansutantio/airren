import 'dart:convert';

CatatMeterModel catatMeterModelFromJson(String str) =>
    CatatMeterModel.fromJson(json.decode(str));

class CatatMeterModel {
  CatatMeterModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory CatatMeterModel.fromJson(Map<String, dynamic> json) =>
      CatatMeterModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({this.meters});

  final List<CatatMeterResult>? meters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meters: json['meters'] == null
            ? null
            : List<CatatMeterResult>.from(
                json['meters'].map((x) => CatatMeterResult.fromJson(x))),
      );
}

class CatatMeterResult {
  CatatMeterResult({
    this.id,
    this.pam_id,
    this.meter_last,
    this.meter_now,
    this.meter_month_of,
    this.meter_year_of,
    this.consumer_unique_id,
    this.consumer_name,
    this.consumer_full_address,
    this.consumer_phone_number,
    this.createdAt,
    this.updatedAt,
    this.is_published,
    this.meter_transaction_id,
  });

  final int? id;
  final int? pam_id;
  final String? meter_last;
  final String? meter_now;
  final String? meter_month_of;
  final String? meter_year_of;
  final String? consumer_unique_id;
  final String? consumer_name;
  final String? consumer_full_address;
  final String? consumer_phone_number;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? is_published;
  final int? meter_transaction_id;

  factory CatatMeterResult.fromJson(Map<String, dynamic> json) =>
      CatatMeterResult(
        id: json["id"] == null ? null : json['id'],
        pam_id: json["pam_id"] == null ? null : json['pam_id'],
        meter_last: json["meter_last"] == null ? null : json['meter_last'],
        meter_now: json["meter_now"] == null ? null : json['meter_now'],
        meter_month_of:
            json["meter_month_of"] == null ? null : json['meter_month_of'],
        meter_year_of:
            json["meter_year_of"] == null ? null : json['meter_year_of'],
        consumer_unique_id: json["consumer_unique_id"] == null
            ? null
            : json['consumer_unique_id'],
        consumer_name:
            json["consumer_name"] == null ? null : json['consumer_name'],
        consumer_full_address: json["consumer_full_address"] == null
            ? null
            : json['consumer_full_address'],
        consumer_phone_number: json["consumer_phone_number"] == null
            ? null
            : json['consumer_phone_number'],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        is_published:
            json["is_published"] == null ? null : json['is_published'],
        meter_transaction_id: json["meter_transaction_id"] == null
            ? null
            : json['meter_transaction_id'],
      );
}
