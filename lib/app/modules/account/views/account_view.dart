import 'package:airen/app/modules/account/providers/account_provider.dart';
import 'package:airen/app/modules/account/views/about_us_view.dart';
import 'package:airen/app/modules/account/views/privacy_policy_view.dart';
import 'package:airen/app/modules/account/views/settings_view.dart';
import 'package:airen/app/modules/account/views/term_condition_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';
import '../controllers/account_controller.dart';
import 'image_galery_picker_view.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(
      init: AccountController(accountProvider: AccountProvider()),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(295),
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  buildBackground(),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, top: 16),
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
                                  padding: const EdgeInsets.only(right: 20.0, top: 10),
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(ErrorHandlingView());
                                      },
                                      child: Column(
                                        children: const [
                                          Icon(EvaIcons.bellOutline, color: Colors.white),
                                          SizedBox(height: 10)
                                        ],
                                      )),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.getFromGallery();
                                // Get.to(Galery());
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [BoxShadow(blurRadius: 9, color: Colors.blue.withOpacity(0.2), spreadRadius: 1)],
                                  ),
                                  child: Obx(() => CircleAvatar(
                                      maxRadius: 45,
                                      backgroundColor: Colors.white,
                                      child: (controller.photoName.value == "")
                                          ? CircleAvatar(
                                              maxRadius: 40,
                                              child: SvgPicture.asset('assets/photo.svg'),
                                              backgroundColor: HexColor('#0063F8'),
                                            )
                                          : CircleAvatar(
                                              maxRadius: 40,
                                              child: ClipOval(
                                                child: AspectRatio(
                                                    aspectRatio: 1 / 1,
                                                    child: Image.network(
                                                      controller.photoPath.value,
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              backgroundColor: HexColor('#0063F8'),
                                            ))),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Obx(() => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 34.0, bottom: 16),
                                  child: Text(
                                    controller.displayName.value,
                                    style: GoogleFonts.montserrat(
                                      color: HexColor('#3C3F58'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    (controller.displayRegisterCreated.value.isEmpty)
                                        ? ""
                                        : "Terdaftar pada ${controller.displayRegisterToDateTime()}",
                                    style: GoogleFonts.montserrat(
                                      color: HexColor('#707793'),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            )),
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
                TileAccountWidget(
                    title: 'Bantuan',
                    assets: 'helpblue.png',
                    function: () {
                      Get.to(ErrorHandlingView());
                    }),
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
                Obx(() => TileAccountWidget(
                      title: 'Push notifikasi',
                      assets: 'notifblue.png',
                      trail: Switch(
                        activeColor: HexColor('#05C270'),
                        value: controller.pushNotification.value,
                        onChanged: (value) {
                          controller.pushNotification.toggle();
                          // setState(() {
                          //   _switchValue = value;
                          // });
                        },
                      ),
                    )),
                const Padding(
                  padding: EdgeInsets.only(left: 75.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                TileAccountWidget(
                    title: 'Keluar',
                    assets: 'logout1.png',
                    function: () {
                      controller.sessionController.logOut();
                    }),
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
      padding: const EdgeInsets.only(left: 8.0, top: 2.0, bottom: 2.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: ListTile(
          dense: false,
          enableFeedback: false,
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
      ),
    );
  }
}
