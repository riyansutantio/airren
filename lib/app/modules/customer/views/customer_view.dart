import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';
import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      init: CustomerController(),
      builder: (controller) {
        return Scaffold(
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
                            'Pelanggan',
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
                            child: const Icon(EvaIcons.bellOutline, color: Colors.white)),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 5.0),
                          child: Icon(EvaIcons.checkmark, color: Colors.white),
                        ),
                        PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            padding: EdgeInsets.only(right: 8),
                            icon: Icon(EvaIcons.moreVertical, color: Colors.white),
                            onSelected: (selectedValue) {
                              print(selectedValue);
                            },
                            itemBuilder: (BuildContext ctx) => [
                                  PopupMenuItem(child: Text('Bagikan QR Code'), value: '1'),
                                  PopupMenuItem(child: Text('Download QR Code'), value: '2'),
                                ])
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')]), boxShadow: const []),
            ),
            preferredSize: Size.fromHeight(Get.height * 0.1),
          ),
          body: Container(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.menuItem.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )),
            ),
            decoration: BoxDecoration(gradient: LinearGradient(colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
          ),
        );
      },
    );
  }
}
