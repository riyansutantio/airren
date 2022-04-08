import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

import '../../../data/http_service.dart';
import '../../../model/account_settings/user_model.dart';
import '../../../utils/utils.dart';

class HomeProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $bearer',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  List<String>? pathSegmentGetUser({String? path}) => ['api', HttpService.apiVersion, 'profile'];

  Future<UserPamModel?> getUser({String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getUser = Uri.parse(baseUrl).replace(pathSegments: pathSegmentGetUser());
    logger.wtf('ini adalah baseUrl $_getUser');
    final response = await http.get(_getUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return userPamModelFromJson(jsonString);
    }
    return null;
  }

}
