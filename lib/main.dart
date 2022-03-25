import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

void main() async {
  // await GetStorage.init();
  FlavorConfig(
    name: "DEV",
    color: Colors.red,
    location: BannerLocation.bottomStart,
    variables: {
      "baseUrl": "https://api.airren.tbrdev.my.id/",
    },
  );

  // runApp(DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => FlavorBanner(
  //     color: Colors.red,
  //     location: BannerLocation.topStart,
  //     child: GetMaterialApp(
  //       navigatorKey: Get.key,
  //       theme: ThemeData.light(),
  //       title: "Airen",
  //       initialRoute: AppPages.INITIAL,
  //       getPages: AppPages.routes,
  //     ),
  //   ),
  // ));

  /// without devPreview, running this for !debug
  runApp(
    FlavorBanner(
      color: Colors.red,
      location: BannerLocation.topStart,
      child: GetMaterialApp(
        navigatorKey: Get.key,
        theme: ThemeData.light(),
        title: "Airen",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
