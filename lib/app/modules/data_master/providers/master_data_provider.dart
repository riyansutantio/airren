import 'dart:convert';
import 'package:airen/app/model/pam_user/add_pam_manage_model.dart';
import 'package:airen/app/modules/data_master/views/add_pam_manage_view.dart';
import 'package:http/http.dart' as http;
import 'package:airen/app/model/pam_user/pam_user_model.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../../data/http_service.dart';
import '../../../utils/utils.dart';

class MasterDataProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) =>
      {HttpHeaders.acceptHeader: 'application/json', HttpHeaders.authorizationHeader: 'Bearer $bearer'};

  List<String>? pathSegmentPengelola() => ['api', HttpService.apiVersion, 'pam-user'];

  Future<PamUserModel?> getPamUser({String? path, String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getPamsUser = Uri.parse(baseUrl).replace(pathSegments: pathSegmentPengelola());
    logger.wtf('ini adalah baseUrl $_getPamsUser');
    final response = await http.get(_getPamsUser, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return pamUserModelFromJson(jsonString);
    }
    return null;
  }

  Future<AddPamManageModel?> addPamManage(
      {required String? bearer,
      required String? name,
      required String? phoneNumber,
      required String? email,
      required List<String> roles}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _addPamManageUri = Uri.parse(baseUrl).replace(pathSegments: pathSegmentPengelola());
    logger.wtf(_addPamManageUri);
    final response = await http.post(_addPamManageUri,
        headers: bearerAuth(bearer: bearer),
        body: jsonEncode({
          "name": name,
          "phone_number": phoneNumber,
          "email": email,
          "roles": roles,
        }));
    var jsonString = response.body;
    logger.wtf(jsonEncode({
      "name": name,
      "phone_number": phoneNumber,
      "email": email,
      "roles": roles,
    }));
    logger.wtf(jsonDecode(jsonString));
    logger.wtf(response.statusCode);
    return addPamManageModelFromJson(jsonString);
  }
}
