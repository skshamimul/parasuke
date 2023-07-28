import 'dart:typed_data';

import 'package:flutter/material.dart' as mi;
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:collection/collection.dart';
import '../../../app/extensions.dart';
import 'pdf_table_cell_widget.dart';

class CalendarViewPdf extends StatelessWidget {
  final List<String> titleColumn;
  final List<List<List<Map<String, dynamic>>>> cananderData;
  final List<double> rowHeightsList;
  final List<String> titleRow;
  final int indexTitleRow;

  CalendarViewPdf(
      {required this.titleColumn,
      required this.cananderData,
      required this.titleRow,
      required this.indexTitleRow,
      required this.rowHeightsList});

  @override
  Widget build(Context context) {
    double contentCellWidth = 80.0;
    if (titleColumn.length == 1) {
      contentCellWidth = 600;
    } else if (titleColumn.length == 2) {
      contentCellWidth = 600 / 2;
    } else if (titleColumn.length == 3) {
      contentCellWidth = 600 / 3;
    } else if (titleColumn.length == 4) {
      contentCellWidth = 600 / 4;
    }
    final DateTime today = DateTime.now();

    return Column(children: [
      Row(children: [
        Container(width: 40, height: 40, color: PdfColors.white),
        Expanded(
            child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    titleColumn.length,
                    (int index) => Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                          ),
                          padding: const EdgeInsets.all(7),
                          width: contentCellWidth,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: index == 0
                                  ? const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      bottomLeft: Radius.circular(15))
                                  : null,
                              color: pdfHeaderColor[index]),
                          child: Text(titleColumn[index],
                              overflow: TextOverflow.clip,
                              style: const TextStyle(color: PdfColors.white)),
                        ))))
      ]),
      Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
            children: List.generate(
          titleRow.length,
          (int index) {
            String bar = DateFormat('EEE').format(
                DateTime(today.year, today.month, int.parse(titleRow[index])));
            return PdfTableCellWidget.stickyColumn(
              '${titleRow[index]}\n$bar',
              index: index,
              textStyle: TextStyle(fontSize: 12.0),
              cellDimensions: CellDimensions.fixed(
                  contentCellWidth: 40,
                  contentCellHeight: 40,
                  stickyLegendWidth: 50,
                  stickyLegendHeight: 80),
              colorBg: bar == 'Sat'
                  ? const PdfColor.fromInt(0xFF6ABCF0)
                  : bar == 'Sun'
                      ? const PdfColor.fromInt(0xFFE07C74)
                      : PdfColors.white,
            );
          },
        )),
        Expanded(
          child: Column(
              children: List.generate(
                  titleRow.length,
                  (int rowIdx) => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(titleColumn.length,
                              (int columnIdx) {
                        String bar = DateFormat('EEE').format(DateTime(
                            today.year,
                            today.month,
                            int.parse(titleRow[rowIdx])));
                        // print(cananderData[rowIdx][columnIdx]);
                        final newCananderData =
                            cananderData[columnIdx].slices(10).toList();

                        return PdfTableCellWidget.content(
                          '',
                          listText: newCananderData[indexTitleRow][rowIdx],
                          textStyle: TextStyle(fontSize: 12),
                          cellDimensions: CellDimensions.fixed(
                              contentCellWidth: contentCellWidth,
                              contentCellHeight: 40,
                              stickyLegendWidth: 50,
                              stickyLegendHeight: 80),
                          onTap: () async {},
                          colorBg: bar == 'Sat'
                              ? const PdfColor.fromInt(0xFF6ABCF0)
                              : bar == 'Sun'
                                  ? const PdfColor.fromInt(0xFFE07C74)
                                  : PdfColors.white,
                        );
                      })))),
        )
      ]))
    ]);
  }
}

Future<Uint8List> generateCalendar(
  PdfPageFormat pageFormat,
  CustomData data,
) async {
  //Create a PDF document.
  final document = Document();

  final DateTime today = DateTime.now();

  final int daysInMonth = mi.DateUtils.getDaysInMonth(today.year, today.month);

  final List<String> titleRow =
      List.generate(daysInMonth, (int i) => '${i + 1}');

  final List<List<String>> newTitleRow = titleRow.slices(10).toList();

  for (var i = 0; i < newTitleRow.length; i++) {
    document.addPage(
      Page(
          pageTheme: PageTheme(
              pageFormat: pageFormat,
              orientation: PageOrientation.landscape,
              theme: ThemeData.withFont(
                base: await PdfGoogleFonts.openSansRegular(),
                bold: await PdfGoogleFonts.openSansBold(),
              ),
              buildForeground: null),
          build: (Context context) => CalendarViewPdf(
              indexTitleRow: i,
              titleColumn: data.titleColumn,
              cananderData: data.cananderData,
              titleRow: newTitleRow[i],
              rowHeightsList: data.rowHeightsList)),
    );
  }

  return document.save();
}

class CustomData {
  const CustomData({
    required this.titleColumn,
    required this.cananderData,
    required this.rowHeightsList,
  });

  final List<String> titleColumn;
  final List<List<List<Map<String, dynamic>>>> cananderData;
  final List<double> rowHeightsList;
}
