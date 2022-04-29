import 'package:airen/app/modules/catat_meter/views/catat_meter_view.dart';
import 'package:airen/app/modules/customer/views/customer_view.dart';
import 'package:airen/app/modules/data_master/views/data_master_view.dart';
import 'package:airen/app/modules/error_handling/views/error_handling_view.dart';
import 'package:airen/app/modules/home/providers/home_provider.dart';
import 'package:airen/app/modules/report/view/report_view.dart';
import 'package:airen/app/modules/session/views/payment_view.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../account/views/account_view.dart';
import '../../payment/views/payment_data_view.dart';
import '../../report/view/report_view.dart';
import '../../transaction/views/transaction_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final HomeController homeController =
      Get.put(HomeController(homeProvider: HomeProvider()));
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(homeProvider: HomeProvider()),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: (controller.pageNavBottom.value == 0 &&
                      controller.userLocal.value == '1')
                  ? PreferredSize(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Beranda',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(ErrorHandlingView());
                                      },
                                      child: const Icon(EvaIcons.bellOutline,
                                          color: Colors.white)),
                                  const SizedBox(width: 20),
                                  const CircleAvatar(
                                    maxRadius: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          HexColor('#5433FF'),
                          HexColor('#0063F8')
                        ])),
                      ),
                      preferredSize: Size.fromHeight(Get.height * 0.1),
                    )
                  : null,
              body: pageByRole(context),
              bottomNavigationBar: navBarByRole(context),
            ));
      },
    );
  }

  ///

  Stack buildNavBarAdminPam() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(0.0, -8.0),
                color: Color.fromRGBO(0, 99, 248, 0.16),
                blurRadius: 24,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#0063F8'),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#707793'),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedItemColor: HexColor('#707793'),
            selectedItemColor: HexColor('#0063F8'),
            showSelectedLabels: true,
            currentIndex: controller.pageNavBottom.value,
            onTap: (index) => controller.onItemTapPage(index),
            showUnselectedLabels: true,
            enableFeedback: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 0
                      ? const Icon(EvaIcons.homeOutline)
                      : const Icon(
                          EvaIcons.homeOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 1
                      ? const Icon(EvaIcons.peopleOutline)
                      : const Icon(
                          EvaIcons.peopleOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Pelanggan',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 2
                      ? const Icon(EvaIcons.editOutline)
                      : const Icon(
                          EvaIcons.editOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Data Master',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 3
                      ? const Icon(EvaIcons.dropletOutline)
                      : const Icon(
                          EvaIcons.dropletOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack buildNavBarNoteMeter() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: HexColor('#0063F8').withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(3, 0)),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#0063F8'),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#707793'),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedItemColor: HexColor('#707793'),
            selectedItemColor: HexColor('#0063F8'),
            showSelectedLabels: true,
            currentIndex: controller.pageNavBottom.value,
            onTap: (index) => controller.onItemTapPage(index),
            showUnselectedLabels: true,
            enableFeedback: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 0
                      ? const Icon(EvaIcons.editOutline)
                      : const Icon(
                          EvaIcons.editOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Catat Meter',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 1
                      ? const Icon(EvaIcons.dropletOutline)
                      : const Icon(
                          EvaIcons.dropletOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack buildNavBarPayment() {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: HexColor('#0063F8').withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(3, 0)),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#0063F8'),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#707793'),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedItemColor: HexColor('#707793'),
            selectedItemColor: HexColor('#0063F8'),
            showSelectedLabels: true,
            currentIndex: controller.pageNavBottom.value,
            onTap: (index) => controller.onItemTapPage(index),
            showUnselectedLabels: true,
            enableFeedback: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 0
                      ? const Icon(EvaIcons.pricetagsOutline)
                      : const Icon(
                          EvaIcons.pricetagsOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Pembayaran',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 1
                      ? const Icon(EvaIcons.fileTextOutline)
                      : const Icon(
                          EvaIcons.fileTextOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 2
                      ? const Icon(EvaIcons.pieChartOutline)
                      : const Icon(
                          EvaIcons.pieChartOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Laporan',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 3
                      ? const Icon(EvaIcons.dropletOutline)
                      : const Icon(
                          EvaIcons.dropletOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Akun',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Stack buildNavBarNoteMeterPayment(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: HexColor('#0063F8').withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(3, 0)),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#0063F8'),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.montserrat(
              color: HexColor('#707793'),
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            unselectedItemColor: HexColor('#707793'),
            selectedItemColor: HexColor('#0063F8'),
            showSelectedLabels: true,
            currentIndex: controller.pageNavBottom.value,
            onTap: (index) => controller.onItemTapPage(index),
            showUnselectedLabels: true,
            enableFeedback: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 0
                      ? const Icon(EvaIcons.homeOutline)
                      : const Icon(
                          EvaIcons.homeOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Catat Meter',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 1
                      ? const Icon(EvaIcons.peopleOutline)
                      : const Icon(
                          EvaIcons.peopleOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Pembayaran',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: controller.pageNavBottom.value == 2
                      ? const Icon(EvaIcons.fileTextOutline)
                      : const Icon(
                          EvaIcons.fileTextOutline,
                          color: Colors.grey,
                        ),
                ),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                tooltip: "",
                backgroundColor: Colors.white,
                icon: GestureDetector(
                  onTap: () {
                    bottomSheet(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 4.0, right: 4.0),
                    child: Icon(
                      EvaIcons.gridOutline,
                      color: Colors.grey,
                    ),
                  ),
                ),
                label: 'Lainnya',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget RenderHomePage() {
    return Stack(
      children: [
        Image.asset('assets/wavedown.png'),
        Column(
          children: [
            Expanded(
              flex: 4,
              child: AlignedGridView.count(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: controller.menuItem.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.menuItem[index].id == "5") {
                        controller.pageNavBottom.value = 2;
                      } else if (controller.menuItem[index].id == "4") {
                        controller.pageNavBottom.value = 1;
                      } else if (controller.menuItem[index].id == "0") {
                        Get.to(() => CatatMeterView());
                      } else if (controller.menuItem[index].id == "2") {
                        Get.to(TransactionView());
                      } else if (controller.menuItem[index].id == "1") {
                        Get.to(PaymentDataViews());
                      } else if (controller.menuItem[index].id == "3") {
                        Get.to(ReportView());
                      }
                    },
                    child: containerItemMenu(
                        title: '${controller.menuItem[index].title}',
                        assets: '${controller.menuItem[index].assets}'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(0.0, 8.0),
                          color: Color.fromRGBO(0, 99, 248, 0.16),
                          blurRadius: 24,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 10,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Pengaturan',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0, bottom: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Tentukan denda, minimum penggunaan dan lainnya.',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ])),
                            const Expanded(
                                flex: 2,
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.amber,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0.0, -8.0),
                      color: Color.fromRGBO(0, 99, 248, 0.16),
                      blurRadius: 24,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10.0, bottom: 10.0),
                                  child: Text(
                                    'Masa aktif akun sampai dengan tanggal',
                                    style: GoogleFonts.montserrat(
                                      color: HexColor('#707793'),
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Text(
                                  '30 November 2022',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Image.asset('assets/license.png',
                                width: 50,
                                height: 50,
                                opacity:
                                    const AlwaysStoppedAnimation<double>(0.5)),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Segera melakukan pembayaran sebelum tanggal di atas.',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#FF8801'),
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                            height: 60,
                            decoration: BoxDecoration(
                              color: HexColor("#FF8801").withOpacity(0.1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Stack(
                          children: [
                            Container(color: Colors.grey, height: 3),
                            Container(
                              color: Colors.green,
                              height: 3,
                              width: 150,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '01 November 2022 sd. 30 November 2022',
                        style: GoogleFonts.montserrat(
                          color: HexColor('#707793'),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget containerItemMenu({String? assets, String? title}) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Offset(0.0, 8.0),
              color: Color.fromRGBO(0, 99, 248, 0.16),
              blurRadius: 24,
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 12, 8.0, 12),
          child: Column(
            children: [
              SvgPicture.asset('assets/$assets'),
              Text('$title',
                  style: GoogleFonts.montserrat(
                    color: HexColor('#707793'),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ));
  }

  ///
  Widget renderPageAdmin(BuildContext context) {
    var command = '${controller.pageNavBottom.value}';
    switch (command) {
      case '0':
        return RenderHomePage();
      case '1':
        return CustomerView();
      case '2':
        return DataMasterView();
      case '3':
        return AccountView();
      default:
        return Container();
    }
  }

  Widget renderPageNotePayment(BuildContext context) {
    // logger.wtf(controller.pageNavBottom.value);
    var command = '${controller.pageNavBottom.value}';
    switch (command) {
      case '0':
        return CatatMeterView();
      case '1':
        return PaymentDataViews();
      case '2':
        return TransactionView();
      default:
        return TransactionView();
    }
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Container(
        height: 250,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: Expanded(
            flex: 4,
            child: AlignedGridView.count(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: controller.bottomSheetItem.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (controller.bottomSheetItem[index].id == "0") {
                      Get.to(() => CatatMeterView());
                    } else if (controller.bottomSheetItem[index].id == "1") {
                      Get.to(PaymentDataViews());
                    } else if (controller.bottomSheetItem[index].id == "2") {
                      Get.to(TransactionView());
                    } else if (controller.bottomSheetItem[index].id == "3") {
                      Get.to(ReportView());
                    } else if (controller.bottomSheetItem[index].id == "4") {
                      Get.to(AccountView());
                    }
                  },
                  child: containerItemMenu(
                      title: '${controller.bottomSheetItem[index].title}',
                      assets: '${controller.bottomSheetItem[index].assets}'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget renderPageNote(BuildContext context) {
    // logger.wtf(controller.pageNavBottom.value);
    var command = '${controller.pageNavBottom.value}';
    switch (command) {
      case '0':
        return CatatMeterView();
      case '1':
        return AccountView();
      default:
        return Container();
    }
  }

  Widget renderPagePayment(BuildContext context) {
    // logger.wtf(controller.pageNavBottom.value);
    var command = '${controller.pageNavBottom.value}';
    switch (command) {
      case '0':
        return Container(
          child: Center(child: PaymentDataViews()),
        );
      case '1':
        return Container(
          child: Center(child: TransactionView()),
        );
      case '2':
        return Container(
          child: Center(child: ReportView()),
        );
      case '3':
        return AccountView();
      default:
        return Container();
    }
  }

  Widget pageByRole(BuildContext context) {
    var command = controller.userLocal.value;
    switch (command) {
      case '1':
        return renderPageAdmin(context);
      case '2':
        return renderPageNotePayment(context);
      case '3':
        return renderPageNote(context);
      case '4':
        return renderPagePayment(context);
      default:
        return Container();
    }
  }

  Widget navBarByRole(BuildContext context) {
    var command = controller.userLocal.value;
    switch (command) {
      case '1':
        return buildNavBarAdminPam();
      case '2':
        return buildNavBarNoteMeterPayment(context);
      case '3':
        return buildNavBarNoteMeter();
      case '4':
        return buildNavBarPayment();
      default:
        return Container();
    }
  }
}
