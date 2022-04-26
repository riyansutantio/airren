import 'dart:convert';

import 'meter_transactionAll_model.dart';
import 'register_model.dart';

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

class InvoiceModel {
  InvoiceModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataInvoice? data;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataInvoice.fromJson(json["data"]),
      );
}

class DataInvoice {
  DataInvoice({this.pam, this.tm, this.cusMs,});

  final Pam? pam;
  final TransactionAllModel? tm;
  final List<CostDetail>? cusMs;

  factory DataInvoice.fromJson(Map<String, dynamic> json) => DataInvoice(
        pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
        tm: json["meterTransaction"] == null
            ? null
            : TransactionAllModel.fromJson(json["meterTransaction"]),
        cusMs: json["costDetails"] == null
            ? null
            : List<CostDetail>.from(
                json["costDetails"].map((x) => CostDetail.fromJson(x))),
      );
}

class CostDetail {
  CostDetail({
    this.meter,
    this.cost,
    this.total,
  });

  final int? meter;
  final int? cost;
  final String? total;

  factory CostDetail.fromJson(Map<String, dynamic> json) => CostDetail(
        meter: json["meter"] == null ? null : json["meter"],
        cost: json["cost"] == null ? null : json["cost"],
        total: json["total"] == null ? null : json["total"],
      );
}
