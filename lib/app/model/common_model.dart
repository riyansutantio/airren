import 'dart:convert';

CommonPamManageModel commonPamManageModelFromJson(String str) => CommonPamManageModel.fromJson(json.decode(str));

class CommonPamManageModel {
  CommonPamManageModel({
    this.status,
    this.message,
  });

  final String? status;
  final String? message;

  factory CommonPamManageModel.fromJson(Map<String, dynamic> json) => CommonPamManageModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );
}
