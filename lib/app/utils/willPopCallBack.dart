import 'package:airen/app/modules/session/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Future<bool> willPopCallback() async {
  Get.back();
  return true;
}

Future<bool> willPopCallbackDc({Future<void>? func}) async {
  await func;
  Get.back();
  return true;
}