import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_const.dart';
import '../../../router/app_route.dart';
import '../../../router/app_route.gr.dart';
import '../../../service/setup_services.dart';
import '../../settings/controllers/settings.dart';

final AutoDisposeChangeNotifierProvider<SplashController> splashController =
    ChangeNotifierProvider.autoDispose<SplashController>(
        (AutoDisposeChangeNotifierProviderRef<SplashController> ref) {
  final bool isOnBoardShow = ref.watch(Settings.isOnboardShowProvider);
  return SplashController()..init(isOnBoardShow);
});

class SplashController extends ChangeNotifier {
  final AppRouter router = getIt<AppRouter>();

  late SharedPreferences sharedPreferences;

  Future<void> init(bool isOnBoardShow) async {
    Timer(const Duration(seconds: 3), () async {
      if (isOnBoardShow) {
        await router.replace(const InitalRoute());
      } else {
        await router.replace(const OnboardingRoute());
      }
    });
  }

  Future<void> setOnboardingComplete() async {
    await sharedPreferences.setBool(AppConst.onboardingCompleteKey, true);
  }
}
