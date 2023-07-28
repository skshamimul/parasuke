import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_vision/google_vision.dart' as vision;
import 'package:path_provider/path_provider.dart';

import 'camara_view.dart';
import 'painter/text_painter.dart';

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({super.key});

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  final LanguageIdentifier _languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);
  List<String> taskList = [];

  @override
  Future<void> dispose() async {
    _canProcess = false;
    await _textRecognizer.close();
    await _languageIdentifier.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Text Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: (String inputImage) async {
        await _processImage(inputImage);
      },
    );
  }

  Future<void> _processImage(String imagePath) async {
    final String jwtFromAsset = await getFileFromAsset(
        'assets/my_jwt_credentials.json',
        temporaryFileName: 'credential.json');

    final vision.GoogleVision googleVision =
        await vision.GoogleVision.withJwt(jwtFromAsset);
    final vision.Painter painter = vision.Painter.fromFilePath(imagePath);
    final vision.AnnotationRequests requests = vision.AnnotationRequests(requests: [
      vision.AnnotationRequest(
          image: vision.Image(painter: painter),
          features: [
            vision.Feature(maxResults: 10, type: 'DOCUMENT_TEXT_DETECTION')
          ])
    ]);

    print('checking...');

    final vision.AnnotatedResponses annotatedResponses =
        await googleVision.annotate(requests: requests);

    print('done.\n');

    for (final vision.AnnotateImageResponse annotatedResponse in annotatedResponses.responses) {
      for (final vision.EntityAnnotation textAnnotation in annotatedResponse.textAnnotations) {
        vision.GoogleVision.drawText(
            painter,
            textAnnotation.boundingPoly!.vertices.first.x + 2,
            textAnnotation.boundingPoly!.vertices.first.y + 2,
            textAnnotation.description);

        vision.GoogleVision.drawAnnotations(
            painter, textAnnotation.boundingPoly!.vertices);
       final List<String> stringList = textAnnotation.description.split('\n');
        taskList.addAll(stringList);
      }
    }

    log(taskList.toString(), name: 'text');
    final String filePath = await getTempFile();
    await painter.writeAsJpeg(filePath);
  }

  Future<String> _identifyPossibleLanguages(String text) async {
    final List<IdentifiedLanguage> possibleLanguages =
        await _languageIdentifier.identifyPossibleLanguages(text);

    // log('$text lang: ${possibleLanguages[0].languageTag}', name: 'description');

    return possibleLanguages[0].languageTag;
  }

  Future<String> getFileFromAsset(String assetFileName,
      {String? temporaryFileName}) async {
    final ByteData byteData = await rootBundle.load(assetFileName);

    final ByteBuffer buffer = byteData.buffer;

    final String fileName = temporaryFileName ?? assetFileName;

    final String filePath = await getTempFile(fileName);

    try {
      await File(filePath).delete();
    } catch (_) {
      print('file not found');
    }

    await File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return filePath;
  }

  Future<String> getTempFile([String? fileName]) async {
    final Directory tempDir = await getTemporaryDirectory();

    return '${tempDir.path}${Platform.pathSeparator}${fileName ?? UniqueKey().toString()}';
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final TextRecognizerPainter painter = TextRecognizerPainter(
          recognizedText,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      _customPaint = CustomPaint(painter: painter);
    } else {
      _text = 'Recognized text:\n\n${recognizedText.text}';
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
