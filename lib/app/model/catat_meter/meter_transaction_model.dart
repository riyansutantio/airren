import 'dart:convert';

MeterTransactionModel meterTransactionModelFromJson(String str) =>
    MeterTransactionModel.fromJson(json.decode(str));

class MeterTransactionModel {
  MeterTransactionModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory MeterTransactionModel.fromJson(Map<String, dynamic> json) =>
      MeterTransactionModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({this.meterTransactions});

  final List<MeterTransactionResult>? meterTransactions;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meterTransactions: json['meterTransactions'] == null
            ? null
            : List<MeterTransactionResult>.from(json['meterTransactions']
                .map((x) => MeterTransactionResult.fromJson(x))),
      );
}

class MeterTransactionResult {
  MeterTransactionResult({
    this.id,
    this.pam_id,
    this.amount,
    this.status,
    this.meter_last,
    this.meter_now,
    this.meter_month_name,
    this.meter_month_of,
    this.meter_month_year_of,
    this.consumer_unique_id,
    this.consumer_name,
    this.consumer_full_address,
    this.consumer_phone_number,
    this.consumer_start_meter,
    this.charge,
    this.due_date,
    this.admin_fee,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? pam_id;
  final int? amount;
  final String? status;
  final String? meter_last;
  final String? meter_now;
  final String? meter_month_name;
  final String? meter_month_of;
  final String? meter_month_year_of;
  final String? consumer_unique_id;
  final String? consumer_name;
  final String? consumer_full_address;
  final String? consumer_phone_number;
  final String? consumer_start_meter;
  final int? charge;
  final int? admin_fee;
  final DateTime? due_date;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  factory MeterTransactionResult.fromJson(Map<String, dynamic> json) =>
      MeterTransactionResult(
        id: json["id"] == null ? null : json['id'],
        pam_id: json["pam_id"] == null ? null : json['pam_id'],
        amount: json["amount"] == null ? null : json['amount'],
        status: json["status"] == null ? null : json['status'],
        charge: json["charge"] == null ? null : json['charge'],
        admin_fee: json["admin_fee"] == null ? null : json['admin_fee'],
        due_date:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        consumer_start_meter: json["consumer_start_meter"] == null
            ? null
            : json['consumer_start_meter'],
        meter_last: json["meter_last"] == null ? null : json['meter_last'],
        meter_now: json["meter_now"] == null ? null : json['meter_now'],
        meter_month_of:
            json["meter_month_of"] == null ? null : json['meter_month_of'],
        meter_month_year_of: json["meter_month_year_of"] == null
            ? null
            : json['meter_month_year_of'],
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
      );
}
