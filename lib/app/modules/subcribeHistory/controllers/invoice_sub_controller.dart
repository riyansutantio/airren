import 'package:get/get.dart';

import '../../../model/history_subcriberModel.dart';
import '../providers/history_providers.dart';

class InvoiceSubcribe extends GetxController {
  InvoiceSubcribe({required this.p,required this.data});
  //TODO: Implement CustomerController
  HistorySubProviders? p;
  historySub? data;
}
