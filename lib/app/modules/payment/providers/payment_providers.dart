import 'dart:convert';

import 'package:get/get.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../model/invoice_pam.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../model/meter_transaction_model.dart';
import '../../../utils/utils.dart';

class PaymentProviders extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  Future<MeterTransModel?> getPayment(
      {String? path, String? bearer, String? status}) async {
    Uri _getPamsUser = Uri.parse('https://api.airren.id/api/v1/meter-month');
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

  Future<MeterTransMonthModel?> getPeymentMonth(
      {String? path, String? bearer, int? id, String? status}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.id/api/v1/meter-month/$id/meter-transaction?status=$status');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return MeterTransModelAllFromJson(jsonString);
    }
    return null;
  }

  Future<MeterTransMonthModel?> getSearchMeter(
      {String? path,
      String? bearer,
      String? searchValue,
      int? id,
      String? status}) async {
    Uri _getSearchBaseFee = Uri.parse(
        'https://api.airren.id/api/v1/meter-month/$id/meter-transaction?status=$status&search=$searchValue');
    logger.wtf('ini adalah baseUrl $_getSearchBaseFee');
    final response =
        await http.get(_getSearchBaseFee, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return MeterTransModelAllFromJson(jsonString);
    }
    return null;
  }

  Future<MeterTransMonthModel?> updatePeymentMonth(
      {String? path, String? bearer, int? id, int? idInvoice}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.id/api/v1/meter-month/$id/meter-transaction/$idInvoice');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response = await http.post(_getPamsUser,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({"_method": "PATCH", "status": "paid"}));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return MeterTransModelAllFromJson(jsonString);
    }
    return null;
  }

  Future<InvoiceModel?> getPeymentMonthInvoice(
      {String? path, String? bearer, int? id, int? idInvoice}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.id/api/v1/meter-month/$id/meter-transaction/$idInvoice/invoice');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return invoiceModelFromJson(jsonString);
    }
    return null;
  }
}
