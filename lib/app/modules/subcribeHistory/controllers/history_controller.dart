import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../model/history_subcriberModel.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../providers/history_providers.dart';

class HistorySubController extends GetxController {
  HistorySubController({required this.p});
  //TODO: Implement CustomerController
  HistorySubProviders? p;

  final searchValue = ''.obs;
  final isSearch = false.obs;

  final result = <historySub>[].obs;
  final boxUser = GetStorage();
  final searchController = TextEditingController();

  final isloading = false.obs;
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await gethistorySubcribe();
  }

  @override
  void onReady() {
    super.onReady();
    debounce(searchValue, (String? val) {
      print(val!.length);
      if (result.value.isEmpty) {
        isloading.value = true;
      } else {
        isloading.value = false;
      }
      return searchManage();
    }, time: 500.milliseconds);
  }

  Widget noListSearch() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/search.png",
            width: 77,
            height: 90,
          ),
          const SizedBox(height: 30),
          Text(
            "Tidak ditemukan",
            style: GoogleFonts.montserrat(
                fontSize: 16, color: HexColor('#3C3F58'), fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Belum ada item berlangganan yang\nsesuai dengan kata kunci di atas",
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

  Future gethistorySubcribe() async {
    try {
      isloading.value = true;
      final res =
          await p!.getHistorySubcribe(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        result.assignAll(res.data!.cusMs!);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isloading.value = false;
    }
  }

  Future searchManage() async {
    isloading.value = true;
    final res = await p!.getHistorySubcribeSearch(
        bearer: boxUser.read(tokenBearer), search: searchValue.value);
    // logger.wtf(res!.data!.data!.toList());

    result.assignAll(res!.data!.cusMs!);
  }
}
