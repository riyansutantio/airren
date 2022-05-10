import 'dart:convert';

HistorySubModel historySubModelFromJson(String str) =>
    HistorySubModel.fromJson(json.decode(str));

class HistorySubModel {
  HistorySubModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory HistorySubModel.fromJson(Map<String, dynamic> json) =>
      HistorySubModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({this.cusMs, this.data});

  final List<historySub>? cusMs;
  final List<historySub>? data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        cusMs: json["transactions"] == null
            ? null
            : List<historySub>.from(
                json["transactions"].map((x) => historySub.fromJson(x))),
        data: json["transaction"] == null
            ? null
            : List<historySub>.from(
                json["transaction"].map((x) => historySub.fromJson(x))),
      );
}

class historySub {
  historySub(
      {this.id,
      this.name,
      this.uniqueId,
      this.price,
      this.pamId,
      this.ownerName,
      this.ownerPhoneNumber,
      this.ownerEmail,
      this.descriptios,
      this.status,
      this.accountTo,
      this.totalAmount,
      this.accountOnBehalfOfFrom,
      this.dateEnd,
      this.accountFrom,
      this.accountNumberTo,
      this.accountOnBehalfOfTo,
      this.paymentAmount,
      this.paymentDate,
      this.paymentAttachment,
      this.paymentAttachmentName,
      this.createdAt,
      this.dateStart,
      this.updatedAt});

  final String? name;
  final int? id;
  final String? uniqueId;
  final String? ownerName;
  final String? ownerPhoneNumber;
  final String? ownerEmail;
  final String? descriptios;
  final String? status;
  final dynamic accountFrom;
  final dynamic accountTo;
  final dynamic accountOnBehalfOfFrom;
  final dynamic accountNumberTo;
  final dynamic accountOnBehalfOfTo;
  final dynamic paymentAmount;
  final dynamic paymentDate;
  final dynamic paymentAttachment;
  final dynamic paymentAttachmentName;
  final int? pamId;
  final int? price;
  final int? totalAmount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  factory historySub.fromJson(Map<String, dynamic> json) => historySub(
        name: json["pam_name"] == null ? null : json["pam_name"],
        id: json["id"] == null ? null : json["id"],
        uniqueId:
            json["transaction_id"] == null ? null : json["transaction_id"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
        ownerEmail: json["owner_email"] == null ? null : json["owner_email"],
        descriptios: json["description"] == null ? null : json["description"],
        ownerPhoneNumber: json["owner_phone_number"] == null
            ? null
            : json["owner_phone_number"],
        status: json["status"] == null ? null : json["status"],
        pamId: json["pam_id"] == null ? null : json["pam_id"],
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        price: json["price"] == null ? null : json["price"],
        accountFrom: json["account_from"] == null ? null : json["account_from"],
        accountOnBehalfOfFrom: json["accountOnBehalfOfFrom"] == null
            ? null
            : json["accountOnBehalfOfFrom"],
        accountTo: json["account_to"] == null ? null : json["account_to"],
        accountNumberTo: json["account_number_to"] == null
            ? null
            : json["account_number_to"],
        accountOnBehalfOfTo: json["account_on_behalf_of_to"] == null
            ? null
            : json["account_on_behalf_of_to"],
        paymentAmount:
            json["payment_amount"] == null ? null : json["payment_amount"],
        paymentDate: json["payment_date"] == null ? null : json["payment_date"],
        paymentAttachment: json["payment_attachment"] == null
            ? null
            : json["payment_attachment"],
        paymentAttachmentName: json["payment_attachment_name"] == null
            ? null
            : json["payment_attachment_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );
}
