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
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/pam-transaction?search&limit&');
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
}
