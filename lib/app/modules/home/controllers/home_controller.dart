import 'package:airen/app/modules/account/controllers/account_controller.dart';
import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/account_settings/user_model.dart';
import '../../../utils/constant.dart';
import '../../session/controllers/session_controller.dart';
import '../../session/providers/session_provider.dart';

class HomeController extends GetxController {
  AccountProvider accountProvider;

  HomeController({required this.accountProvider});

  final pageNavBottom = 0.obs;

  final SessionController sessionController = Get.put(SessionController(sessionProvider: SessionProvider()));


  @override
  void onInit() async {
    super.onInit();
    await getUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => pageNavBottom.value++;

  void onItemTapPage(int index) {
    pageNavBottom.value = index;
  }

  final isLoadingUser = false.obs;

  final boxUser = GetStorage();

  final resultUser = ResultProfile().obs;

  Future getUser() async {
    isLoadingUser.value = true;
    final res = await accountProvider.getUser(bearer: boxUser.read(tokenBearer));
    // logger.i(res!.message);
    if (res == null) {
      sessionController.authError();
    } else if (res.message == 'Profile successfully retrieved') {
      resultUser.value = res.data!.profile!;
    }
  }

  var menuItem = <MenuItemModel>[
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '0'),
    MenuItemModel(title: 'Pembayaran', assets: 'pembayaran.svg', id: '1'),
    MenuItemModel(title: 'Laporan', assets: 'laporan.svg', id: '2'),
    MenuItemModel(title: 'Pelanggan', assets: 'pelanggan.svg', id: '3'),
    MenuItemModel(title: 'Master data', assets: 'masterdata.svg', id: '4'),
    MenuItemModel(title: 'Berlangganan', assets: 'langganan.svg', id: '5'),
  ];
}

class MenuItemModel {
  String? title;
  String? assets;
  String? id;

  MenuItemModel({this.title, this.assets, this.id});
}
