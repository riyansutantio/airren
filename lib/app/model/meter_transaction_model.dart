import 'dart:convert';

MeterTransModel MeterTransModelFromJson(String str) =>
    MeterTransModel.fromJson(json.decode(str));

class MeterTransModel {
  MeterTransModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory MeterTransModel.fromJson(Map<String, dynamic> json) =>
      MeterTransModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.cusMs,
  });

  final List<TransactionModel>? cusMs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cusMs: json["meterMonths"] == null
            ? null
            : List<TransactionModel>.from(
                json["meterMonths"].map((x) => TransactionModel.fromJson(x))),
      );
}

class TransactionModel {
  TransactionModel(
      {this.id,
      this.pamId,
      this.name,
      this.monthof,
      this.yearof,
      this.numberofconsumer,
      this.numberofrecordedconsumer,
      this.numberofmetertransaction,
      this.numberOfPaidMeterTransaction,
      this.createdAt,
      this.updatedAt});

  final String? name;
  final int? id;
  final int? monthof;
  final int? yearof;
  final int? numberofconsumer;
  final int? numberofrecordedconsumer;
  final int? numberofmetertransaction;
  final int? pamId;
  final int? numberOfPaidMeterTransaction;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        monthof: json["month_of"] == null ? null : json["month_of"],
        yearof: json["year_of"] == null ? null : json["year_of"],
        numberofconsumer: json["number_of_consumer"] == null
            ? null
            : json["number_of_consumer"],
        numberofrecordedconsumer: json["number_of_recorded_consumer"] == null
            ? null
            : json["number_of_recorded_consumer"],
        numberofmetertransaction: json["number_of_meter_transaction"] == null
            ? null
            : json["number_of_meter_transaction"],
        numberOfPaidMeterTransaction:
            json["number_of_paid_meter_transaction"] == null
                ? null
                : json["number_of_paid_meter_transaction"],
        pamId: json["pam_id"] == null ? null : json["pam_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
