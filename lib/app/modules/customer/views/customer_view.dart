import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/customer_controller.dart';
import '../providers/customer_provider.dart';
import 'add_customer.dart';
import 'detail_customer.dart';

class CustomerView extends GetView<CustomerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      init: CustomerController(p: CustomerProviders()),
      builder: (controller) {
        return Obx(() => Scaffold(
              appBar: (controller.isSearch.value)
                  ? buildAppBarSearch(context, controller)
                  : PreferredSize(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isSearch.value = true;
                                      },
                                      child: const Icon(
                                        EvaIcons.search,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      padding: const EdgeInsets.only(right: 8),
                                      icon: const Icon(EvaIcons.moreVertical,
                                          color: Colors.white),
                                      onSelected: (String selectedValue) {
                                        print(selectedValue);
                                        if (selectedValue == '2') {
                                          controller.getPdfAll();
                                        }
                                      },
                                      itemBuilder: (BuildContext ctx) => [
                                            // PopupMenuItem(
                                            //     child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            //       children: [
                                            //         const Text(
                                            //             'Bagikan QR Code'),
                                            //         const SizedBox(
                                            //           width: 8,
                                            //         ),
                                            //         Icon(
                                            //           EvaIcons.shareOutline,
                                            //           color:
                                            //               HexColor('#0063F8'),
                                            //         )
                                            //       ],
                                            //     ),
                                            //     value: '1'),
                                            PopupMenuItem(
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                        'Download QR Code'),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Icon(
                                                      EvaIcons
                                                          .cloudDownloadOutline,
                                                      color:
                                                          HexColor('#FF3B3B'),
                                                    )
                                                  ],
                                                ),
                                                value: '2'),
                                          ])
                                ],
                              ),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              HexColor('#5433FF'),
                              HexColor('#0063F8')
                            ]),
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
                      child: (controller.cusUserResult.isEmpty&& controller.cusUserResult.length<=0)
                          ? controller.noListCustomer()
                          : ListView.builder(
                              itemCount: controller.cusUserResult.length,
                              itemBuilder: (context, index) {
                                var menu = controller.cusUserResult[index].obs;
                                return GestureDetector(
                                  onTap: () {
                                    controller.idDetailController.text =
                                        controller.cusUserResult[index].id.toString();
                                    controller.nameDetailController.text =
                                        controller.cusUserResult[index].name!;
                                    controller.phoneDetailNumberCusController
                                            ?.text =
                                        controller
                                            .cusUserResult[index].phoneNumber??'';
                                    controller.addressDetailCusController?.text =
                                        controller
                                            .cusUserResult[index].address??'';
                                    int v = controller.isRadio.value =
                                        controller.cusUserResult[index].active!;
                                    int v2 = controller.isRadio.value =
                                        controller.cusUserResult[index].active!;
                                    print(v);
                                    controller.meterDetailCusController.text =
                                        controller.cusUserResult[index].meter
                                            .toString();
                                    controller
                                            .uniqueIdDetailCusController.text =
                                        controller
                                            .cusUserResult[index].uniqueId!;
                                    Get.to(CustomerDetailView(
                                      admin: 0,
                                    ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 16.0, right: 16.0),
                                    child: Container(
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          dense: false,
                                          title: Text(
                                            controller.cusUserResult[index]
                                                        .name
                                                        .toString()
                                                        .length <=
                                                  12
                                                ? '${controller.cusUserResult[index].name}'
                                                : '${controller.cusUserResult[index].name!.substring(0, 12)}'+'..',
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
                                              controller.cusUserResult[index]
                                                  .uniqueId!,
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
                                                controller.getInitials(
                                                    controller
                                                        .cusUserResult[index]
                                                        .name!
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
                                            width: 94,
                                            height: 25,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  EvaIcons.compassOutline,
                                                  color: HexColor('#0063F8'),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                Container(
                                                  width: 30,
                                                  child: Text(
                                                    controller
                                                                .cusUserResult[
                                                                    index]
                                                                .meter
                                                                .toString()
                                                                .length <=
                                                            3
                                                        ? controller
                                                            .cusUserResult[
                                                                index]
                                                            .meter
                                                            .toString()
                                                        : controller
                                                                .cusUserResult[
                                                                    index]
                                                                .meter
                                                                .toString()
                                                                .substring(
                                                                    0, 3) +
                                                            '..',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color:
                                                          HexColor('#707793'),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
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

  PreferredSize buildAppBarSearch(
      BuildContext context, CustomerController controller) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 5.0, top: 20.0, right: 10.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  controller.isSearch.value = false;
                  controller.searchValue.value = '';
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: AirenTextFormFieldBase(
                  onSubmit: (val) {
                    controller.searchController.clear();
                    logger.i(val!);
                    return null;
                  },
                  onChange: (val) {
                    controller.searchValue.value = val!;
                    return null;
                  },
                  suffixIcon: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(EvaIcons.search),
                  ),autofocus: true,
                  textInputType: TextInputType.text,
                  hintText: 'Cari..',
                  obscureText: false,
                  passwordVisibility: false,
                  controller: controller,
                  textEditingController: controller.searchController,
                  returnValidation: (val) {
                    if (val!.isEmpty) {
                      return "Tarif dasar harus terisi";
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
              ))
            ],
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [HexColor('#5433FF'), HexColor('#0063F8')]),
            boxShadow: const []),
      ),
      preferredSize: Size.fromHeight(Get.height * 0.1),
    );
  }

  
}
