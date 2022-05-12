import 'dart:convert';

import 'package:airen/app/model/register_model.dart';

PdfTransactionUserModel PdfTransactionModelFromJson(String str) =>
    PdfTransactionUserModel.fromJson(json.decode(str));

DataPdfTransaction dataTransModelFromJson(String str) =>
    DataPdfTransaction.fromJson(json.decode(str));

class PdfTransactionUserModel {
  PdfTransactionUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataPdfTransaction? data;

  factory PdfTransactionUserModel.fromJson(Map<String, dynamic> json) =>
      PdfTransactionUserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : DataPdfTransaction.fromJson(json["data"]),
      );
}

class DataPdfTransaction {
  DataPdfTransaction(
      {this.pdfTransaction,
      this.priode,
      this.pamOwner,
      this.printDayname,
      this.pamTreasurer,
      this.title,
      this.totalTransactions,
      this.printDate,
      this.pam});

  final List<TransModel>? pdfTransaction;

  final String? priode;
  final String? pamOwner;
  final String? title;
  final int? totalTransactions;
  final String? printDayname;
  final String? pamTreasurer;
  final String? printDate;
  final Pam? pam;
  factory DataPdfTransaction.fromJson(Map<String, dynamic> json) =>
      DataPdfTransaction(
        pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
        pamOwner: json["pam_owner"] == null ? null : json["pam_owner"],
        priode: json["period"] == null ? null : json["period"],
        totalTransactions: json["total_transactions"] == null
            ? null
            : json["total_transactions"],
        title: json["title"] == null ? null : json["title"],
        pamTreasurer:
            json["pam_treasurer"] == null ? null : json["pam_treasurer"],
        printDate: json["download_date"] == null ? null : json["download_date"],
        printDayname:
            json["download_dayname"] == null ? null : json["download_dayname"],
        pdfTransaction: json["transactions"] == null
            ? null
            : List<TransModel>.from(
                json["transactions"].map((x) => TransModel.fromJson(x))),
      );
}

class TransModel {
  TransModel(
      {this.id,
      this.name,
      this.type,
      this.pamId,
      this.amount,
      this.description,
      this.isMeterTransaction,
      this.createdAt,
      this.updatedAt});

  final String? name;
  final int? id;
  final String? type;
  final int? amount;
  final int? isMeterTransaction;
  final String? description;
  final int? pamId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  factory TransModel.fromJson(Map<String, dynamic> json) => TransModel(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        amount: json["amount"] == null ? null : json["amount"],
        isMeterTransaction: json["is_meter_transaction"] == null
            ? null
            : json["is_meter_transaction"],
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
