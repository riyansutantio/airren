import 'package:get/get.dart';

import 'package:airen/app/modules/account/bindings/account_binding.dart';
import 'package:airen/app/modules/account/views/account_view.dart';
import 'package:airen/app/modules/customer/bindings/customer_binding.dart';
import 'package:airen/app/modules/customer/views/customer_view.dart';
import 'package:airen/app/modules/data_master/bindings/data_master_binding.dart';
import 'package:airen/app/modules/data_master/views/data_master_view.dart';
import 'package:airen/app/modules/home/bindings/home_binding.dart';
import 'package:airen/app/modules/home/views/home_view.dart';
import 'package:airen/app/modules/session/bindings/session_binding.dart';
import 'package:airen/app/modules/session/views/session_view.dart';
import 'package:airen/app/modules/splash/bindings/splash_binding.dart';
import 'package:airen/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SESSION;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER,
      page: () => CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.DATA_MASTER,
      page: () => DataMasterView(),
      binding: DataMasterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SESSION,
      page: () => SessionView(),
      binding: SessionBinding(),
    ),
  ];
}
