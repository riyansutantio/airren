import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

class RegisterModel {
  RegisterModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  final String? status;
  final String? message;
  final Errors? errors;
  final DataPam? data;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    data: json["data"] == null ? null : DataPam.fromJson(json["data"]),
  );
}

class DataPam {
  DataPam({
    this.pam,
    this.trialPrice,
    this.phoneNumber
  });

  final PamResult? pam;
  final int? trialPrice;
  final String? phoneNumber;

  factory DataPam.fromJson(Map<String, dynamic> json) => DataPam(
    pam: json["pam"] == null ? null : PamResult.fromJson(json["pam"]),
    trialPrice: json["trial_price"] == null ? null : json["trial_price"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
  );
}

class PamResult {
  PamResult({
    this.name,
    this.provinceId,
    this.regencyId,
    this.districtId,
    this.detailAddress,
    this.isPostpaid,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.pamUsers,
  });

  final String? name;
  final String? provinceId;
  final String? regencyId;
  final String? districtId;
  final String? detailAddress;
  final bool? isPostpaid;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final List<PamUser>? pamUsers;

  factory PamResult.fromJson(Map<String, dynamic> json) => PamResult(
    name: json["name"] == null ? null : json["name"],
    provinceId: json["province_id"] == null ? null : json["province_id"],
    regencyId: json["regency_id"] == null ? null : json["regency_id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    detailAddress: json["detail_address"] == null ? null : json["detail_address"],
    isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
    pamUsers: json["pam_users"] == null ? null : List<PamUser>.from(json["pam_users"].map((x) => PamUser.fromJson(x))),
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

class Errors {
  Errors({
    this.pamName,
    this.pamProvinceId,
    this.pamRegencyId,
    this.pamDistrictId,
    this.pamDetailAddress,
    this.pamUserName,
    this.pamUserPhoneNumber,
    this.pamUserEmail,
  });

  final List<String>? pamName;
  final List<String>? pamProvinceId;
  final List<String>? pamRegencyId;
  final List<String>? pamDistrictId;
  final List<String>? pamDetailAddress;
  final List<String>? pamUserName;
  final List<String>? pamUserPhoneNumber;
  final List<String>? pamUserEmail;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    pamName: json["pam_name"] == null ? null : List<String>.from(json["pam_name"].map((x) => x)),
    pamProvinceId: json["pam_province_id"] == null ? null : List<String>.from(json["pam_province_id"].map((x) => x)),
    pamRegencyId: json["pam_regency_id"] == null ? null : List<String>.from(json["pam_regency_id"].map((x) => x)),
    pamDistrictId: json["pam_district_id"] == null ? null : List<String>.from(json["pam_district_id"].map((x) => x)),
    pamDetailAddress: json["pam_detail_address"] == null ? null : List<String>.from(json["pam_detail_address"].map((x) => x)),
    pamUserName: json["pam_user_name"] == null ? null : List<String>.from(json["pam_user_name"].map((x) => x)),
    pamUserPhoneNumber: json["pam_user_phone_number"] == null ? null : List<String>.from(json["pam_user_phone_number"].map((x) => x)),
    pamUserEmail: json["pam_user_email"] == null ? null : List<String>.from(json["pam_user_email"].map((x) => x)),
  );
}
