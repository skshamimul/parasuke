import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_view/json_view.dart';
import '../../core/constants/app_const.dart';

import '../../widget/button_widget.dart';
import 'ocr_controller.dart';
import 'painter/text_painter copy.dart';

@RoutePage<String>()
class OCRScreen extends ConsumerWidget {
  const OCRScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OCRScreenController model = ref.watch(ocrScreenProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Camara'),
      ),
      body: !model.isBusy
          ? Column(
              children: [
                InteractiveViewer(
                  panEnabled: true,
                  minScale: 0.8,
                  maxScale: 4,
                  child: Container(
                    width: AppConst.deviceWidth(context),
                    height: AppConst.deviceHeight(context) * 0.7,
                    color: Colors.grey,
                    child: model.imagePath != null && model.imageSize != null
                        ? Container(
                            height: AppConst.deviceHeight(context) * 0.7,
                            width: AppConst.deviceWidth(context),
                            color: Colors.black,
                            child: model.textElements.isNotEmpty
                                ? CustomPaint(
                                    foregroundPainter: TextDetectorPainter(
                                      model.imageSize!,
                                      model.textElements,
                                    ),
                                    child: AspectRatio(
                                      aspectRatio: model.imageSize!.aspectRatio,
                                      child: Image.file(
                                        File(model.imagePath!),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  )
                                : AspectRatio(
                                    aspectRatio: model.imageSize!.aspectRatio,
                                    child: Image.file(
                                      File(model.imagePath!),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                          )
                        : Container(
                            height: AppConst.deviceHeight(context) * 0.7,
                            padding: const EdgeInsets.all(10),
                            color: Colors.black,
                          ),
                  ),
                ),
                AppButtonWidget(
                  text: 'Scan Image',
                  onPressed: () async {
                    await model.getImageFromCamera();
                  },
                ),
                // if (model.taskList.isNotEmpty)
                //   Expanded(
                //       child: ListView(
                //     children: [
                //       ...model.taskList
                //           .map((String e) => ListTile(
                //                 title: Text(e),
                //               ))
                //           .toList()
                //     ],
                //   ))
                if (model.apiRes != null)
                  Expanded(
                    child: JsonConfig(
                      data: JsonConfigData(
                        gap: 100,
                        style: const JsonStyleScheme(
                          quotation: JsonQuotation.same('"'),
                          // set this to true to open all nodes at start
                          // use with caution, it will cause performance issue when json items is too large
                          openAtStart: false,
                          arrow: Icon(Icons.arrow_forward),
                          // too large depth will cause performance issue
                          depth: 2,
                        ),
                        color: const JsonColorScheme(),
                      ),
                      child: JsonView(
                        json: model.apiRes,
                      ),
                    ),
                  )
              ],
            )
          :  const Center(
            child: CircularProgressIndicator(),
          ),
    );
  }
}
