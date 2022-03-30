import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/modules/account/views/about_us_view.dart';
import 'package:airen/app/modules/account/views/privacy_policy_view.dart';
import 'package:airen/app/modules/account/views/settings_view.dart';
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
        return Scaffold(
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
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Row(
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
                              ),
                              CircleAvatar(
                                  maxRadius: 40,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: HexColor('#0063F8'),
                                  )),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'MJ Banana PAMS',
                                style: GoogleFonts.montserrat(
                                  color: HexColor('#3C3F58'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Text(
                                  'Terdaftar pada 25 Januari 2022',
                                  style: GoogleFonts.montserrat(
                                    color: HexColor('#707793'),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
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
                TileAccountWidget(title: 'Pengaturan', assets: 'settingblue.png', function: () => Get.to(SettingsView())),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(title: 'Bantuan', assets: 'helpblue.png'),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(
                    title: 'Syarat dan Ketentuan',
                    assets: 'rule.png',
                    function: () async {
                      await controller.getTermCondition();
                      Get.to(TermConditionView());
                    }),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(
                    title: 'Kebijakan Privasi',
                    assets: 'privacy.png',
                    function: () async {
                      await controller.getPrivacy();
                      Get.to(PrivacyPolicyView());
                    }),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(
                    title: 'Tentang Airen',
                    assets: 'about.png',
                    function: () async {
                      await controller.getAboutUs();
                      Get.to(AboutUsView());
                    }),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(
                  title: 'Push notifikasi',
                  assets: 'notifblue.png',
                  trail: Switch(
                    activeColor: Colors.green,
                    value: true,
                    onChanged: (value) {
                      // setState(() {
                      //   _switchValue = value;
                      // });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(title: 'Keluar', assets: 'logout.png'),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildBackground() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Image.asset('assets/accappbarbg.png'), SizedBox()],
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
      padding: const EdgeInsets.only(bottom: 4.0, right: 4.0, left: 4.0),
      child: ListTile(
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
    );
  }
}
