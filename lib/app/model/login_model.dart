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
  });

  final PamUser? pamUser;
  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    pamUser: json["pamUser"] == null ? null : PamUser.fromJson(json["pamUser"]),
    token: json["token"] == null ? null : json["token"],
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
