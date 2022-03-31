import 'dart:convert';

LogOutModel logOutModelFromJson(String str) => LogOutModel.fromJson(json.decode(str));

class LogOutModel {
  LogOutModel({
    this.status,
    this.message,
  });

  final String? status;
  final String? message;

  factory LogOutModel.fromJson(Map<String, dynamic> json) => LogOutModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );
}
