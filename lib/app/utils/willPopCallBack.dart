import 'package:airen/app/modules/session/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future<bool> willPopCallback() async {
  Get.back();
  return true;
}

Future<bool> willPopCallbackWithFunc({Future<void>? func}) async {
  await func;
  Get.back();
  return true;
}

Future<bool> willPopWithFuncOnly({Future<void>? func}) async {
  await func;
  return false;
}