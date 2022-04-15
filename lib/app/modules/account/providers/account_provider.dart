import 'dart:convert';
import 'dart:io';
import 'package:airen/app/model/account_settings/charge_model.dart';
import 'package:airen/app/model/account_settings/min_usage_model.dart';
import 'package:airen/app/model/account_settings/pam_update_model.dart';
import 'package:airen/app/model/account_settings/user_model.dart';
import 'package:airen/app/model/pam_user/pam_user_model.dart';
import 'package:airen/app/modules/account/views/min_usage_view.dart';
import 'package:http/http.dart' as http;
import 'package:airen/app/model/term_about_help_model.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

import '../../../data/http_service.dart';
import '../../../model/account_settings/admin_fee_model.dart';
import '../../../model/account_settings/profile_update_model.dart';
import '../../../utils/utils.dart';

class AccountProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

  List<String>? pathSegment({String? path}) => ['api', HttpService.apiVersion, '$path'];

  List<String>? pathSegmentGetUser({String? path}) => ['api', HttpService.apiVersion, 'profile'];

  List<String>? pathSegmentMinUsage() => ['api', HttpService.apiVersion, 'min-usage'];
  List<String>? pathSegmentAdminFee() => ['api', HttpService.apiVersion, 'admin-fee'];

  List<String>? pathSegmentCharge() => ['api', HttpService.apiVersion, 'charge'];

  List<String>? pathSegmentPamUserProfile() => ['api', HttpService.apiVersion, 'profile', 'pam-user'];

  List<String>? pathSegmentUpdatePam() => ['api', HttpService.apiVersion, 'profile', 'pam'];
  List<String>? pathSegmentUploadPhotoUser() => ['api', HttpService.apiVersion, 'profile', 'pam-image'];

  Future<TermAboutHelpModel?> getTermAboutUsHelp({String? path, String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getTermAboutHelp = Uri.parse(baseUrl).replace(pathSegments: pathSegment(path: path));
    logger.wtf('ini adalah baseUrl $_getTermAboutHelp');
    final response = await http.get(_getTermAboutHelp, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return termAboutHelpModelFromJson(jsonString);
    }
    return null;
  }

  Future<UserPamModel?> getUser({String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getUser = Uri.parse(baseUrl).replace(pathSegments: pathSegmentGetUser());
    logger.wtf('ini adalah baseUrl $_getUser');
    final response = await http.get(_getUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return userPamModelFromJson(jsonString);
    }
    return null;
  }

  Future<MinUsageModel?> minUsage({required String? bearer, required String? meterPosition}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addMinUsageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentMinUsage());
    logger.wtf(_addMinUsageUri);
    final response = await http.post(_addMinUsageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "min_usage": meterPosition,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "min_usage": meterPosition,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return minUsageModelFromJson(jsonString);
  }

  Future<ChargeModel?> addCharge({required String? bearer, required String? charge, required String? dueDate}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addCharg = Uri.parse(baseUrl).replace(pathSegments: pathSegmentCharge());
    logger.wtf(_addCharg);
    final response = await http.post(_addCharg,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "charge": charge,
          "charge_due_date": dueDate,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "charge": charge,
      "charge_due_date": dueDate,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return chargeModelFromJson(jsonString);
  }

  Future<PamUserProfileUpdateModel?> updatePamUserProfile(
      {required String? bearer, required String? name, required String? phoneNumber}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _updateUserPam = Uri.parse(baseUrl).replace(pathSegments: pathSegmentPamUserProfile());
    logger.wtf(_updateUserPam);
    final response = await http.post(_updateUserPam,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "name": name,
          "phone_number": phoneNumber,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "name": name,
      "phone_number": phoneNumber,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return pamUserProfileModelFromJson(jsonString);
  }

  Future<AdminFeeModel?> adminFee({required String? bearer, required String? adminFee}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _adminFee = Uri.parse(baseUrl).replace(pathSegments: pathSegmentAdminFee());
    logger.wtf(_adminFee);
    final response = await http.post(_adminFee,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "admin_fee": adminFee,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "admin_fee": adminFee,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return adminFeeModelFromJson(jsonString);
  }

  Future<PamUpdateModel?> updatePamProfile({
    required String? bearer,
    required String? pamProvinceId,
    required String? pamRegencyId,
    required String? pamDistrictId,
    required String? name,
    required String? detailAddress,
  }) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _updatePam = Uri.parse(baseUrl).replace(pathSegments: pathSegmentUpdatePam());
    logger.wtf(_updatePam);
    final response = await http.post(_updatePam,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "name": name,
          "province_id": pamProvinceId,
          "regency_id": pamRegencyId,
          "district_id": pamDistrictId,
          "detail_address": detailAddress,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "name": name,
      "province_id": pamProvinceId,
      "regency_id": pamRegencyId,
      "district_id": pamDistrictId,
      "detail_address": detailAddress,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return pamUpdateModelFromJson(jsonString);
  }

  Future pushProfilePhoto({
    required String photoPath,
    required String? bearer,
  }) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl).replace(pathSegments: pathSegmentUploadPhotoUser()));

    logger.wtf('coba push foto profile ${request.fields}');

    request.files.add(await http.MultipartFile.fromPath('image', photoPath));

    request.fields['_method'] = 'PATCH';

    request.headers.assignAll(bearerAuth(bearer: bearer));

    http.StreamedResponse response = await request.send();
    logger.i('status code ${request.fields}');
    if (response.statusCode == 200) {
      return logger.wtf('berhasil input profile ${await response.stream.bytesToString()} ${response.reasonPhrase}');
    } else {
      return logger.wtf('gagal input profile ${await response.stream.bytesToString()} ${response.reasonPhrase}');
    }
  }
}
