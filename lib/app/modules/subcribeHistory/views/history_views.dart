import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../utils/utils.dart';
import '../../../widgets/loginTextFormFieldBase.dart';
import '../../error_handling/views/error_handling_view.dart';
import '../controllers/history_controller.dart';
import '../providers/history_providers.dart';
import 'invoice_subcriber.dart';

class HistorySubView extends GetView<HistorySubController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistorySubController>(
      init: HistorySubController(p: HistorySubProviders()),
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
                                      'Riwayat Berlangganan',
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
              body: Container(
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: controller.result.isEmpty
                          ? controller.noListSearch()
                          : ListView.builder(
                              itemCount: controller.result.value.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(SubcriberInvoice(
                                        data: controller.result[index]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, left: 16.0, right: 16.0),
                                    child: Container(
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          dense: false,
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .result[index].descriptios!,
                                                style: GoogleFonts.montserrat(
                                                  color: HexColor('#3C3F58'),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  'Rp ${rupiah(controller.result[index].price)}',
                                                  style: GoogleFonts.montserrat(
                                                    color: HexColor('#FF8801'),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              '${controller.result[index].uniqueId}',
                                              style: GoogleFonts.montserrat(
                                                color: HexColor('#707793')
                                                    .withOpacity(0.7),
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          leading: CircleAvatar(
                                              maxRadius: 30,
                                              backgroundColor:
                                                  HexColor('#05C270')
                                                      .withOpacity(0.05),
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      controller.result[index]
                                                          .dateEnd!.day
                                                          .toString()
                                                          .toUpperCase(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: HexColor(
                                                                '#05C270')
                                                            .withOpacity(0.8),
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${months[controller.result[index].dateEnd!.month - 1]}',
                                                      style: GoogleFonts
                                                          .montserrat(
                                                        color: HexColor(
                                                                '#707793')
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          trailing: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Icon(
                                              EvaIcons.checkmarkCircle2Outline,
                                              color: HexColor('#05C270'),
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
      BuildContext context, HistorySubController controller) {
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
                  ),
                  autofocus: true,
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
