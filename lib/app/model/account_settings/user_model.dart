import 'dart:convert';

UserPamModel userPamModelFromJson(String str) => UserPamModel.fromJson(json.decode(str));

class UserPamModel {
  UserPamModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory UserPamModel.fromJson(Map<String, dynamic> json) => UserPamModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  Data({
    this.profile,
  });

  final ResultProfile? profile;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        profile: json["profile"] == null ? null : ResultProfile.fromJson(json["profile"]),
      );
}

class ResultProfile {
  ResultProfile({
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

  factory ResultProfile.fromJson(Map<String, dynamic> json) => ResultProfile(
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
    this.adminFee,
    this.isPostpaid,
    this.createdAt,
    this.updatedAt,
    this.province,
    this.regency,
    this.district,
  });

  final int? id;
  final String? name;
  final dynamic photoName;
  final String? photoPath;
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
  final int? adminFee;
  final int? isPostpaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Location? province;
  final Location? regency;
  final Location? district;

  factory Pam.fromJson(Map<String, dynamic> json) => Pam(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        photoName: json["photo_name"],
        photoPath: json["photo_path"] == null ? null : json["photo_path"],
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
        adminFee: json["admin_fee"] == null ? null : json["admin_fee"],
        isPostpaid: json["is_postpaid"] == null ? null : json["is_postpaid"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        province: json["province"] == null ? null : Location.fromJson(json["province"]),
        regency: json["regency"] == null ? null : Location.fromJson(json["regency"]),
        district: json["district"] == null ? null : Location.fromJson(json["district"]),
      );
}

class Location {
  Location({
    this.nameLocation,
  });

  final String? nameLocation;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    nameLocation: json["name"] == null ? null : json["name"],
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

  Map<String, dynamic> toJson() => {
        "model_id": modelId == null ? null : modelId,
        "role_id": roleId == null ? null : roleId,
        "model_type": modelType == null ? null : modelType,
      };
}
