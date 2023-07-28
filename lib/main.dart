import 'dart:io';

import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/views/parasuke_app.dart';
import 'core/utils/app_provider_observer.dart';
import 'persistence/key_value/models/key_value_db_listener.dart';
import 'persistence/key_value/models/key_value_db_provider.dart';
import 'service/setup_services.dart';
List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
   cameras = await availableCameras();

  // This container can be used to read providers before Flutter app is
  // initialized with UncontrolledProviderScope, for more info see here
  // https://github.com/rrousselGit/riverpod/issues/295 and here
  // https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup
  final ProviderContainer container = ProviderContainer(
    // This observer is used for logging changes in all Riverpod providers.
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  // Get default keyValueDb implementation and initialize it for use.
  await container.read(keyValueDbProvider).init();

  // By reading the keyValueDbListenerProvider, we instantiate it. This sets up
  // a listener that listens to state changes in keyValueDbProvider. In the
  // listener we can swap the keyValueDb implementation used in the app
  // dynamically between: Hive, SharedPreferences and volatile memory.
  container.read(keyValueDbListenerProvider);

  ServiceHook().setup();
    if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: EasyLocalization(
          supportedLocales: const <Locale>[
            Locale('en', 'US'),
            Locale('ja', 'JP'),
          ],
          startLocale: const Locale('ja', 'JP'),
          path: 'resources/langs',
          child: const ParasukeApp()),
    ),
  );
}
