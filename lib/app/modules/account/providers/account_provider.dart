import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:airen/app/model/term_about_help_model.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';

import '../../../data/http_service.dart';
import '../../../utils/utils.dart';

class AccountProvider extends GetConnect {
  Map<String, String> bearerAuth({String? bearer}) => {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $bearer'
  };

  List<String>? pathSegment({String? path})=> ['api', HttpService.apiVersion, '$path'];

  Future<TermAboutHelpModel?> getTermAboutUsHelp({String? path, String? bearer}) async {
    var baseUrl = FlavorConfig.instance.variables["baseUrl"];
    Uri _getTermAboutHelp = Uri.parse(baseUrl).replace(
        pathSegments: pathSegment(path: path));
    logger.wtf('ini adalah baseUrl $_getTermAboutHelp');
    final response = await http.get(_getTermAboutHelp, headers: bearerAuth(bearer: bearer));
    if (response.statusCode == 200) {
      logger.wtf(response.statusCode);
      var jsonString = response.body;
      logger.wtf(jsonDecode(jsonString));
      return termAboutHelpModelFromJson(jsonString);
    }
    return null;
  }

}
