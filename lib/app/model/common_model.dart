import 'dart:convert';

CommonModel commonPamManageModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

class CommonModel {
  CommonModel({
    this.status,
    this.message,
  });

  final String? status;
  final String? message;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );
}
