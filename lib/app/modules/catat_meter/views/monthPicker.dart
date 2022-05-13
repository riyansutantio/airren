// ignore_for_file: deprecated_member_use, unnecessary_new

import 'dart:async';

import 'package:airen/app/modules/catat_meter/views/catat_meter_view.dart';
import 'package:airen/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/src/MonthSelector.dart';
import 'package:month_picker_dialog/src/YearSelector.dart';
import 'package:month_picker_dialog/src/common.dart';
import 'package:month_picker_dialog/src/locale_utils.dart';
import 'package:rxdart/rxdart.dart';

import '../controllers/catat_meter_controller.dart';
import '../provider/catat_meter_provider.dart';

/// Displays month picker dialog.
/// [initialDate] is the initially selected month.
/// [firstDate] is the optional lower bound for month selection.
/// [lastDate] is the optional upper bound for month selection.
Future<DateTime?> customMonthPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Locale? locale = const Locale('id', 'ID'),
}) async {
  assert(context != null);
  assert(initialDate != null);
  final localizations = locale == null
      ? MaterialLocalizations.of(context)
      : await GlobalMaterialLocalizations.delegate.load(locale);
  assert(localizations != null);
  return await showDialog<DateTime>(
    context: context,
    builder: (context) => _MonthPickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: locale,
      localizations: localizations,
    ),
  );
}

CatatMeterController catatController =
    Get.put(CatatMeterController(catatmeterProvider: CatatMeterProvider()));

class _MonthPickerDialog extends StatefulWidget {
  final DateTime? initialDate, firstDate, lastDate;
  final MaterialLocalizations localizations;
  final Locale? locale;

  const _MonthPickerDialog({
    Key? key,
    required this.initialDate,
    required this.localizations,
    this.firstDate,
    this.lastDate,
    this.locale,
  }) : super(key: key);

  @override
  _MonthPickerDialogState createState() => _MonthPickerDialogState();
}

class _MonthPickerDialogState extends State<_MonthPickerDialog> {
  final GlobalKey<YearSelectorState> _yearSelectorState = new GlobalKey();
  final GlobalKey<MonthSelectorState> _monthSelectorState = new GlobalKey();

  PublishSubject<UpDownPageLimit>? _upDownPageLimitPublishSubject;
  PublishSubject<UpDownButtonEnableState>?
      _upDownButtonEnableStatePublishSubject;

  Widget? _selector;
  DateTime? selectedDate, _firstDate, _lastDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        DateTime(widget.initialDate!.year, widget.initialDate!.month);
    if (widget.firstDate != null)
      _firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month);
    if (widget.lastDate != null)
      _lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month);

    _upDownPageLimitPublishSubject = new PublishSubject();
    _upDownButtonEnableStatePublishSubject = new PublishSubject();

    _selector = new MonthSelector(
      key: _monthSelectorState,
      openDate: selectedDate!,
      selectedDate: selectedDate!,
      upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
      upDownButtonEnableStatePublishSubject:
          _upDownButtonEnableStatePublishSubject!,
      firstDate: _firstDate,
      lastDate: _lastDate,
      onMonthSelected: _onMonthSelected,
      locale: widget.locale,
    );
  }

  void dispose() {
    _upDownPageLimitPublishSubject!.close();
    _upDownButtonEnableStatePublishSubject!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var locale = getLocale(context, selectedLocale: widget.locale);
    var header = buildHeader(theme, locale);
    var pager = buildPager(theme, locale);
    var content = Material(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [pager, buildButtonBar(context)],
        ),
      ),
      color: Colors.white,
    );
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: Dialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(builder: (context) {
              if (MediaQuery.of(context).orientation == Orientation.portrait) {
                return IntrinsicWidth(
                  child: Column(children: [header, content]),
                );
              }
              return IntrinsicHeight(
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [header, content]),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildButtonBar(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ButtonBar(
        children: <Widget>[
          ElevatedButton(
            onPressed: () => Navigator.pop(context, null),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Batal',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#0063F8'),
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: HexColor('#0063F8').withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () {
              logger.e(DateFormat('yyyy').format(selectedDate!));
              logger.e(DateFormat('MM').format(selectedDate!));
              var yearRaw = DateFormat('yyyy').format(selectedDate!);
              var monthRaw = DateFormat('MM').format(selectedDate!);
              logger.d(monthRaw);

              int year = int.parse(yearRaw);
              int month = int.parse(monthRaw);
              logger.e(month);
              catatController.month_Of.value = month;
              catatController.year_Of.value = year;
              catatController.addCatatMeterBulan();
              navigator!.pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Pilih',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: HexColor('#0063F8'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  penntuAngkaBulan(inp) {
    if (inp == 01) {
      return 1;
    } else if (inp == 02) {
      return 2;
    } else if (inp == 03) {
      return 3;
    } else if (inp == 04) {
      return 4;
    } else if (inp == 05) {
      return 5;
    } else if (inp == 06) {
      return 6;
    } else if (inp == 07) {
      return 7;
    } else if (inp == 08) {
      return 8;
    } else if (inp == 09) {
      return 9;
    } else {
      return inp;
    }
  }

  Widget buildHeader(ThemeData theme, String locale) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Container(
                  height: 6,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            Text(
              '${DateFormat.MMMM(locale).format(selectedDate!)}',
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _selector is MonthSelector
                    ? GestureDetector(
                        onTap: _onSelectYear,
                        child: new StreamBuilder<UpDownPageLimit>(
                          stream: _upDownPageLimitPublishSubject,
                          initialData: const UpDownPageLimit(0, 0),
                          builder: (_, snapshot) => Text(
                            '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                            style: GoogleFonts.montserrat(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#0063F8')),
                          ),
                        ),
                      )
                    : new StreamBuilder<UpDownPageLimit>(
                        stream: _upDownPageLimitPublishSubject,
                        initialData: const UpDownPageLimit(0, 0),
                        builder: (_, snapshot) => Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#0063F8')),
                            ),
                            Text(
                              '-',
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#0063F8')),
                            ),
                            Text(
                              '${DateFormat.y(locale).format(DateTime(snapshot.data!.downLimit))}',
                              style: GoogleFonts.montserrat(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#0063F8')),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            new StreamBuilder<UpDownButtonEnableState>(
              stream: _upDownButtonEnableStatePublishSubject,
              initialData: const UpDownButtonEnableState(true, true),
              builder: (_, snapshot) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_left,
                      color: HexColor('#FFCC00'),
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    onPressed:
                        snapshot.data!.upState ? _onUpButtonPressed : null,
                  ),
                  StreamBuilder<UpDownPageLimit>(
                    stream: _upDownPageLimitPublishSubject,
                    initialData: const UpDownPageLimit(0, 0),
                    builder: (_, snapshot) => Text(
                      '${DateFormat.y(locale).format(DateTime(snapshot.data!.upLimit))}',
                      style: GoogleFonts.montserrat(
                          fontSize: MediaQuery.of(context).size.width * 0.07,
                          fontWeight: FontWeight.normal,
                          color: Colors.black),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: HexColor('#FFCC00'),
                      size: MediaQuery.of(context).size.width * 0.1,
                    ),
                    onPressed:
                        snapshot.data!.downState ? _onDownButtonPressed : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPager(ThemeData theme, String locale) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.37,
      width: MediaQuery.of(context).size.width,
      child: Theme(
        data: theme.copyWith(
          accentColor: HexColor('#0063F8'),
          buttonTheme: ButtonThemeData(
            padding: EdgeInsets.all(2.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: new AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(child: child, scale: animation),
          child: _selector,
        ),
      ),
    );
  }

  void _onSelectYear() => setState(() => _selector = new YearSelector(
        key: _yearSelectorState,
        initialDate: selectedDate!,
        firstDate: _firstDate,
        lastDate: _lastDate,
        onYearSelected: _onYearSelected,
        upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
        upDownButtonEnableStatePublishSubject:
            _upDownButtonEnableStatePublishSubject!,
      ));

  void _onYearSelected(final int year) =>
      setState(() => _selector = new MonthSelector(
            key: _monthSelectorState,
            openDate: DateTime(year),
            selectedDate: selectedDate!,
            upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
            upDownButtonEnableStatePublishSubject:
                _upDownButtonEnableStatePublishSubject!,
            firstDate: _firstDate,
            lastDate: _lastDate,
            onMonthSelected: _onMonthSelected,
            locale: widget.locale,
          ));

  void _onMonthSelected(final DateTime date) => setState(() {
        selectedDate = date;
        _selector = new MonthSelector(
          key: _monthSelectorState,
          openDate: selectedDate!,
          selectedDate: selectedDate!,
          upDownPageLimitPublishSubject: _upDownPageLimitPublishSubject!,
          upDownButtonEnableStatePublishSubject:
              _upDownButtonEnableStatePublishSubject!,
          firstDate: _firstDate,
          lastDate: _lastDate,
          onMonthSelected: _onMonthSelected,
          locale: widget.locale,
        );
      });

  void _onUpButtonPressed() {
    if (_yearSelectorState.currentState != null) {
      _yearSelectorState.currentState!.goUp();
    } else {
      _monthSelectorState.currentState!.goUp();
    }
  }

  void _onDownButtonPressed() {
    if (_yearSelectorState.currentState != null) {
      _yearSelectorState.currentState!.goDown();
    } else {
      _monthSelectorState.currentState!.goDown();
    }
  }
}
