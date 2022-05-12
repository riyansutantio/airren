import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../model/customer/customerModel.dart';
import '../../../model/meter_transactionAll_model.dart';
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

  Future<MeterTransMonthModel?> addInvoiceIssue(
      {required String? bearer,
      required String? id,
      required String? meter_last,
      required String? meter_now,
      required String? consumer_unique_id,
      required String? consumer_name,
      required String? consumer_full_address,
      required String? address,
      required String? consumer_phone_number,}) async {
    Uri _addPamManageUri =
        Uri.parse("https://api.airren.tbrdev.my.id/api/v1/meter-month/$id/meter-transaction");
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
        "meter_last" : "$meter_last",
    "meter_now": "$meter_now",
    "consumer_unique_id": "$consumer_unique_id",
    "consumer_name": "$consumer_name",
    "consumer_full_address": "$consumer_full_address",
    "consumer_phone_number": "$consumer_phone_number"
        }));
    var jsonString = response.body;
    
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return MeterTransModelAllFromJson(jsonString);
  }

  Future<CusUserModel?> updateCusManage(
      {required String bearer,
      required String name,
      required String phoneNumber,
      required String address,
      required int active,
      required String id,
      required String meter}) async {
    Uri _updatePamManageUri =
        Uri.parse("https://api.airren.tbrdev.my.id/api/v1/consumer/$id");
    logger.wtf(_updatePamManageUri);
    final response = await http.post(_updatePamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "name": name,
          "phone_number": phoneNumber,
          "full_address": address,
          "start_meter": meter,
          "is_active": active,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "name": name,
      "phone_number": phoneNumber,
      "full_address": address,
      "start_meter": meter,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return CusUserModelFromJson(jsonString);
  }

  Future<CusUserModel?> getSearchCus(
      {String? path, String? bearer, String? searchValue}) async {
    Uri _getSearchBaseFee = Uri.parse("https://api.airren.tbrdev.my.id/api/v1/consumer?search=$searchValue");
    logger.wtf('ini adalah baseUrl $_getSearchBaseFee');
    final response =
        await http.get(_getSearchBaseFee, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return CusUserModelFromJson(jsonString);
    }
    return null;
  }
}
