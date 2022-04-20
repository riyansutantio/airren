import 'dart:convert';
import 'dart:io';
import 'package:airen/app/model/catat_meter/bulan_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

import '../../../data/http_service.dart';
import '../../../model/account_settings/user_model.dart';
import '../../../model/catat_meter/add_catat_meter_bulan_model.dart';
import '../../../utils/utils.dart';

class CatatMeterProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };

  List<String>? pathSegmentGetMeterMonth({String? path}) =>
      ['api', HttpService.apiVersion, 'meter-month'];

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
      logger.wtf(jsonDecode(jsonString));
      return meterMonthModelFromJson(jsonString);
    }
    return null;
  }

  Future<AddCatatMeterBulanModel> addCatatMeterBulan({
    required String? bearer,
    required int month_of,
    required int year_of,
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
          "month_of": month_of,
          "year_of": year_of,
        },
      ),
    );
    var jsonString = response.body;
    logger.wtf(
      jsonEncode(
        {
          "month_of": month_of,
          "year_of": year_of,
        },
      ),
    );
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addCatatMeterBulanModelFromJson(jsonString);
  }
}
