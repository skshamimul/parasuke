import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upload_file_provider.g.dart';

class UploadsRepository {
  const UploadsRepository(this._firebaseStorage);
  final FirebaseStorage _firebaseStorage;

  static String profilePath = 'users/profile';

  Future<void> uploadProfileImage({
    required File file,
    required void Function(double) onRunning,
    required void Function(String) onComplete,
  }) async {
    // Create the file metadata
    final SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    // Upload file and metadata to the path 'images/mountains.jpg'
    final UploadTask uploadTask = _firebaseStorage
        .ref()
        .child('$profilePath/${DateTime.now().microsecondsSinceEpoch}.jpg')
        .putFile(file, metadata);
    
    // Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async{
      switch (taskSnapshot.state) {
        case TaskState.running:
          final double progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          onRunning(progress);
          log('Upload is $progress% complete.', name: 'upload pregrass');
          break;
        case TaskState.paused:
          print('Upload is paused.');
          break;
        case TaskState.canceled:
          print('Upload was canceled');
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          final String imageUrl = await taskSnapshot.ref.getDownloadURL();
          onComplete(imageUrl);
          break;
      }
    });
  }
}

@Riverpod(keepAlive: true)
UploadsRepository uploadRepository(UploadRepositoryRef ref) {
  return UploadsRepository(FirebaseStorage.instance);
}
