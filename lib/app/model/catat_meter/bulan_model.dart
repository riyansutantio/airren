import 'dart:convert';

MeterMonthModel meterMonthModelFromJson(String str) =>
    MeterMonthModel.fromJson(json.decode(str));

class MeterMonthModel {
  MeterMonthModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory MeterMonthModel.fromJson(Map<String, dynamic> json) =>
      MeterMonthModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({this.meterMonths});

  final List<MonthMeterResult>? meterMonths;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        meterMonths: json['meterMonths'] == null
            ? null
            : List<MonthMeterResult>.from(
                json['meterMonths'].map((x) => MonthMeterResult.fromJson(x))),
      );
}

class MonthMeterResult {
  MonthMeterResult({
    this.id,
    this.month_of,
    this.year_of,
    this.created_at,
    this.updated_at,
    this.number_of_consumer,
    this.number_of_recorded_consumer,
    this.number_of_meter_transaction,
    this.number_of_paid_meter_transaction,
  });

  final int? id;
  final int? month_of;
  final int? year_of;
  final DateTime? created_at;
  final DateTime? updated_at;
  final int? number_of_consumer;
  final int? number_of_recorded_consumer;
  final int? number_of_meter_transaction;
  final int? number_of_paid_meter_transaction;

  factory MonthMeterResult.fromJson(Map<String, dynamic> json) =>
      MonthMeterResult(
        id: json["id"] == null ? null : json['id'],
        month_of: json["month_of"] == null ? null : json['month_of'],
        year_of: json["year_of"] == null ? null : json['year_of'],
        created_at:
            json["year_of"] == null ? null : DateTime.parse(json["created_at"]),
        updated_at:
            json["year_of"] == null ? null : DateTime.parse(json["updated_at"]),
        number_of_consumer: json["number_of_consumer"] == null
            ? null
            : json['number_of_consumer'],
        number_of_recorded_consumer: json["number_of_recorded_consumer"] == null
            ? null
            : json['number_of_recorded_consumer'],
        number_of_meter_transaction: json["number_of_meter_transaction"] == null
            ? null
            : json['number_of_meter_transaction'],
        number_of_paid_meter_transaction:
            json["number_of_paid_meter_transaction"] == null
                ? null
                : json['number_of_paid_meter_transaction'],
      );
}

class YearAvailable {
  YearAvailable({
    // this.id_catat,
    this.year_of,
  });
  // final int? id_catat;
  final int? year_of;

  factory YearAvailable.fromJson(Map<String, dynamic> json) => YearAvailable(
        // id_catat: json['id_catat'] == null ? null : json['id_catat'],
        year_of: json['year_of'] == null ? null : json['year_of'],
      );
}
