import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/transaction_controller.dart';
import '../provider/transaction_provider.dart';

class TransactionView extends GetView<TransactionController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent.withOpacity(0)));
    return GetBuilder<TransactionController>(
      init: TransactionController(p: TransactionProvider()),
      builder: (controller) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(EvaIcons.arrowBack),
                            color: Colors.white),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Transaksi',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.to(ErrorHandlingView());
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: Icon(EvaIcons.bellOutline,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0),
                  boxShadow: const []),
            ),
            preferredSize: Size.fromHeight(Get.height * 0.1),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Get.to(AddCustomer());
            },
            child: Icon(
              Icons.add,
              color: HexColor('#ffffff'),
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Container(
                  height: 350,
                  child: Stack(children: [
                    Positioned(
                      top: -50,
                      left: 0,
                      right: 0,
                      child: Image.asset("assets/bgt.png"),
                    ),
                    Positioned.fill(
                        top: 140,
                        left: 0,
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Rp ",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 32, color: Colors.white)),
                                Text("0",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text("Saldo sekarang",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.7))),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Ink(
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          offset: Offset(0.0, 8.0),
                                          color:
                                              Color.fromRGBO(0, 99, 248, 0.2),
                                          blurRadius: 24,
                                        ),
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SizedBox(
                                    height: 48,
                                    width: 170,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            EvaIcons.plusCircleOutline,
                                            color: HexColor('#0063F8'),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            'Saldo awal',
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#0063F8'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))))
                          ],
                        ))
                  ]),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        color: Colors.white),
                    child: controller.count.value == 0
                        ? Center(
                            child: noListTransaksi(),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: controller.count.value,
                                itemBuilder: (context, index) {
                                  return SizedBox();
                                })),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
          ),
        );
      },
    );
  }

  Widget noListTransaksi() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/emptylist.png",
            width: 77,
            height: 90,
          ),
          const SizedBox(height: 30),
          Text(
            "Belum ada transaksi",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Gunakan tombol di bawah untuk\nmenambahkan transaksi baru.",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                color: HexColor('#707793'),
                fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
