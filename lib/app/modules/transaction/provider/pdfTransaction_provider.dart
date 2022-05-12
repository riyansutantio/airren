import 'dart:convert';

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../model/pdfTransaction.dart';
import '../../../utils/utils.dart';

class PdfTransactionProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $bearer',
        HttpHeaders.contentTypeHeader: 'application/json',
      };
  Future<PdfTransactionUserModel?> getPdfTransaction(
      {String? path,
      String? bearer,
      String? month,
      String? year,
      String? type}) async {
    String? monthh;
    int m = int.parse(month!);
    if (m <= 9) {
      monthh = '0' + m.toString();
    }else{
        monthh =  m.toString();
    }
    Uri _getPamsUser = Uri.parse(
        'https://api.airren.tbrdev.my.id/api/v1/pam-transaction/download?month=$monthh-$year&type=$type');
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response =
        await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return PdfTransactionModelFromJson(jsonString);
    }
    return null;
  }
}
