import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:google_vision/google_vision.dart' as vision;
import 'package:http_parser/http_parser.dart';
import 'package:image_eadge_detection/image_edge_detection.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import '../../router/app_route.dart';
import '../../service/bottom_sheet_service.dart';
import '../../service/file_picker_service.dart';
import '../../service/setup_services.dart';

final ChangeNotifierProvider<OCRScreenController> ocrScreenProvider =
    ChangeNotifierProvider<OCRScreenController>(
        (ChangeNotifierProviderRef<OCRScreenController> ref) {
  return OCRScreenController(ref);
});

class OCRScreenController extends ChangeNotifier {
  OCRScreenController(this.ref) {
    getImageFromCamera();
  }
  final ChangeNotifierProviderRef ref;
  final BottomSheetService _bottomSheetService = getIt<BottomSheetService>();
  final FilePickerService _picker = getIt<FilePickerService>();
  final AppRouter _router = getIt<AppRouter>();
  final List<TextElement> _textElements = [];
  List<TextElement> get textElements => _textElements;
  final TextRecognizer _textRecognizer =
      TextRecognizer(script: TextRecognitionScript.japanese);
  final LanguageIdentifier _languageIdentifier =
      LanguageIdentifier(confidenceThreshold: 0.5);

  String? _imagePath;

  String? get imagePath => _imagePath;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  /// Define image size from image picker
  Size? _imageSize;
  Size? get imageSize => _imageSize;

  List<String> _taskList = [];
  List<String> get taskList => _taskList;

  Map<String, dynamic>? _apiRes;
  Map<String, dynamic>? get apiRes => _apiRes;

  Future<void> getImageFromCamera() async {
    setBusy(true);

    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

// Generate filepath for saving
    final String imageName =
        '${(DateTime.now().millisecondsSinceEpoch / 1000).round()}';
    final String imagePath =
        join((await getApplicationSupportDirectory()).path, '$imageName.jpeg');
    bool success = false;
    try {
      //Make sure to await the call to detectEdge.
      success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Scanning', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
    } catch (e) {
      print(e);
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    print('__________________isSuccess $success ___________');
    if (success) {
      //   _imagePath = imagePath;
      //   notifyListeners();

      // final InputImage inputImage = InputImage.fromFilePath(imagePath);
      // await _getImageSize(File(imagePath));
      // await _processImage(imagePath);
      await uploadImage(File(imagePath));
    }
    setBusy(false);
  }

  Future<void> _getImageSize(File? imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile!);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size size = await completer.future;
    _imageSize = size;
    print('__________________image Size $_imageSize ___________');
    notifyListeners();
  }

  Future<void> uploadImage(File image) async {
   
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://192.168.68.104:8000/process/"),
      );
      const Map<String, String> headers = <String, String>{
        'Content-type': 'multipart/form-data'
      };
      request.files.add(
        http.MultipartFile(
            'image', image.readAsBytes().asStream(), image.lengthSync(),
            filename: image.path.split('/').last,
            contentType: MediaType('image', 'png')),
      );
      request.headers.addAll(headers);
      print("request: " + request.toString());
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);

      _apiRes = jsonDecode(response.body) as Map<String, dynamic>;

      log(_apiRes.toString(), name: 'upload response');
    
  }

  Future<void> _processImage(String imagePath) async {
    final String jwtFromAsset = await getFileFromAsset(
        'assets/my_jwt_credentials.json',
        temporaryFileName: 'credential.json');

    final vision.GoogleVision googleVision =
        await vision.GoogleVision.withJwt(jwtFromAsset);
    final vision.Painter painter = vision.Painter.fromFilePath(imagePath);
    final vision.AnnotationRequests requests =
        vision.AnnotationRequests(requests: [
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
    final List<String> textList = [];
    for (final vision.AnnotateImageResponse annotatedResponse
        in annotatedResponses.responses) {
      for (final vision.EntityAnnotation textAnnotation
          in annotatedResponse.textAnnotations) {
        vision.GoogleVision.drawText(
            painter,
            textAnnotation.boundingPoly!.vertices.first.x + 2,
            textAnnotation.boundingPoly!.vertices.first.y + 2,
            textAnnotation.description);

        vision.GoogleVision.drawAnnotations(
            painter, textAnnotation.boundingPoly!.vertices);
        final List<String> stringList = textAnnotation.description.split('\n');
        textList.addAll(stringList);
      }
    }

    final String filePath = await getTempFile();
    await painter.writeAsJpeg(filePath);
    _taskList = textList;
    // _taskList = await _identifyPossibleLanguages(textList);
    // '_________ Start _________'.log;
    // _taskList.log;
    // '_________ End _________'.log;
    _imagePath = filePath;
  }

  Future<List<String>> _identifyPossibleLanguages(List<String> listText) async {
    final List<String> textList = [];
    for (final String element in listText) {
      final String text = element.trim();
      final List<IdentifiedLanguage> possibleLanguages =
          await _languageIdentifier.identifyPossibleLanguages(text);
      if (possibleLanguages[0].languageTag == 'ja') {
        textList.add(text);
      }
    }

    // log('$text lang: ${possibleLanguages[0].languageTag}', name: 'description');

    return textList;
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
  // Future<void> processImage(InputImage inputImage) async {
  //   final recognizedText = await _textRecognizer.processImage(inputImage);
  //   print(
  //       '__________________Start ${recognizedText.blocks.length} ___________');

  //   for (TextBlock block in recognizedText.blocks) {
  //     for (TextLine line in block.lines) {
  //       for (TextElement element in line.elements) {
  //         // if (!regEx.hasMatch(element.text.trim())) {

  //         print('${element.text}');

  //         _textElements.add(element);

  //         //  }
  //       }
  //     }
  //   }
  //   print('__________________End___________');
  //   notifyListeners();
  // }

  Future<void> getImageFromGallery() async {
// Generate filepath for saving
    final String imagePath = join((await getApplicationSupportDirectory()).path,
        '${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg');

    print('$imagePath : _imagePath');

    try {
      //Make sure to await the call to detectEdgeFromGallery.
      final bool success = await EdgeDetection.detectEdgeFromGallery(
        imagePath,
        androidCropTitle: 'Crop', // use custom localizations for android
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );
      print('success: $success');
    } catch (e) {
      print(e);
    }

    _imagePath = imagePath;
    notifyListeners();
  }

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }
}
