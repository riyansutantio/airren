import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

class RegisterModel {
  RegisterModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.pam,
    this.trialPrice,
    this.phoneNumber,
    this.transaction,
  });

  final Pam? pam;
  final int? trialPrice;
  final String? phoneNumber;
  final Transaction? transaction;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
    trialPrice: json["trial_price"] == null ? null : json["trial_price"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    transaction: json["transaction"] == null ? null : Transaction.fromJson(json["transaction"]),
  );
}

class Pam {
  Pam({
    this.id,
    this.name,
    this.photoName,
    this.photoPath,
    this.dateStart,
    this.dateEnd,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.detailAddress,
    this.blocked,
    this.blockedAt,
    this.charge,
    this.chargeDueDate,
    this.minUsage,
    this.adminFee,
    this.isPostpaid,
    this.createdAt,
    this.updatedAt,
    this.province,
    this.regency,
    this.district,
    this.pamUsers,
  });

  final int? id;
  final String? name;
  final dynamic photoName;
  final String? photoPath;
  final dynamic dateStart;
  final dynamic dateEnd;
  final int? provinceId;
  final int? regencyId;
  final int? districtId;
  final String? detailAddress;
  final int? blocked;
  final dynamic blockedAt;
  final dynamic charge;
  final dynamic chargeDueDate;
  final String? minUsage;
  final int? adminFee;
  final int? isPostpaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RegisterProvince? province;
  final RegisterRegency? regency;
  final RegisterDistrict? district;
  final List<PamUser>? pamUsers;

  factory Pam.fromJson(Map<String, dynamic> json) => Pam(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    photoName: json["photo_name"],
    photoPath: json["photo_path"] == null ? null : json["photo_path"],
    dateStart: json["date_start"],
    dateEnd: json["date_end"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    detailAddress: json["detail_address"] == null ? null : json["detail_address"],
    blocked: json["blocked"] == null ? null : json["blocked"],
    blockedAt: json["blocked_at"],
    charge: json["charge"],
    chargeDueDate: json["charge_due_date"],
    minUsage: json["min_usage"] == null ? null : json["min_usage"],
    adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
    isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    province: json["province"] == null ? null : RegisterProvince.fromJson(json["province"]),
    regency: json["regency"] == null ? null : RegisterRegency.fromJson(json["regency"]),
    district: json["district"] == null ? null : RegisterDistrict.fromJson(json["district"]),
    pamUsers: json["pam_users"] == null ? null : List<PamUser>.from(json["pam_users"].map((x) => PamUser.fromJson(x))),
  );
}

class RegisterDistrict {
  RegisterDistrict({
    this.id,
    this.regencyId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? regencyId;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory RegisterDistrict.fromJson(Map<String, dynamic> json) => RegisterDistrict(
    id: json["id"] == null ? null : json["id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}
class RegisterRegency {
  RegisterRegency({
    this.id,
    this.provinceId,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? provinceId;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory RegisterRegency.fromJson(Map<String, dynamic> json) => RegisterRegency(
    id: json["id"] == null ? null : json["id"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );
}
class RegisterProvince {
  RegisterProvince({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory RegisterProvince.fromJson(Map<String, dynamic> json) => RegisterProvince(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
  final dynamic googleId;
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
    googleId: json["google_id"],
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
