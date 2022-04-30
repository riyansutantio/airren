import 'dart:convert';

import 'package:airen/app/model/register_model.dart';

ReportYearUserModel ReportYearModelFromJson(String str) =>
    ReportYearUserModel.fromJson(json.decode(str));

DataReportYear dataTransModelFromJson(String str) =>
    DataReportYear.fromJson(json.decode(str));

class ReportYearUserModel {
  ReportYearUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataReportYear? data;

  factory ReportYearUserModel.fromJson(Map<String, dynamic> json) =>
      ReportYearUserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : DataReportYear.fromJson(json["data"]),
      );
}

class DataReportYear {
  DataReportYear(
      {this.reportYear,
      this.priode,
      this.pamOwner,
      this.printDayname,
      this.pamTreasurer,
      this.printDate,
      this.pam});

  final List<ReportYearactionsModel>? reportYear;
  final String? priode;
  final String? pamOwner;
  final String? pamTreasurer;
  final String? printDate;
  final String? printDayname;
  final Pam? pam;
  factory DataReportYear.fromJson(Map<String, dynamic> json) => DataReportYear(
        pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
        priode: json["period"] == null ? null : json["period"],
        pamOwner: json["pam_owner"] == null ? null : json["pam_owner"],
        pamTreasurer:
            json["pam_treasurer"] == null ? null : json["pam_treasurer"],
        printDate: json["print_date"] == null ? null : json["print_date"],
        printDayname:
            json["print_dayname"] == null ? null : json["print_dayname"],
        reportYear: json["yearlyReport"] == null
            ? null
            : List<ReportYearactionsModel>.from(json["yearlyReport"]
                .map((x) => ReportYearactionsModel.fromJson(x))),
      );
}

class ReportYearactionsModel {
  ReportYearactionsModel({
    this.desc,
    this.amount,
    this.balance,
  });

  final String? desc;
  final int? balance;
  final int? amount;
  factory ReportYearactionsModel.fromJson(Map<String, dynamic> json) =>
      ReportYearactionsModel(
        desc: json["desc"] == null ? null : json["desc"],
        balance: json["balance"] == null ? null : json["balance"],
        amount: json["amount"] == null
            ? null
            : json["amount"] == "-"
                ? 0
                : json["amount"],
      );
}
