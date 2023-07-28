import 'package:flutter/material.dart';


class BottomSheetService {
  Future<void> showImagePickerBottomSheet(
    BuildContext context,
      {required Function()? onTabGallery,
      required Function()? onTabCamara}) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: onTabGallery),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: onTabCamara,
                ),
              ],
            ),
          );
        });
  }
}
