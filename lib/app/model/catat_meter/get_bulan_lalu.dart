import 'dart:convert';

GetBulanLalu GetBulanLaluFromJson(String str) =>
    GetBulanLalu.fromJson(json.decode(str));

class GetBulanLalu {
  GetBulanLalu({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataBulanLalu? data;

  factory GetBulanLalu.fromJson(Map<String, dynamic> json) => GetBulanLalu(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : DataBulanLalu.fromJson(json["data"]),
      );
}

class DataBulanLalu {
  DataBulanLalu({
    this.meter_start,
  });

  final String? meter_start;

  factory DataBulanLalu.fromJson(Map<String, dynamic> json) => DataBulanLalu(
        meter_start: json["meter_start"] == null ? null : json["meter_start"],
      );
}
