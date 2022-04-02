import 'dart:convert';
import 'package:airen/app/model/base_fee/base_fee_model.dart';
import 'package:airen/app/model/common_model.dart';
import 'package:airen/app/model/pam_user/add_pam_manage_model.dart';
import 'package:airen/app/model/pam_user/update_pam_model.dart';
import 'package:http/http.dart' as http;
import 'package:airen/app/model/pam_user/pam_user_model.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../data/http_service.dart';
import '../../../utils/utils.dart';

class MasterDataProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

  List<String>? pathSegmentPengelola() => ['api', HttpService.apiVersion, 'pam-user'];
  List<String>? pathSegmentUpdatePengelola({String? id}) => ['api', HttpService.apiVersion, 'pam-user', '$id'];
  List<String>? pathSegmentBaseFee() => ['api', HttpService.apiVersion, 'base-fee'];
  List<String>? pathSegmentBaseFeeUpdate({String? id}) => ['api', HttpService.apiVersion, 'base-fee', '$id'];

  Future<PamUserModel?> getPamUser({String? path, String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getPamsUser = Uri.parse(baseUrl).replace(pathSegments: pathSegmentPengelola());
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response = await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return pamUserModelFromJson(jsonString);
    }
    return null;
  }

  Future<AddPamManageModel?> addPamManage(
      {required String? bearer,
      required String? name,
      required String? phoneNumber,
      required String? email,
      required List<String> roles}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addPamManageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentPengelola());
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "name": name,
          "phone_number": phoneNumber,
          "email": email,
          "roles": roles,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "name": name,
      "phone_number": phoneNumber,
      "email": email,
      "roles": roles,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addPamManageModelFromJson(jsonString);
  }

  Future<UpdatePamManageModel?> updatePamManage(
      {required String? bearer,
        required String? name,
        required String? phoneNumber,
        required String? email,
        required int? blocked,
        required List<String> roles, String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _updatePamManageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentUpdatePengelola(id: id));
    logger.wtf(_updatePamManageUri);
    final response = await http.post(_updatePamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "name": name,
          "phone_number": phoneNumber,
          "email": email,
          "blocked": blocked,
          "roles": roles,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "name": name,
      "phone_number": phoneNumber,
      "email": email,
      "blocked": blocked,
      "roles": roles,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return updatePamManageModelFromJson(jsonString);
  }

  Future<CommonModel?> deletePamManage(
      {required String? bearer,
        required String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addPamManageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentUpdatePengelola(id: id));
    logger.wtf(_addPamManageUri);
    final response = await http.delete(_addPamManageUri,
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return commonPamManageModelFromJson(jsonString);
  }

  Future<BaseFeeModel?> getBaseFee({String? path, String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getBaseFee = Uri.parse(baseUrl).replace(pathSegments: pathSegmentBaseFee());
    logger.wtf('ini adalah baseUrl $_getBaseFee');
    final response = await http.get(_getBaseFee, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return baseFeeModelFromJson(jsonString);
    }
    return null;
  }

  Future<AddPamManageModel?> addBaseFee(
      {required String? bearer,
        required String? amount,
        required String? meterPosition}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addPamManageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentBaseFee());
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "amount": amount,
          "meter_position": meterPosition,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "amount": amount,
      "meter_position": meterPosition,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.body);
    return addPamManageModelFromJson(jsonString);
  }

  Future<AddPamManageModel?> updateBaseFee(
      {required String? bearer,
        required String? amount,
        required String? meterPosition,required String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _updateBaseFee = Uri.parse(baseUrl).replace(pathSegments: pathSegmentBaseFeeUpdate(id: id));
    logger.wtf(_updateBaseFee);
    final response = await http.post(_updateBaseFee,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "amount": amount,
          "meter_position": meterPosition,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "amount": amount,
      "meter_position": meterPosition,
    }));
    logger.wtf(pathSegmentUpdatePengelola(id: id));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addPamManageModelFromJson(jsonString);
  }

  Future<CommonModel?> deleteBaseFee(
      {required String? bearer,
        required String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _deleteBaseFeeUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentBaseFeeUpdate(id: id));
    logger.wtf(_deleteBaseFeeUri);
    final response = await http.delete(_deleteBaseFeeUri,
        headers: bearerAuth(bearer: bearer));
    var jsonString = response.body;
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return commonPamManageModelFromJson(jsonString);
  }
}
