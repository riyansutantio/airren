import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/modules/account/views/about_us_view.dart';
import 'package:airen/app/modules/account/views/privacy_policy_view.dart';
import 'package:airen/app/modules/account/views/term_condition_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(accountProvider: AccountProvider()),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(Get.height * 0.35),
              child: Container(
                color: Colors.white,
                child: Stack(
                  children: [
                    buildBackground(),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0, right: 8.0, left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'Akun',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Image.asset(
                                  'assets/notif.png',
                                  width: 30,
                                ),
                              )
                            ],
                          ),
                          const CircleAvatar(maxRadius: 40, backgroundColor: Colors.white, child: CircleAvatar(radius: 35)),
                          Text(
                            'MJ Banana PAMS',
                            style: GoogleFonts.montserrat(
                              color: HexColor('#3C3F58'),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Terdaftar pada 25 Januari 2022',
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
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TileAccountWidget(title: 'Pengaturan', assets: 'settingblue.png'),
                  TileAccountWidget(title: 'Bantuan', assets: 'helpblue.png'),
                  TileAccountWidget(
                      title: 'Syarat dan Ketentuan',
                      assets: 'rule.png',
                      function: () async {
                        await controller.getTermCondition();
                        Get.to(TermConditionView());
                      }),
                  TileAccountWidget(
                      title: 'Kebijakan Privasi',
                      assets: 'privacy.png',
                      function: () async {
                        await controller.getPrivacy();
                        Get.to(PrivacyPolicyView());
                      }),
                  TileAccountWidget(
                      title: 'Tentang Airen',
                      assets: 'about.png',
                      function: () async {
                        await controller.getAboutUs();
                        Get.to(AboutUsView());
                      }),
                  TileAccountWidget(
                    title: 'Push notifikasi',
                    assets: 'notifblue.png',
                    trail: Switch(
                      value: true,
                      onChanged: (value) {
                        // setState(() {
                        //   _switchValue = value;
                        // });
                      },
                    ),
                  ),
                  TileAccountWidget(title: 'Keluar', assets: 'logout.png'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Column buildBackground() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Image.asset('assets/accappbarbg.png'),
          ],
        ),
        const SizedBox()
      ],
    );
  }
}

class TileAccountWidget extends StatelessWidget {
  String? title;
  String? assets;
  Widget? trail;
  VoidCallback? function;

  TileAccountWidget({Key? key, this.title, this.assets, this.trail, this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          ListTile(
            onTap: function,
            title: Text('$title',
                style: GoogleFonts.montserrat(
                  color: HexColor('#707793'),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                )),
            leading: Image.asset(
              'assets/$assets',
              width: 30,
            ),
            trailing: trail,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Divider(
              height: 1,
            ),
          )
        ],
      ),
    );
  }
}
