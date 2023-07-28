import 'package:flutter/material.dart';

class HomeCalendarRightWidget extends StatelessWidget {
  HomeCalendarRightWidget({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    final DateTime today = DateTime.now();
    final int daysInMonth =
        DateTimeRange(start: today, end: DateTime(today.year, today.month + 1))
            .duration
            .inDays;
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom:
                    BorderSide(width: 1.0, color: Colors.lightBlue.shade900),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                eitchUserRow(),
                ...List.generate(daysInMonth, eitchDateRow)
              ],
            )));
  }

  Widget eitchDateRow(int date) {
    return Row(
      children: List.generate(
          9,
          (int index) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                    left: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                    top: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                  ),
                  color: Colors.white,
                ),
                width: 81,
                height: 40,
                child: Text(
                  'date $date ,index ${index + 1}',
                  textAlign: TextAlign.center,
                ),
              )),
    );
  }

  Widget eitchUserRow({Color color = Colors.green}) {
    return Row(
      children: List.generate(
          9,
          (int index) => Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                    left: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                    top: BorderSide(
                        width: 1.0, color: Colors.lightBlue.shade900),
                  ),
                  color: color,
                ),
                width: 81,
                height: 40,
                child: Text('index $index'),
              )),
    );
  }
}
