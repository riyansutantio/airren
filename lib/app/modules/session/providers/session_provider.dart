import 'dart:convert';

import 'package:airen/app/model/error_register_model.dart';
import 'package:airen/app/model/province_model.dart';
import 'package:airen/app/model/regency_model.dart';
import 'package:airen/app/model/register_model.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/http_service.dart';
import '../../../model/district_model.dart';
import '../../../utils/utils.dart';

class SessionProvider extends GetConnect {
  List<String>? pathSegment({String? path}) => ['api', HttpService.apiVersion, '$path'];

  List<String>? pathSegmentRegency({String? path, String? id, String? regency}) =>
      ['api', HttpService.apiVersion, '$path', '$id', '$regency'];

  List<String>? pathSegmentDistrict({String? path, String? id, String? district}) =>
      ['api', HttpService.apiVersion, '$path', '$id', '$district'];

  List<String>? pathSegmentRegister({String? path}) => ['api', HttpService.apiVersion, '$path', 'register'];

  Future<DistrictModel?> getDistrict({String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getDistrict =
        Uri.parse(baseUrl).replace(pathSegments: pathSegmentDistrict(path: 'regency', id: '$id', district: 'district'));
    logger.wtf('ini adalah baseUrl $_getDistrict');
    final response = await http.get(_getDistrict, headers: HttpService.headers);
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return districtModelFromJson(jsonString);
    }
    return null;
  }

  Future<RegencyModel?> getRegency({
    String? id,
  }) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getRegency = Uri.parse(baseUrl).replace(pathSegments: pathSegmentRegency(path: 'province', id: id, regency: 'regency'));
    logger.wtf('ini adalah baseUrl $_getRegency');
    final response = await http.get(_getRegency, headers: HttpService.headers);
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return regencyModelFromJson(jsonString);
    }
    return null;
  }

  Future<ProvinceModel?> getProvince() async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getProvince = Uri.parse(baseUrl).replace(pathSegments: pathSegment(path: 'province'));
    logger.wtf('ini adalah baseUrl $_getProvince');
    final response = await http.get(_getProvince, headers: HttpService.headers);
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return provinceModelFromJson(jsonString);
    }
    return null;
  }

  Future<RegisterModel?> register(
      {required String? pamName,
      String? pamProvinceId,
      String? pamRegencyId,
      String? pamDistrictId,
      String? pamDetailAddress,
      String? pamUserName,
      String? pamUserPhoneNumber,
      String? pamUserEmail}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _giveRateUrl = Uri.parse(baseUrl).replace(pathSegments: pathSegmentRegister(path: 'auth'));
    logger.wtf(_giveRateUrl);
    final response = await http.post(_giveRateUrl,
        headers: HttpService.headers,
        body: jsonEncode({
          "pam_name": pamName,
          "pam_province_id": pamProvinceId,
          "pam_regency_id": pamRegencyId,
          "pam_district_id": pamDistrictId,
          "pam_detail_address": pamDetailAddress,
          "pam_user_name": pamUserName,
          "pam_user_phone_number": pamUserPhoneNumber,
          "pam_user_email": pamUserEmail
        }));
    logger.wtf(response.body);
    var jsonString = response.body;
    logger.wtf(jsonDecode(jsonString));
    return registerModelFromJson(jsonString);
  }
}
