import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parasuke_app/router/app_route.gr.dart';

import '../../provider.dart';
import '../../provider/base_controller.dart';
import '../../provider/upload_file_provider.dart';
import '../../repository/profile/data/profile_repo.dart';

import '../../repository/profile/data/profiles_repository.dart';
import '../../repository/profile/domain/profile_model.dart';

final ChangeNotifierProvider<FirstSignUpsScreenController>
    firstSignUpsScreenProvider =
    ChangeNotifierProvider<FirstSignUpsScreenController>(
        (ChangeNotifierProviderRef<FirstSignUpsScreenController> ref) {
  return FirstSignUpsScreenController(ref)..init();
});

class FirstSignUpsScreenController extends BaseController {
  final ChangeNotifierProviderRef ref;

  late AuthClient? authClient;

  double _prograss = 0.0;

  FirstSignUpsScreenController(this.ref);
  double get prograss => _prograss;
  bool _isShowPrograss = false;
  bool get isShowPrograss => _isShowPrograss;
  User? _user;

  Future<void> init() async {
    _user = ref.watch(authServiceProvider).currentUser;
    if (_user == null) {
      throw AssertionError("User can't be null");
    }

    authClient = ref.read(authServiceProvider).authClient;
    assert(authClient != null, 'Authenticated client missing!');
  }

  Future<void> pickProfileImage(BuildContext context, Profile profile) async {
    await bottomSheetService.showImagePickerBottomSheet(context,
        onTabGallery: () async {
      await pickImage(context, profile);
      await router.pop();
    }, onTabCamara: () async {
      await pickImage(context, profile, imageSource: ImageSource.camera);
      await router.pop();
    });
  }

  Future<void> pickImage(BuildContext context, Profile profile,
      {ImageSource imageSource = ImageSource.gallery}) async {
    final File? imageFile = await picker.pickImage(imageSource);
    if (imageFile != null) {
      final File? cropeImage =
          await picker.cropeImage(context: context, imageFile: imageFile);
      if (cropeImage != null) {
        log(cropeImage.path, name: 'ImagePath');
        final UploadsRepository uploadModel =
            ref.watch(uploadRepositoryProvider);
        _isShowPrograss = true;
        notifyListeners();
        await uploadModel.uploadProfileImage(
            file: cropeImage,
            onRunning: (double value) {
              _prograss = value;
              notifyListeners();
            },
            onComplete: (String value) async {
              final Profile newProfile = Profile(
                  id: profile.id,
                  uid: profile.uid,
                  name: profile.name,
                  email: profile.email,
                  pictureUrl: value,
                  accessToken: profile.accessToken,
                  isNotNew: profile.isNotNew,
                  created: profile.created,
                  updated: DateTime.now());
              final Map<String, dynamic> data = {
                'pictureUrl': profile.pictureUrl
              };
              await updateProfileUrl(profile.id, data);
              _isShowPrograss = false;
              notifyListeners();
            });
      }
    }
  }

  Future<void> updateProfileUrl(
      String profileId, Map<String, dynamic> data) async {
    final ProfilesRepository profileModel =
        ref.watch(profilesRepositoryProvider);

    await profileModel.updateProfile(
        uid: _user!.uid, profileID: profileId, profile: data);
  }

  Future<void> firstStepComplete(Profile profile) async {
    final ProfilesRepo profileModel =
        ref.watch(profilesRepoProvider);

    await profileModel.updateProfile(
        uid: _user!.uid, profileID: profile.id, profile: {'isNotNew': true});
    await router.pop();
  }

  Future<void> subscribeToCaldender(String calenderId, String summary) async {
    final CalendarApi gCalAPI = CalendarApi(authClient!);
    final Calendar request = Calendar(summary: summary);

    final Calendar result = await gCalAPI.calendars.insert(request);
    log(result.toJson().toString(), name: 'Calendar');
    //await getIt<AppRouter>().replace(const InviteSendRoute());
    if (result.id != null) {
      final AclRule aciRule = await gCalAPI.acl.insert(
          AclRule(
              role: 'writer',
              scope: AclRuleScope(value: calenderId, type: 'user')),
          result.id!);

      await router.popAndPush(
          SetFamilyCompleteRoute(name: summary,));
    }
  }
}
