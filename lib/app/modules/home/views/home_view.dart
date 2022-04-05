import 'package:airen/app/modules/customer/views/customer_view.dart';
import 'package:airen/app/modules/data_master/views/data_master_view.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../account/views/account_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: (controller.pageNavBottom.value == 0)
              ? PreferredSize(
                  child: Container(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
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
                              Image.asset(
                                'assets/notif.png',
                                width: 30,
                              ),
                              SizedBox(width: 20),
                              CircleAvatar(
                                maxRadius: 20,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
                  ),
                  preferredSize: Size.fromHeight(Get.height * 0.1),
                )
              : null,
          body: renderBottomTabPage(context),
          bottomNavigationBar: buildNavBarAdminPam(),
        ));
  }

  Stack buildNavBarAdminPam() {
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
                color: HexColor('#0063F8').withOpacity(0.3),
                blurRadius: 10,
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
              fontWeight: FontWeight.w500,
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
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Image.asset(
                    'assets/${(controller.pageNavBottom.value == 0) ? 'homenavsolid.png' : 'home.png'}',
                    width: 25,
                    color: (controller.pageNavBottom.value == 0) ? HexColor('#0063F8') : HexColor('#707793'),
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Image.asset(
                    'assets/${(controller.pageNavBottom.value == 1) ? 'custnavsolid.png' : 'cust.png'}',
                    width: 25,
                    color: (controller.pageNavBottom.value == 1) ? HexColor('#0063F8') : HexColor('#707793'),
                  ),
                ),
                label: 'Pelanggan',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Image.asset(
                    'assets/${(controller.pageNavBottom.value == 2) ? 'datanavsolid.png' : 'data.png'}',
                    width: 25,
                    color: (controller.pageNavBottom.value == 2) ? HexColor('#0063F8') : HexColor('#707793'),
                  ),
                ),
                label: 'Data',
              ),
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Image.asset(
                    'assets/${(controller.pageNavBottom.value == 3) ? 'accnavsolid.png' : 'account.png'}',
                    width: 25,
                    color: (controller.pageNavBottom.value == 3) ? HexColor('#0063F8') : HexColor('#707793'),
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
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                itemCount: controller.menuItem.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.menuItem[index].id == "4") {
                        controller.pageNavBottom.value = 2;
                      } else if (controller.menuItem[index].id == "3") {
                        controller.pageNavBottom.value = 1;
                      }
                    },
                    child: containerItemMenu(
                        title: '${controller.menuItem[index].title}', assets: '${controller.menuItem[index].assets}'),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                  height: 90,
                  decoration: BoxDecoration(boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: HexColor('#0063F8').withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ], borderRadius: BorderRadius.circular(16), color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.amber,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tentukan denda, minimum penggunaan',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793'),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'dan lainnya.',
                              style: GoogleFonts.montserrat(
                                color: HexColor('#707793'),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
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
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: HexColor('#0063F8').withOpacity(0.3),
                      blurRadius: 10,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Masa aktif akun sampai dengan tanggal',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#707793'),
                                    fontSize: 14,
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
                          Image.asset(
                            'assets/license.png',
                            width: 30,
                            height: 30,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Segera melakukan pembayaran sebelum tanggal di atas.', style: GoogleFonts.montserrat(
                                color: HexColor('#FF8801'),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),),
                            ),
                          ),
                            height: 60,
                            decoration: BoxDecoration(
                              color:HexColor("#FF8801").withOpacity(0.1),
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
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
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: HexColor('#0063F8').withOpacity(0.3),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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

  Widget renderBottomTabPage(BuildContext context) {
    // logger.wtf(controller.pageNavBottom.value);
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
}
