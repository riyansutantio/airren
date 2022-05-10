import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../model/pam_transaction.dart';
import '../../../utils/utils.dart';

class TransactionProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  Future<PamTransUserModel?> getPamTransaction(
      {String? path, String? bearer}) async {
    Uri _getPamsUser =
        Uri.parse('https://api.airren.id/api/v1/pam-transaction?search&limit&');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return pamTransModelFromJson(jsonString);
    }
    return null;
  }

  Future<PamTransUserModel?> addIncomeTrans(
      {required String? bearer,
      required String? name,
      required int? amount,
      required String? description}) async {
    Uri _addPamManageUri =
        Uri.parse("https://api.airren.id/api/v1/pam-transaction");
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "name": name,
          "amount": amount,
          "type": "income",
          "description": description,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "name": name,
      "amount": amount,
      "type": "income",
      "description": description,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return pamTransModelFromJson(jsonString);
  }

  Future<PamTransUserModel?> addExpenseTrans(
      {required String? bearer,
      required String? name,
      required int? amount,
      required String? description}) async {
    Uri _addPamManageUri =
        Uri.parse("https://api.airren.id/api/v1/pam-transaction");
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "name": name,
          "amount": amount,
          "type": "expense",
          "description": description,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "name": name,
      "amount": amount,
      "type": "income",
      "description": description,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return pamTransModelFromJson(jsonString);
  }

  Future<PamTransUserModel?> addFirstBlance({
    required String? bearer,
    required int? amount,
  }) async {
    Uri _addPamManageUri =
        Uri.parse("https://api.airren.id/api/v1/first-balance");
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "first_balance": amount,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "first_balance": amount,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return pamTransModelFromJson(jsonString);
  }
}
