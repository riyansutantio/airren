import 'package:airen/app/modules/account/views/admin_fee_view.dart';
import 'package:airen/app/modules/account/views/charge_view.dart';
import 'package:airen/app/modules/account/views/min_usage_view.dart';
import 'package:airen/app/modules/account/views/my_profile_view.dart';
import 'package:airen/app/modules/account/views/pam_profile_view.dart';
import 'package:airen/app/utils/constant.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';
import '../controllers/account_controller.dart';
import '../providers/account_provider.dart';

class SettingsView extends GetView {
  final AccountController accountController = Get.put(AccountController(accountProvider: AccountProvider()));
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor('#0063F8'),
        appBar: PreferredSize(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 20),
                        child: Icon(EvaIcons.arrowBack, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Pengaturan',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15, bottom: 19, right: 20),
                      child: GestureDetector(
                          onTap: () {
                            Get.to(ErrorHandlingView());
                          },
                          child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
            decoration:
            BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
          ),
          preferredSize: Size.fromHeight(56),
        ),
        body: Stack(
          children: [
            Container(
              decoration:
                  BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20.0,
                  spreadRadius: 1.0,
                )
              ]),
            ),
            Container(
              height: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    if (accountController.boxUser.read(roleUser) == '1')
                      buildListTile(
                          title: 'Denda',
                          subTitle: 'Tentukan nominal denda bagi pelanggan yang terlambat bayar',
                          assets: 'charge.svg',
                          func: () {
                            Get.to(ChargeView());
                          }),
                    if (accountController.boxUser.read(roleUser) == '1')
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    if (accountController.boxUser.read(roleUser) == '1')
                      buildListTile(
                          title: 'Biaya Admin',
                          subTitle: 'Tentukan biaya untuk admin',
                          assets: 'feeloket.svg',
                          func: () {
                            Get.to(AdminFeeView());
                          }),
                    if (accountController.boxUser.read(roleUser) == '1')
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    if (accountController.boxUser.read(roleUser) == '1')
                      buildListTile(
                          title: 'Minimal Penggunaan',
                          subTitle: 'Tentukan minimal penggunaan air',
                          assets: 'minused.svg',
                          func: () {
                            Get.to(MinUsageView());
                          }),
                    if (accountController.boxUser.read(roleUser) == '1')
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    if (accountController.boxUser.read(roleUser) == '1')
                      buildListTile(
                          title: 'Detail Pams',
                          subTitle: 'Atur nama dan sesuaikan lokasi atau alamat',
                          assets: 'detailpam.svg',
                          func: () {
                            Get.to(PamProfileView());
                          }),
                    if (accountController.boxUser.read(roleUser) == '1')
                      const Padding(
                        padding: EdgeInsets.only(left: 75.0),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                    buildListTile(
                        title: 'Profil Saya',
                        subTitle: 'Atur nama anda atau ganti nomor telepon',
                        assets: 'profile.svg',
                        func: () {
                          Get.to(MyProfileView());
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListTile({String? assets, String? title, String? subTitle, VoidCallback? func}) {
    return ListTile(
        onTap: func,
        minVerticalPadding: 15,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/${assets}'),
            SizedBox(),
          ],
        ),
        title: Text('$title',
            style: GoogleFonts.montserrat(
              color: HexColor('#3C3F58'),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            '$subTitle',
            style: GoogleFonts.montserrat(
              color: HexColor('#707793'),
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));
  }
}
