import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SettingsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#0063F8'),
      appBar: PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () => Get.back(), icon: const Icon(EvaIcons.arrowBack), color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Pengaturan',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/notif.png',
                  width: 30,
                )
              ],
            ),
          ),
          decoration:
              BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
        ),
        preferredSize: Size.fromHeight(Get.height * 0.1),
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
                borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
                color: Colors.white),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30),
                  buildListTile(
                      title: 'Denda',
                      subTitle: 'Tentukan nominal denda bagi pelanggan yang terlambat bayar',
                      assets: 'charge.svg'),
                  buildListTile(
                      title: 'Fee Loket',
                      subTitle: 'Tentukan nominal fee loket',
                      assets: 'feeloket.svg'),
                  buildListTile(
                      title: 'Minimal Penggunaan',
                      subTitle: 'Tentukan minimal penggunaan air',
                      assets: 'minused.svg'),
                  buildListTile(
                      title: 'Detail Pams',
                      subTitle: 'Atur nama dan sesuaikan lokasi atau alamat',
                      assets: 'detailpam.svg'),
                  buildListTile(
                      title: 'Profil Saya',
                      subTitle: 'Atur nama anda atau ganti nomor telepon',
                      assets: 'profile.svg'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListTile({String? assets, String? title, String? subTitle}) {
    return ListTile(
      minVerticalPadding: 15,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/${assets}'),
            SizedBox(),
          ],
        ),
        title: Text('$title', style: GoogleFonts.montserrat(
          color: HexColor('#707793'),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        )),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text('$subTitle', style: GoogleFonts.montserrat(
            color: HexColor('#707793'),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),),
        ));
  }
}
