import 'dart:convert';

MeterTransMonthModel MeterTransModelAllFromJson(String str) =>
    MeterTransMonthModel.fromJson(json.decode(str));

class MeterTransMonthModel {
  MeterTransMonthModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory MeterTransMonthModel.fromJson(Map<String, dynamic> json) =>
      MeterTransMonthModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.cusMs,
  });

  final List<TransactionAllModel>? cusMs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cusMs: json["meterTransactions"] == null
            ? null
            : List<TransactionAllModel>.from(
                json["meterTransactions"].map((x) => TransactionAllModel.fromJson(x))),
      );
}

class TransactionAllModel {
  TransactionAllModel(
      {this.id,
      this.pamId,
      this.name,
      this.amount,
      this.status,
      this.meterLast,
      this.meterNow,
      this.meterMonthName,
      this.meterMonthOf,
      this.meterMonthYearOf,
      this.uniqueId,
      this.address,
      this.phoneNumber,
      this.starMeter,
      this.dueDate,
      this.createdAt,
      this.updatedAt});

  final String? name;
  final int? id;
  final int? pamId;
  final int? amount;
  final String? status;
  final String? meterLast;
  final String? meterNow;
  final String? meterMonthName;
  final String? meterMonthOf;
  final String? meterMonthYearOf;
  final String? uniqueId;
  final String? address;
  final String? phoneNumber;
  final String? starMeter;
  final DateTime? dueDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  factory TransactionAllModel.fromJson(Map<String, dynamic> json) =>
      TransactionAllModel(
        name: json["consumer_name"] == null ? null : json["consumer_name"],
        id: json["id"] == null ? null : json["id"],
        amount: json["amount"] == null ? null : json["amount"],
        status: json["status"] == null ? null : json["status"],
        meterLast: json["meter_last"] == null
            ? null
            : json["meter_last"],
        meterNow: json["meter_now"] == null
            ? null
            : json["meter_now"],
        meterMonthName: json["meter_month_name"] == null
            ? null
            : json["meter_month_name"],
        meterMonthOf:
            json["meter_month_of"] == null
                ? null
                : json["meter_month_of"],
        meterMonthYearOf:
            json["meter_month_year_of"] == null
                ? null
                : json["meter_month_year_of"],
        uniqueId:
            json["consumer_unique_id"] == null
                ? null
                : json["consumer_unique_id"],
        pamId: json["pam_id"] == null ? null : json["pam_id"],
        address: json["consumer_full_address"] == null ? null : json["consumer_full_address"],
        phoneNumber: json["consumer_phone_number"] == null ? null : json["consumer_phone_number"],
        starMeter: json["consumer_start_meter"] == null ? null : json["consumer_start_meter"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        dueDate: json["due_date"] == null
            ? null
            : DateTime.parse(json["due_date"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
