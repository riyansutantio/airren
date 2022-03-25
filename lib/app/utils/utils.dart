import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

DateTime dateFormat({DateTime? date}){
  return DateTime.parse(DateFormat('yyyy-MM-dd').format(date!));
}