import 'dart:convert';

PamUserProfileUpdateModel pamUserProfileModelFromJson(String str) => PamUserProfileUpdateModel.fromJson(json.decode(str));

class PamUserProfileUpdateModel {
  PamUserProfileUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory PamUserProfileUpdateModel.fromJson(Map<String, dynamic> json) => PamUserProfileUpdateModel(
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
  );
}
