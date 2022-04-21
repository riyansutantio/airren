import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../model/pam_transaction.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../error_handling/views/unauthentication_view.dart';
import '../provider/transaction_provider.dart';

class TransactionController extends GetxController {
  TransactionController({required this.p});
  TransactionProvider? p;
  final boxUser = GetStorage();
  final count = 0.obs;
  final isLoadingPamTrans = false.obs;
  RxInt? total_balance=0.obs;

  final pamTransResult = <PamTransactionsModel>[].obs;
  @override
  void onInit() async {
    super.onInit();
    logger.i('test');
    await getPamTransactions();
  }

  Future getPamTransactions() async {
    try {
      isLoadingPamTrans.value = true;
      final res = await p!.getPamTransaction(bearer: boxUser.read(tokenBearer));
      // logger.wtf(res!.data!.data!.toList());
      if (res == null) {
        Get.to(UnauthenticationView());
        logger.i('kosong');
      } else {
        total_balance!.value = res.data!.totalBalance!;

        pamTransResult.assignAll(res.data!.transModel!);
        logger.i(total_balance);
      }
    } catch (e) {
      logger.e(e);
    } finally {
      isLoadingPamTrans.value = false;
    }
  }
}
