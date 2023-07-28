import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart' as mat show Image;
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:google_vision/google_vision.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class VisionDemoScreen extends StatefulWidget {
  const VisionDemoScreen({super.key, required this.title});

  final String title;

  @override
  State<VisionDemoScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VisionDemoScreen> {
  String _image = '';

  Future<String> getFileFromAsset(String assetFileName,
      {String? temporaryFileName}) async {
    final ByteData byteData = await rootBundle.load('assets/$assetFileName');

    final ByteBuffer buffer = byteData.buffer;

    final String fileName = temporaryFileName ?? assetFileName;

    final String filePath = await getTempFile(fileName);

    await File(filePath).delete();

    await File(filePath).writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return filePath;
  }

  Future<String> getTempFile([String? fileName]) async {
    final Directory tempDir = await getTemporaryDirectory();

    return '${tempDir.path}${Platform.pathSeparator}${fileName ?? UniqueKey().toString()}';
  }

  Future<void> drawHello(String outFile) async {
    final String fontZipFile = await getFileFromAsset('arial_unicode.ttf.zip');

    final Uint8List fontFile = await File(fontZipFile).readAsBytes();

    final img.BitmapFont font = img.BitmapFont.fromZip(fontFile);

    final img.Image image = img.Image(width: 320, height: 200);

    img.drawString(image, 'Hello',
        font: font, x: 10, y: 100, color: img.ColorInt8.rgb(0, 0, 0));

    // final testFile = await getTempFile();

    await img.encodePngFile(outFile, image);
  }

  Future<void> _processImage() async {
    final String jwtFromAsset = await getFileFromAsset('service_credentials.json');

    final GoogleVision googleVision = await GoogleVision.withJwt(jwtFromAsset);

    final String imageFile = await getFileFromAsset(
        'young-man-smiling-and-thumbs-up.jpg',
        temporaryFileName: 'young-man-smiling-and-thumbs-up.jpg');

    final Painter image = Painter.fromFilePath(imageFile);

    final Painter cropped = image.copyCrop(70, 30, 640, 480);

    final String filePath = await getTempFile();

    await cropped.writeAsJpeg(filePath);

    final AnnotationRequests requests = AnnotationRequests(requests: [
      AnnotationRequest(image: Image(painter: image), features: [
        Feature(maxResults: 10, type: 'FACE_DETECTION'),
        Feature(maxResults: 10, type: 'OBJECT_LOCALIZATION')
      ])
    ]);

    final AnnotatedResponses annotatedResponses = await googleVision.annotate(requests: requests);

    for (final AnnotateImageResponse annotatedResponse in annotatedResponses.responses) {
      for (final FaceAnnotation faceAnnotation in annotatedResponse.faceAnnotations) {
        GoogleVision.drawText(
            image,
            faceAnnotation.boundingPoly.vertices.first.x + 2,
            faceAnnotation.boundingPoly.vertices.first.y + 2,
            'Face - ${faceAnnotation.detectionConfidence}');

        GoogleVision.drawAnnotations(
            image, faceAnnotation.boundingPoly.vertices);
      }
    }

    for (final AnnotateImageResponse annotatedResponse in annotatedResponses.responses) {
      annotatedResponse.localizedObjectAnnotations
          .where((LocalizedObjectAnnotation localizedObjectAnnotation) =>
              localizedObjectAnnotation.name == 'Person')
          .toList()
          .forEach((LocalizedObjectAnnotation localizedObjectAnnotation) {
        GoogleVision.drawText(
            image,
            (localizedObjectAnnotation.boundingPoly.normalizedVertices.first.x *
                    image.width)
                .toInt(),
            (localizedObjectAnnotation.boundingPoly.normalizedVertices.first.y *
                        image.height)
                    .toInt() -
                16,
            'Person - ${localizedObjectAnnotation.score}');

        GoogleVision.drawAnnotationsNormalized(
            image, localizedObjectAnnotation.boundingPoly.normalizedVertices);
      });
    }

    await drawHello(filePath);

    // await image.writeAsJpeg(filePath);

    setState(() {
      _image = filePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Processed image will appear below:',
            ),
            if (_image == '') const CircularProgressIndicator() else mat.Image.file(
                    File(_image),
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) => Container(
                      color: Colors.grey,
                      width: 100,
                      height: 100,
                      child: const Center(
                        child: Text('Error load image',
                            textAlign: TextAlign.center),
                      ),
                    ),
                  )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _processImage,
        tooltip: 'Process Image',
        child: const Icon(Icons.image_outlined),
      ),
    );
  }
}
