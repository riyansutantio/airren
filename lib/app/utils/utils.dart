import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

DateTime dateFormat({DateTime? date}){
  return DateTime.parse(DateFormat('yyyy-MM-dd').format(date!));
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateFormat formatterYear = DateFormat('yyyy-MM-dd');
String get formatted => formatter.format(now);
String get formattedYear => formatterYear.format(now);
String get formattedOnlyYear => formatterYear.format(now);