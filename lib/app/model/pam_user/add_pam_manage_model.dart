import 'dart:convert';

AddPamManageModel addPamManageModelFromJson(String str) => AddPamManageModel.fromJson(json.decode(str));

class AddPamManageModel {
  AddPamManageModel({
    this.status,
    this.message,
    this.data,
  });

  final String? status;
  final String? message;
  final Data? data;

  factory AddPamManageModel.fromJson(Map<String, dynamic> json) => AddPamManageModel(
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
    this.name,
    this.phoneNumber,
    this.email,
    this.pamId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.roles,
  });

  final String? name;
  final String? phoneNumber;
  final String? email;
  final int? pamId;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final List<Role>? roles;

  factory PamUser.fromJson(Map<String, dynamic> json) => PamUser(
    name: json["name"] == null ? null : json["name"],
    phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
    email: json["email"] == null ? null : json["email"],
    pamId: json["pam_id"] == null ? null : json["pam_id"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
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
