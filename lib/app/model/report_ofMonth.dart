import 'dart:convert';

import 'package:airen/app/model/register_model.dart';

ReportMonthUserModel ReportMonthModelFromJson(String str) =>
    ReportMonthUserModel.fromJson(json.decode(str));

DataReportMonth dataTransModelFromJson(String str) =>
    DataReportMonth.fromJson(json.decode(str));

class ReportMonthUserModel {
  ReportMonthUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final DataReportMonth? data;

  factory ReportMonthUserModel.fromJson(Map<String, dynamic> json) =>
      ReportMonthUserModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : DataReportMonth.fromJson(json["data"]),
      );
}

class DataReportMonth {
  DataReportMonth(
      {this.reportMonth,
      this.priode,
      this.pamOwner,
      this.printDayname,
      this.pamTreasurer,
      this.printDate,
      this.pam});

  final List<ReportMonthactionsModel>? reportMonth;

  final DateTime? priode;
  final String? pamOwner;
  final String? printDayname;
  final String? pamTreasurer;
  final String? printDate;
  final Pam? pam;
  factory DataReportMonth.fromJson(Map<String, dynamic> json) =>
      DataReportMonth(
        pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
        priode: json["period"] == null ? null : DateTime.parse(json["period"]),
        pamOwner: json["pam_owner"] == null ? null : json["pam_owner"],
        pamTreasurer:
            json["pam_treasurer"] == null ? null : json["pam_treasurer"],
        printDate: json["print_date"] == null ? null : json["print_date"],
        printDayname:
            json["print_dayname"] == null ? null : json["print_dayname"],
        reportMonth: json["monthlyReport"] == null
            ? null
            : List<ReportMonthactionsModel>.from(json["monthlyReport"]
                .map((x) => ReportMonthactionsModel.fromJson(x))),
      );
}

class ReportMonthactionsModel {
  ReportMonthactionsModel({
    this.desc,
    this.amount,
    this.balance,
  });

  final String? desc;
  final int? balance;
  final int? amount;
  factory ReportMonthactionsModel.fromJson(Map<String, dynamic> json) =>
      ReportMonthactionsModel(
        desc: json["desc"] == null ? null : json["desc"],
        balance: json["balance"] == null ? null : json["balance"],
        amount: json["amount"] == null
            ? null
            : json["amount"] == "-"
                ? 0
                : json["amount"],
      );
}
