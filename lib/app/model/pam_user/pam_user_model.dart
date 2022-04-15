import 'dart:convert';

PamUserModel pamUserModelFromJson(String str) => PamUserModel.fromJson(json.decode(str));

class PamUserModel {
  PamUserModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory PamUserModel.fromJson(Map<String, dynamic> json) => PamUserModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Data {
  Data({
    this.pamsUsers,
  });

  final List<PamsUserResult>? pamsUsers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pamsUsers: json["pamsUsers"] == null ? null : List<PamsUserResult>.from(json["pamsUsers"].map((x) => PamsUserResult.fromJson(x))),
  );
}

class PamsUserResult {
  PamsUserResult({
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
  final List<RolePam>? roles;

  factory PamsUserResult.fromJson(Map<String, dynamic> json) => PamsUserResult(
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
    roles: json["roles"] == null ? null : List<RolePam>.from(json["roles"].map((x) => RolePam.fromJson(x))),
  );
}

class RolePam {
  RolePam({
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

  factory RolePam.fromJson(Map<String, dynamic> json) => RolePam(
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
