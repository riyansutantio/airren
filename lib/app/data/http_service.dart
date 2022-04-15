import 'dart:io';

class HttpService {

  static const apiVersion = 'v1';

  static const Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: ''
  };
}


