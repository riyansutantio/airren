import 'dart:convert';

PamTransUserModel pamTransModelFromJson(String str) =>
    PamTransUserModel.fromJson(json.decode(str));

DataTrans dataTransModelFromJson(String str) =>
    DataTrans.fromJson(json.decode(str));

class PamTransUserModel {
  PamTransUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataTrans? data;

  factory PamTransUserModel.fromJson(Map<String, dynamic> json) =>
      PamTransUserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataTrans.fromJson(json["data"]),
      );
}

class DataTrans {
  DataTrans({this.transModel, this.totalBalance});

  final List<PamTransactionsModel>? transModel;
  final int? totalBalance;

  factory DataTrans.fromJson(Map<String, dynamic> json) => DataTrans(
        totalBalance: json["total_balance"] == null ? null : json["total_balance"],
        transModel: json["pamTransactions"] == null
            ? null
            : List<PamTransactionsModel>.from(json["pamTransactions"]
                .map((x) => PamTransactionsModel.fromJson(x))),
      );
}

class PamTransactionsModel {
  PamTransactionsModel(
      {this.id,
      this.name,
      this.type,
      this.pamId,
      this.amount,
      this.description,
      this.createdAt,
      this.updatedAt});

  final String? name;
  final int? id;
  final String? type;
  final int? amount;
  final String? description;
  final int? pamId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  factory PamTransactionsModel.fromJson(Map<String, dynamic> json) =>
      PamTransactionsModel(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        amount: json["amount"] == null ? null : json["amount"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        pamId: json["pam_id"] == null ? null : json["pam_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
