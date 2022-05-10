// @dart=2.9
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/report/view/report_view.dart';
import 'app/modules/subcribeHistory/views/history_views.dart';
import 'app/modules/subcribeHistory/views/invoice_subcriber.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FlavorConfig(
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
  //       home: ReportView(),
  //       debugShowCheckedModeBanner: false,
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
        home: HistorySubView(),
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        theme: ThemeData.light(),
        title: "Airen",
        // initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      ),
    ),
  );
}
