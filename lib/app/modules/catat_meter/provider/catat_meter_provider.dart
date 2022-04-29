import 'dart:convert';
import 'dart:io';
import 'package:airen/app/model/catat_meter/add_catat_meter.dart';
import 'package:airen/app/model/catat_meter/add_tagihan.dart';
import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:airen/app/model/catat_meter/catat_meter_model.dart';
import 'package:airen/app/model/common_model.dart';
import 'package:airen/app/widgets/snack_bar_notification.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

import '../../../data/http_service.dart';
import '../../../model/catat_meter/add_catat_meter_bulan_model.dart';
import '../../../model/catat_meter/get_bulan_lalu.dart';
import '../../../model/catat_meter/meter_transaction_model.dart';
import '../../../model/customer/customerModel.dart';
import '../../../model/invoice_pam.dart';
import '../../../model/meter_transactionAll_model.dart';
import '../../../utils/utils.dart';

class CatatMeterProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

  List<String>? pathSegmentGetMeterMonth({String? path}) =>
      ['api', HttpService.apiVersion, 'meter-month'];

  List<String>? pathSegmentUpdateCatatMeter({String? id}) =>
      ['api', HttpService.apiVersion, 'meter-month', '$id'];

  Future<MeterMonthModel?> getMeterMonth({String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getMeterMonth =
        Uri.parse(baseUrl).replace(pathSegments: pathSegmentGetMeterMonth());
    logger.wtf('ini adalah baseUrl $_getMeterMonth');
    final response =
        await http.get(_getMeterMonth, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.d(jsonDecode(jsonString));
      return meterMonthModelFromJson(jsonString);
    }
    return null;
  }

  Future<AddCatatMeterBulanModel?> addCatatMeterBulan({
    required String? bearer,
    required int? monthOf,
    required int? yearOf,
  }) async {
    var baseUrl = FlavorConfig.instance.variables['baseUrl'];
    Uri _addCatatMeterUri =
        Uri.parse(baseUrl).replace(pathSegments: pathSegmentGetMeterMonth());
    logger.wtf(_addCatatMeterUri);
    final response = await http.post(
      _addCatatMeterUri,
      headers: bearerAuth(bearer: bearer),
      body: jsonEncode(
        {
          "month_of": monthOf,
          "year_of": yearOf,
        },
      ),
    );
    var jsonString = response.body;
    logger.wtf(
      jsonEncode(
        {
          "month_of": monthOf,
          "year_of": yearOf,
        },
      ),
    );
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addCatatMeterBulanModelFromJson(jsonString);
  }

  Future<CatatMeterModel?> getCatatMeter({String? bearer, int? bulan}) async {
    Uri _getCatatMeter = Uri.parse(
        "https://api.airren.tbrdev.my.id/api/v1/meter-month/$bulan/meter");
    logger.wtf('ini adalah baseUrl $_getCatatMeter');
    final response =
        await http.get(_getCatatMeter, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.d(jsonDecode(jsonString));
      return catatMeterModelFromJson(jsonString);
    }
    return null;
  }

  Future<CusUserModel?> getSearchCus(
      {String? path, String? bearer, String? searchValue}) async {
    Uri _getSearchBaseFee = Uri.parse(
        "https://api.airren.tbrdev.my.id/api/v1/consumer?status=active&search=$searchValue");
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

  Future<GetBulanLalu?> getBulanlalu({String? bearer, int? id}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/consumer/$id/latest-meter');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return GetBulanLaluFromJson(jsonString);
    }
    return null;
  }

  Future<CommonModel?> deleteMeterBulan(
      {required String? bearer, required String? id}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _delMeterBulan = Uri.parse(baseUrl)
        .replace(pathSegments: pathSegmentUpdateCatatMeter(id: id));
    logger.wtf(_delMeterBulan);
    final response = await http.delete(
      _delMeterBulan,
      headers: bearerAuth(bearer: bearer),
    );
    var jsonString = response.body;
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return commonPamManageModelFromJson(jsonString);
  }

  Future<AddCatatMeter?> addCatatMeter(
      {required String? bearer,
      required String? consumer_unique_id,
      required String? meter_now,
      required int? bulan}) async {
    Uri _addCatatMeterUri = Uri.parse(
        "https://api.airren.tbrdev.my.id/api/v1/meter-month/$bulan/meter");
    logger.wtf(_addCatatMeterUri);
    final response = await http.post(_addCatatMeterUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "consumer_unique_id": consumer_unique_id,
          "meter_now": meter_now,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "consumer_unique_id": consumer_unique_id,
      "meter_now": meter_now,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addCatatMeterModelFromJson(jsonString);
  }

  Future<AddCatatMeter?> updateCatatMeter({
    required String bearer,
    required String id,
    required String meter_now,
    required int month,
  }) async {
    Uri _updatePamManageUri = Uri.parse(
        "https://api.airren.tbrdev.my.id/api/v1/meter-month/$month/meter/$id");
    logger.wtf(_updatePamManageUri);
    final response = await http.post(_updatePamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "_method": "PATCH",
          "meter_now": meter_now,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "_method": "PATCH",
      "meter_now": meter_now,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addCatatMeterModelFromJson(jsonString);
  }

  Future<AddTagihan?> addTagihan(
      {required String? bearer,
      required String? consumer_unique_id,
      required String? meter_now,
      required String? meter_last,
      required String? consumer_name,
      required String? consumer_full_address,
      required String? consumer_phone_number,
      required int? bulan}) async {
    Uri _addTagihan = Uri.parse(
        "https://api.airren.tbrdev.my.id/api/v1/meter-month/$bulan/meter-transaction");
    logger.wtf(_addTagihan);
    final response = await http.post(_addTagihan,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "consumer_unique_id": consumer_unique_id,
          "meter_now": meter_now,
          "meter_last": meter_last,
          "consumer_name": consumer_name,
          "consumer_full_address": consumer_full_address,
          "consumer_phone_number": consumer_phone_number,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "consumer_unique_id": consumer_unique_id,
      "meter_now": meter_now,
      "meter_last": meter_last,
      "consumer_name": consumer_name,
      "consumer_full_address": consumer_full_address,
      "consumer_phone_number": consumer_phone_number,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addTagihanModelFromJson(jsonString);
  }

  Future<InvoiceModel?> getPeymentMonthInvoice(
      {String? bearer, int? id, int? idInvoice}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/meter-month/$id/meter-transaction/$idInvoice/invoice');
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

  Future<MeterTransactionModel?> getMeterTransaction({String? bearer, int? id}) async {
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/meter-month/$id/meter-transaction');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return meterTransactionModelFromJson(jsonString);
    }
    return null;
  }
}
