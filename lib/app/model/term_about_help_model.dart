import 'dart:convert';

TermAboutHelpModel termAboutHelpModelFromJson(String str) => TermAboutHelpModel.fromJson(json.decode(str));

class TermAboutHelpModel {
  TermAboutHelpModel({
    this.status,
    this.data,
  });

  final String? status;
  final ResultTermAboutHelp? data;

  factory TermAboutHelpModel.fromJson(Map<String, dynamic> json) => TermAboutHelpModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : ResultTermAboutHelp.fromJson(json["data"]),
  );
}

class ResultTermAboutHelp {
  ResultTermAboutHelp({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ResultTermAboutHelp.fromJson(Map<String, dynamic> json) => ResultTermAboutHelp(
    id: json["id"] == null ? null : json["id"],
    content: json["content"] == null ? null : json["content"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
