import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../error_handling/views/error_handling_view.dart';
import '../controllers/customer_controller.dart';
import '../providers/customer_provider.dart';
import 'add_customer.dart';

class CustomerView extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      init: CustomerController(p: CustomerProviders()),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: PreferredSize(
                child: Container(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                                child: const Icon(EvaIcons.bellOutline,
                                    color: Colors.white)),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 5.0),
                              child:
                                  Icon(EvaIcons.searchOutline, color: Colors.white),
                            ),
                            PopupMenuButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                padding: EdgeInsets.only(right: 8),
                                icon: Icon(EvaIcons.moreVertical,
                                    color: Colors.white),
                                onSelected: (selectedValue) {
                                  print(selectedValue);
                                },
                                itemBuilder: (BuildContext ctx) => [
                                      PopupMenuItem(
                                          child: Text('Bagikan QR Code'),
                                          value: '1'),
                                      PopupMenuItem(
                                          child: Text('Download QR Code'),
                                          value: '2'),
                                    ])
                          ],
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
                      boxShadow: const []),
                ),
                preferredSize: Size.fromHeight(Get.height * 0.1),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(AddCustomer());
                },
                child: Icon(
                  Icons.add,
                  color: HexColor('#ffffff'),
                ),
              ),
              body: Container(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: (controller.cusUserResult.isEmpty)
                          ? noListCustomer()
                          : ListView.builder(
                              itemCount: controller.cusUserResult.length,
                              itemBuilder: (context, index) {
                                var menu = controller.cusUserResult[index].obs;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 16.0, right: 16.0),
                                  child: Container(
                                    child: ListTile(
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        dense: false,
                                        title: Text(
                                          controller.cusUserResult[index].pamId
                                                      .toString()
                                                      .length <=
                                                  9
                                              ? '${controller.cusUserResult[index].name}'
                                              : '${controller.cusUserResult[index].name!.substring(0, 9)}+..',
                                          style: GoogleFonts.montserrat(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        subtitle: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            controller
                                                .cusUserResult[index].uniqueId!,
                                            style: GoogleFonts.montserrat(
                                              color: HexColor('#707793'),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                        leading: CircleAvatar(
                                            maxRadius: 30,
                                            backgroundColor: controller
                                                        .cusUserResult[index]
                                                        .active ==
                                                    1
                                                ? HexColor('#05C270')
                                                    .withOpacity(0.1)
                                                : HexColor('#FF3B3B')
                                                    .withOpacity(0.1),
                                            child: Text(
                                              controller.getInitials(controller
                                                  .cusUserResult[index].name!
                                                  .toUpperCase()),
                                              style: GoogleFonts.montserrat(
                                                color: controller
                                                            .cusUserResult[
                                                                index]
                                                            .active ==
                                                        1
                                                    ? HexColor('#05C270')
                                                    : HexColor('#FF3B3B'),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        trailing: SizedBox(
                                          width: 86,
                                          height: 25,
                                          child: Row(
                                            children: [
                                              Icon(
                                                EvaIcons.compassOutline,
                                                color: HexColor('#0063F8'),
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Container(
                                                width: 26,
                                                child: Text(
                                                  controller
                                                              .cusUserResult[
                                                                  index]
                                                              .pamId
                                                              .toString()
                                                              .length <=
                                                          3
                                                      ? controller
                                                          .cusUserResult[index]
                                                          .pamId
                                                          .toString()
                                                      : controller
                                                              .cusUserResult[
                                                                  index]
                                                              .pamId
                                                              .toString()
                                                              .substring(0, 3) +
                                                          '..',
                                                  style: GoogleFonts.montserrat(
                                                    color: HexColor('#707793'),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.amber,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                    decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0.0, 8.0),
                                            color: Color.fromRGBO(
                                                0, 99, 248, 0.16),
                                            blurRadius: 24,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                        color: Colors.white),
                                  ),
                                );
                              })),
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [HexColor('#5433FF'), HexColor('#0063F8')])),
              ),
            ));
      },
    );
  }

  Widget noListCustomer() {
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
            "Belum ada pelanggan",
            style: GoogleFonts.montserrat(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Tambahkan pelanggan baru melalui\n tombol biru di bawah.",
            style: GoogleFonts.montserrat(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
