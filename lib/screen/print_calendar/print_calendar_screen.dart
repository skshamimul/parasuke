// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';
import '../../widget/button_widget.dart';
import '../../widget/checkbox_group_widget.dart';
import '../../widget/custom_checkbox.dart';
import 'print_calendar_controller.dart';
import 'package:intl/intl.dart';

@RoutePage<String>()
class PrintCalendarScreen extends ConsumerStatefulWidget {
  PrintCalendarScreen({super.key});

  @override
  ConsumerState<PrintCalendarScreen> createState() =>
      _PrintCalendarScreenState();
}

class _PrintCalendarScreenState extends ConsumerState<PrintCalendarScreen> {
  List<String> _selecteMonths = [];

  List<String> monthList = [];
  String error = '';

  @override
  void initState() {
    final DateTime today = DateTime.now();
    for (var i = 0; i < 6; i++) {
      final DateTime month = DateTime(today.year, today.month + i);
      final String formateMonth = DateFormat.yMMMM().format(month);

      monthList.add(formateMonth);
    }
    super.initState();
  }

  void _onCategorySelected(bool selected, String month) {
    if (selected == true) {
      _selecteMonths.add(month);
    } else {
      _selecteMonths.remove(month);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Size size = MediaQuery.of(context).size;

    final bool isLight = theme.brightness == Brightness.light;
    final model = ref.watch(printCalendarProvider);

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        title: Text(
          'プリントする',
        ),
        centerTitle: true,
        //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'プリントするページを選択してください。\n画像として保存できるので、ご自宅、コンビニで\nプリントができます。',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '最新6ヶ月のカレンダー',
                style: theme.textTheme.labelLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: isLight ? Colors.white : Colors.black54),
                child: Column(
                  children: monthList
                      .map((e) => Column(
                            children: [
                              CheckboxListTile.adaptive(
                                checkboxShape: const CircleBorder(
                                  side: BorderSide(width: 10),
                                  eccentricity: 1,
                                ),
                                value: _selecteMonths.contains(e),
                                onChanged: (value) {
                                  if (value != null) {
                                    _onCategorySelected(value, e);
                                  }
                                },
                                title: Text(e),
                              ),
                              const Divider()
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  error,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge!
                      .copyWith(color: theme.colorScheme.error),
                ),
              ),
            Align(
              alignment: Alignment.center,
              child: AppButtonWidget(
                onPressed: () {
                  if (_selecteMonths.isNotEmpty) {
                    model.navToPdfView(_selecteMonths);
                    error = '';
                  } else {
                    error = 'Please Select At Least One Month';
                  }
                  setState(() {});
                },
                backgroundColor: theme.primaryColor,
                text:
                    'Convert to A3 size PDF \n(suitable for convenience store printing)',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: AppButtonWidget(
                onPressed: () {},
                backgroundColor: theme.primaryColor,
                text: 'Convert to A4 size PDF\n (suitable for home printing)',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.center,
              child: AppButtonWidget(
                onPressed: () {},
                backgroundColor: theme.primaryColor,
                text: 'save as image',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'コンビニでプリントする方はこちら',
                      style: theme.textTheme.labelMedium!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
