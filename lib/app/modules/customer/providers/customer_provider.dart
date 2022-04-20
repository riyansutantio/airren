import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../model/customer/customerModel.dart';
import '../../../utils/utils.dart';

class CustomerProviders extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  Future<CusUserModel?> getCusUser({String? path, String? bearer}) async {
    Uri _getPamsUser =
        Uri.parse('https://api.airren.tbrdev.my.id/api/v1/consumer');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return CusUserModelFromJson(jsonString);
    }
    return null;
  }

  Future<CusUserModel?> addCusManage(
      {required String? bearer,
      required String? name,
      required String? phoneNumber,
      required String? address,
      required String? meter}) async {
    Uri _addPamManageUri =
        Uri.parse("https://api.airren.tbrdev.my.id/api/v1/consumer");
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "name": name,
          "phone_number": phoneNumber,
          "full_address": address,
          "start_meter": meter,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "name": name,
      "phone_number": phoneNumber,
      "full_address": address,
      "start_meter": meter,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return CusUserModelFromJson(jsonString);
  }
}
