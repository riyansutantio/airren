import 'package:airen/app/modules/customer/views/customer_view.dart';
import 'package:airen/app/modules/data_master/views/data_master_view.dart';
import 'package:flutter/material.dart';

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
              ? AppBar(
                  title: Text('HomeView'),
                  centerTitle: true,
                  backgroundColor: HexColor('#0063F8'),
                )
              : null,
          body: renderBottomTabPage(context),
          bottomNavigationBar: buildNavBar(),
        ));
  }

  Stack buildNavBar() {
    return Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: HexColor('#0063F8').withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0), ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedLabelStyle: GoogleFonts.montserrat(
                  color: HexColor('#0063F8'),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                selectedItemColor: HexColor('#0063F8'),
                showSelectedLabels: true,
                currentIndex: controller.pageNavBottom.value,
                onTap: (index) => controller.onItemTapPage(index),
                showUnselectedLabels: false,
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
    return const Center(
      child: Text(
        'HomeView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
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
