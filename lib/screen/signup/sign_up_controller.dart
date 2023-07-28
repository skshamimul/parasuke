import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../provider.dart';
import '../../provider/auth_notifier.dart';
import '../../repository/profile/data/profile_repo.dart';
import '../../repository/profile/domain/profile_model.dart';
import '../settings/controllers/settings.dart';

part 'sign_up_controller.g.dart';

@riverpod
class SignupsScreenController extends _$SignupsScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  Future<bool> signInWithGoogle() async {
    // final currentUser = ref.read(authServiceProvider).currentUser;
    // if (currentUser == null) {
    //   throw AssertionError('User can\'t be null');
    // }
    // set loading state

    state = const AsyncLoading().copyWithPrevious(state);
    final AuthNotifier authrepository = ref.read(authStateProvider.notifier);
    final Profile? profile = await authrepository.signInWithGoogle();
    if (profile != null) {
      // check if name is already in use
      final ProfilesRepo repository = ref.read(profilesRepoProvider);

      state = await AsyncValue.guard(() async {
        await repository
            .addProfile(
                uid: profile.id,
                name: profile.name,
                pictureUrl: profile.pictureUrl,
                accessToken: profile.accessToken,
                email: profile.email)
            .then((value) {
          ref.read(Settings.setAddProfileProvider.notifier).set(true);
        });
        ref.read(Settings.isFireBaseLoginProvider.notifier).set(true);
        ref.read(Settings.setMemberScreenProvider.notifier).set(true);
      });
    }

    return state.hasError == false;
  }
}
