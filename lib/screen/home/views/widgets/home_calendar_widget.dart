import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '../../../../core/constants/app_color.dart';
import '../../controllers/home_controller.dart';
import 'table_cell_widget.dart';

class HomeCalendarWidget extends ConsumerWidget {
  HomeCalendarWidget({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final HomeScreenController model = ref.watch(homeScreenProvider);
    final double screenWidth = MediaQuery.of(context).size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final DateTime today = DateTime.now();
    final int daysInMonth = DateUtils.getDaysInMonth(today.year, today.month);

    /// Simple generator for column title
    List<String> titleColumn = [];
    double contentCellWidth = 80.0;

    titleColumn = List.generate(model.calendarList.length,
        (int i) => model.calendarList[i].summary!.replaceAll('@gmail.com', ''));
    if (model.calendarList.length == 1) {
      contentCellWidth = screenWidth - 50;
    } else if (model.calendarList.length == 2) {
      contentCellWidth = (screenWidth - 50) * .5;
    } else if (model.calendarList.length == 3) {
      contentCellWidth = (screenWidth - 50) * .33;
    }

    /// Simple generator for row title
    final List<String> titleRow =
        List.generate(daysInMonth, (int i) => '${i + 1}');

    return !model.isBusy
        ? Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 25,
                  child: Text(
                    '${today.month}',
                    textAlign: TextAlign.center,
                    style: textTheme.displayLarge!.copyWith(fontSize: 70),
                  )),
              StickyHeadersTable(
                  columnsLength: titleColumn.length,
                  rowsLength: titleRow.length,
                
                  columnsTitleBuilder: (i) => Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
                        padding: const EdgeInsets.all(7),
                        width: contentCellWidth,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: i == 0
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15))
                                : null,
                            color: AppColor.cHeaderColor[i].withOpacity(0.9)),
                        child: Text(
                          titleColumn[i],
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodySmall!.copyWith(
                              fontSize: 15.0, color: AppColor.bgColor),
                        ),
                      ),
                  rowsTitleBuilder: (int i) {
                    String bar = DateFormat('EEE').format(DateTime(
                        today.year, today.month, int.parse(titleRow[i])));
                    return TableCellWidget.stickyColumn(
                      '${titleRow[i]}\n$bar',
                      index: i,
                      textStyle:
                          textTheme.headlineSmall!.copyWith(fontSize: 12.0),
                      cellDimensions: CellDimensions.variableRowHeight(
                          contentCellWidth: contentCellWidth,
                          rowHeights: model.rowHeightsList,
                          stickyLegendWidth: 50,
                          stickyLegendHeight: 80),
                      colorBg: bar == 'Sat'
                          ? const Color(0xFF6ABCF0).withOpacity(.10)
                          : bar == 'Sun'
                              ? const Color(0xFFE07C74).withOpacity(.10)
                              : Colors.white,
                    );
                  },
                  contentCellBuilder: (int i, int j) {
                    final String bar = DateFormat('EEE').format(DateTime(
                        today.year, today.month, int.parse(titleRow[j])));

                   
                    return TableCellWidget.content(
                      '',
                      listText: model.cananderData[i][j],
                      textStyle: textTheme.bodySmall!.copyWith(
                          fontSize: 12.0, overflow: TextOverflow.ellipsis),
                      cellDimensions: CellDimensions.variableRowHeight(
                          contentCellWidth: contentCellWidth,
                          rowHeights: model.rowHeightsList,
                          stickyLegendWidth: 50,
                          stickyLegendHeight: 80),
                      onTap: () async {
                        await model.navToCalenderDetails(j, titleColumn[i], model.cananderData[i][j]);
                      },
                      colorBg: bar == 'Sat'
                          ? const Color(0xFF6ABCF0).withOpacity(.10)
                          : bar == 'Sun'
                              ? const Color(0xFFE07C74).withOpacity(.10)
                              : Colors.white,
                    );
                  },
                  legendCell: TableCellWidget.legend(
                    '',
                    colorBg: AppColor.bgColor,
                    textStyle: textTheme.bodySmall!.copyWith(fontSize: 16.5),
                    cellDimensions: const CellDimensions.fixed(
                        contentCellWidth: 40,
                        contentCellHeight: 40,
                        stickyLegendWidth: 50,
                        stickyLegendHeight: 80),
                  ),
                  showVerticalScrollbar: false,
                  showHorizontalScrollbar: false,
             
                  cellDimensions: CellDimensions.variableRowHeight(
                      contentCellWidth: contentCellWidth,
                      rowHeights: model.rowHeightsList,
                      stickyLegendWidth: 50,
                      stickyLegendHeight: 80)),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}

class ContentTextWidget extends StatelessWidget {
  final List<String> textList;
  final Color bgColor;
  const ContentTextWidget(
      {super.key, required this.textList, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return textList.length > 0
        ? Container(
            color: bgColor,
            child: Column(
              children: textList
                  .map((e) => Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                      ))
                  .toList(),
            ),
          )
        : Container(
            color: bgColor,
            child: Text(''),
          );
  }
}
