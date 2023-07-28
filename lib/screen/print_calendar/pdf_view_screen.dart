import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:typed_data';

import '../home/controllers/home_controller.dart';
import 'print_calendar_controller.dart';
import 'widget/calendar_pdf.dart';

@RoutePage<String>()
class PdfViewScreen extends ConsumerStatefulWidget {
  final List<String> listMonth;
  const PdfViewScreen({super.key, required this.listMonth});

  @override
  ConsumerState<PdfViewScreen> createState() => _PdfViewState();
}

class _PdfViewState extends ConsumerState<PdfViewScreen> {
  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];
    final model = ref.watch(printCalendarProvider);
    Size size = MediaQuery.of(context).size;
    final HomeScreenController homeModel = ref.watch(homeScreenProvider);
    List<String> titleColumn = [];
    titleColumn = List.generate(
        homeModel.calendarList.length,
        (int i) =>
            homeModel.calendarList[i].summary!.replaceAll('@gmail.com', ''));
    return Scaffold(
      appBar: AppBar(
        title: Text('Pdf View'),
      ),
      body: PdfPreview(
        build: (format) async =>
            const Example('CALENDAR', 'calendar.dart', generateCalendar)
                .builder(
                    format,
                    CustomData(
                        titleColumn: titleColumn,
                        cananderData: homeModel.cananderData,
                        rowHeightsList: homeModel.rowHeightsList)),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }
}

class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;

  final bool needsData;
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(
  PdfPageFormat pageFormat,
  CustomData data,
);
