import 'dart:convert';

AddTagihan addTagihanModelFromJson(String str) => AddTagihan.fromJson(json.decode(str));

class AddTagihan {
  AddTagihan({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory AddTagihan.fromJson(Map<String, dynamic> json) => AddTagihan(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.tagihan,
  });

  final Tagihan? tagihan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tagihan: json["tagihan"] == null ? null : Tagihan.fromJson(json["tagihan"]),
  );
}

class Tagihan {
  Tagihan({
  this.consumer_unique_id,
  this.meter_now,
  this.meter_last,
  this.consumer_name,
  this.consumer_full_address,
  this.consumer_phone_number,
  });

  
  final String? consumer_unique_id;
  final String? meter_now;
  final String? meter_last;
  final String? consumer_name;
  final String? consumer_full_address;
  final String? consumer_phone_number;

  factory Tagihan.fromJson(Map<String, dynamic> json) => Tagihan(
    consumer_unique_id: json["consumer_unique_id"] == null ? null : json["consumer_unique_id"],
    meter_now: json["meter_now"] == null ? null : json["meter_now"],
    meter_last: json["meter_last"] == null ? null : json["meter_last"],
    consumer_name: json["consumer_name"] == null ? null : json["consumer_name"],
    consumer_full_address: json["consumer_full_address"] == null ? null : json["consumer_full_address"],
    consumer_phone_number: json["consumer_phone_number"] == null ? null : json["consumer_phone_number"],
  );
}