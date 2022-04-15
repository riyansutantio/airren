import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

class LoginModel {
  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.pamUser,
    this.token,
    this.transaction,
    this.phoneNumber
  });

  final PamUser? pamUser;
  final String? token;
  final String? phoneNumber;
  final Transaction? transaction;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pamUser: json["pamUser"] == null ? null : PamUser.fromJson(json["pamUser"]),
    token: json["token"] == null ? null : json["token"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    transaction: json["transaction"] == null ? null : Transaction.fromJson(json["transaction"]),
  );
}

class PamUser {
  PamUser({
    this.id,
    this.pamId,
    this.name,
    this.email,
    this.googleId,
    this.phoneNumber,
    this.blocked,
    this.prevBlocked,
    this.blockedAt,
    this.emailVerifiedAt,
    this.isOwner,
    this.createdAt,
    this.updatedAt,
    this.roles,
  });

  final int? id;
  final int? pamId;
  final String? name;
  final String? email;
  final String? googleId;
  final String? phoneNumber;
  final int? blocked;
  final int? prevBlocked;
  final dynamic blockedAt;
  final DateTime? emailVerifiedAt;
  final int? isOwner;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Role>? roles;

  factory PamUser.fromJson(Map<String, dynamic> json) => PamUser(
    id: json["id"] == null ? null : json["id"],
    pamId: json["pam_id"] == null ? null : json["pam_id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    googleId: json["google_id"] == null ? null : json["google_id"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    blocked: json["blocked"] == null ? null : json["blocked"],
    prevBlocked: json["prev_blocked"] == null ? null : json["prev_blocked"],
    blockedAt: json["blocked_at"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    isOwner: json["is_owner"] == null ? null : json["is_owner"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    roles: json["roles"] == null ? null : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );
}

class Role {
  Role({
    this.id,
    this.name,
    this.guardName,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  final int? id;
  final String? name;
  final String? guardName;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    guardName: json["guard_name"] == null ? null : json["guard_name"],
    note: json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );
}

class Pivot {
  Pivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  final int? modelId;
  final int? roleId;
  final String? modelType;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    modelId: json["model_id"] == null ? null : json["model_id"],
    roleId: json["role_id"] == null ? null : json["role_id"],
    modelType: json["model_type"] == null ? null : json["model_type"],
  );
}

class Transaction {
  Transaction({
    this.id,
    this.pamId,
    this.pamName,
    this.ownerName,
    this.ownerPhoneNumber,
    this.ownerEmail,
    this.transactionId,
    this.description,
    this.status,
    this.dateStart,
    this.dateEnd,
    this.price,
    this.totalAmount,
    this.accountFrom,
    this.accountOnBehalfOfFrom,
    this.accountTo,
    this.accountNumberTo,
    this.accountOnBehalfOfTo,
    this.paymentAmount,
    this.paymentMethod,
    this.paymentDate,
    this.paymentAttachment,
    this.paymentAttachmentName,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? pamId;
  final String? pamName;
  final String? ownerName;
  final String? ownerPhoneNumber;
  final String? ownerEmail;
  final String? transactionId;
  final String? description;
  final String? status;
  final dynamic dateStart;
  final dynamic dateEnd;
  final int? price;
  final int? totalAmount;
  final dynamic accountFrom;
  final dynamic accountOnBehalfOfFrom;
  final dynamic accountTo;
  final dynamic accountNumberTo;
  final dynamic accountOnBehalfOfTo;
  final dynamic paymentAmount;
  final dynamic paymentMethod;
  final dynamic paymentDate;
  final dynamic paymentAttachment;
  final dynamic paymentAttachmentName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json["id"] == null ? null : json["id"],
    pamId: json["pam_id"] == null ? null : json["pam_id"],
    pamName: json["pam_name"] == null ? null : json["pam_name"],
    ownerName: json["owner_name"] == null ? null : json["owner_name"],
    ownerPhoneNumber: json["owner_phone_number"] == null ? null : json["owner_phone_number"],
    ownerEmail: json["owner_email"] == null ? null : json["owner_email"],
    transactionId: json["transaction_id"] == null ? null : json["transaction_id"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    dateStart: json["date_start"],
    dateEnd: json["date_end"],
    price: json["price"] == null ? null : json["price"],
    totalAmount: json["total_amount"] == null ? null : json["total_amount"],
    accountFrom: json["account_from"],
    accountOnBehalfOfFrom: json["account_on_behalf_of_from"],
    accountTo: json["account_to"],
    accountNumberTo: json["account_number_to"],
    accountOnBehalfOfTo: json["account_on_behalf_of_to"],
    paymentAmount: json["payment_amount"],
    paymentMethod: json["payment_method"],
    paymentDate: json["payment_date"],
    paymentAttachment: json["payment_attachment"],
    paymentAttachmentName: json["payment_attachment_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );
}
