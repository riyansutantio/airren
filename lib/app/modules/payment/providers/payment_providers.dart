import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../model/meter_transaction_model.dart';
import '../../../utils/utils.dart';

class PaymentProviders extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  Future<MeterTransModel?> getPayment({String? path, String? bearer}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/meter-month?status=unpad');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return MeterTransModelFromJson(jsonString);
    }
    return null;
  }
}
