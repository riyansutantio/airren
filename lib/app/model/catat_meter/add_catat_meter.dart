import 'dart:convert';

AddCatatMeter addCatatMeterModelFromJson(String str) => AddCatatMeter.fromJson(json.decode(str));

class AddCatatMeter {
  AddCatatMeter({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory AddCatatMeter.fromJson(Map<String, dynamic> json) => AddCatatMeter(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.meters,
  });

  final CatatMeterBulan? meters;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    meters: json["meters"] == null ? null : CatatMeterBulan.fromJson(json["meters"]),
  );
}

class CatatMeterBulan {
  CatatMeterBulan({
  this.consumer_unique_id,
  this.meter_now,
  });

  
  final String? consumer_unique_id;
  final String? meter_now;

  factory CatatMeterBulan.fromJson(Map<String, dynamic> json) => CatatMeterBulan(
    consumer_unique_id: json["consumer_unique_id"] == null ? null : json["consumer_unique_id"],
    meter_now: json["meter_now"] == null ? null : json["meter_now"],
  );
}