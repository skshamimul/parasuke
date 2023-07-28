import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/extensions.dart';
import '../../../provider/base_controller.dart';
import '../../../router/app_route.gr.dart';

final drawerProvider =
    ChangeNotifierProvider.autoDispose<DrawerController>((ref) {
  return DrawerController(ref);
});

class DrawerController extends BaseController {
  DrawerController(this.ref);
  final ChangeNotifierProviderRef ref;

  Future<void> navToCalDetails() async {
    //await router.pop();
    await router.push(
      CalanderDetailsRoute(),
      onFailure: (NavigationFailure failure) => log(failure.toString()),
    );
  }
}
