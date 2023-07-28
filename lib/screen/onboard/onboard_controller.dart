import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_const.dart';
import '../../provider/base_controller.dart';
import '../../router/app_route.dart';
import '../../router/app_route.gr.dart';
import '../../service/setup_services.dart';
import '../settings/controllers/settings.dart';

final AutoDisposeChangeNotifierProvider<OnboardController> onboardingProvider =
    ChangeNotifierProvider.autoDispose<OnboardController>(
        (AutoDisposeChangeNotifierProviderRef<OnboardController> ref) {
  return OnboardController(ref);
});

class OnboardController extends BaseController {
  final AutoDisposeChangeNotifierProviderRef ref;
  OnboardController(this.ref);

  final AppRouter router = getIt<AppRouter>();

  Future<void> setOnboardingComplete() async {
    ref.read(Settings.isOnboardShowProvider.notifier).set(true);
    await router.replace(const InitalRoute());
  }
}
