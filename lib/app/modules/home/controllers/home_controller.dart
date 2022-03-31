import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final pageNavBottom = 0.obs;

  @override
  void onInit() {
    super.onInit();
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

  var menuItem = <MenuItemModel>[
    MenuItemModel(title: 'Catat meter', assets: 'catatmetericon.svg', id: '0'),
    MenuItemModel(title: 'Pembayaran', assets: 'bendahara.svg', id: '1'),
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
