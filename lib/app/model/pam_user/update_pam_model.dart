import 'dart:convert';

UpdatePamManageModel updatePamManageModelFromJson(String str) => UpdatePamManageModel.fromJson(json.decode(str));

class UpdatePamManageModel {
  UpdatePamManageModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory UpdatePamManageModel.fromJson(Map<String, dynamic> json) => UpdatePamManageModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.pamUser,
  });

  final PamUser? pamUser;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pamUser: json["pamUser"] == null ? null : PamUser.fromJson(json["pamUser"]),
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
    this.pam,
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
  final Pam? pam;
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
    pam: json["pam"] == null ? null : Pam.fromJson(json["pam"]),
    roles: json["roles"] == null ? null : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
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
    this.isPostpaid,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic photoName;
  final dynamic photoPath;
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final int? provinceId;
  final int? regencyId;
  final int? districtId;
  final String? detailAddress;
  final int? blocked;
  final dynamic blockedAt;
  final dynamic charge;
  final dynamic chargeDueDate;
  final dynamic minUsage;
  final int? isPostpaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Pam.fromJson(Map<String, dynamic> json) => Pam(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    photoName: json["photo_name"],
    photoPath: json["photo_path"],
    dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
    dateEnd: json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
    provinceId: json["province_id"] == null ? null : json["province_id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    detailAddress: json["detail_address"] == null ? null : json["detail_address"],
    blocked: json["blocked"] == null ? null : json["blocked"],
    blockedAt: json["blocked_at"],
    charge: json["charge"],
    chargeDueDate: json["charge_due_date"],
    minUsage: json["min_usage"],
    isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
