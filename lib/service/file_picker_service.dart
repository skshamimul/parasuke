import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FilePickerService {
 

  Future<File?> pickImage(ImageSource imageSource,
      {CameraDevice cameraDevice = CameraDevice.front}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickImage = await picker.pickImage(
        source: imageSource, preferredCameraDevice: cameraDevice);
    if (pickImage != null) {
      return File(pickImage.path);
    }
    return null;
  }

  Future<File?> cropeImage(
      {required BuildContext context, required File imageFile}) async {
    final ColorScheme theme = Theme.of(context).colorScheme;
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: theme.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    } else {
      return null;
    }
  }
}
