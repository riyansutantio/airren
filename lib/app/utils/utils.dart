import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

DateTime dateFormat({DateTime? date}){
  return DateTime.parse(DateFormat('yyyy-MM-dd').format(date!));
}

String dateFormatMonth({DateTime? date}){
  return DateFormat.yMMMd().format(date!);
}
 List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'August',
    'Sept',
    'Octo',
    'Nov',
    'Dec'
  ];
 List<String> monthsAll = [
    'Januari',
    'Febuari',
    'Maret',
    'April',
    'May',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'October',
    'November',
    'Desember'
  ];
final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('dd-MM-yyyy');
final DateFormat formatterYear = DateFormat('yyyy-MM-dd');
final DateFormat formatterMonth = DateFormat.yMMMd();

String get formatted => formatter.format(now);
String get formattedYear => formatterYear.format(now);
String get formattedOnlyYear => formatterYear.format(now);

String? idrFormatter({int? value}) {
  return NumberFormat.currency(locale: 'id', symbol: 'IDR ', decimalDigits: 0).format(double.parse('${value ?? 0}'));
}

String? rpFormatter({int? value}) {
  return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(double.parse('${value ?? 0}'));
}

String? rpFormatterWithOutSymbol({int? value}) {
  return NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(double.parse('${value ?? 0}'));
}

String rupiah(value, {String separator = '.', String trailing = ''}) {
  return value
          .toString()
          .replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}${separator}') +
      trailing;
}
