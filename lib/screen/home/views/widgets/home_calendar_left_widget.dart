import 'package:flutter/material.dart';

class HomeCalendarLeftWidget extends StatelessWidget {
  const HomeCalendarLeftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
   final DateTime today = DateTime.now();
   final int daysInMonth =
        DateTimeRange(start: today, end: DateTime(today.year, today.month + 1))
            .duration
            .inDays;
    final List<Widget> dateWidget = List.generate(daysInMonth, (int index) {
      return Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
          ),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            '${index + 1}',
            style: theme.headlineSmall,
          ),
        ),
      );
    });
    return SizedBox(
        width: 55,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              height: 40,
              color: Colors.white,
            ),
            ...dateWidget
          ],
        ));
  }
}
