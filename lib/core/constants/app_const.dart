import 'package:flutter/material.dart';

/// App name and info constants.
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  /// Name of the app.
  static const String appName = 'Parasuke';

  /// Current app version.
  static const String version = '0.0.1';

  /// Used version of FlexColorScheme package.
  static const String packageVersion = '6.1.0';

  /// Build with Flutter version.
  static const String flutterVersion = 'Channel stable v3.3.8';

  /// Copyright years notice.
  static const String copyright = '© 2023';

  /// Author info.
  static const String author = 'Eigooo';

  /// License info.
  static const String license = '';

  /// Define device size
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static const String baseUrl = 'https://parasuke.pockethost.io';
  static const String redirectUri = '$baseUrl/redirect.html';
  static const String callbackUrlScheme = 'parasukeauth';
  static const String onboardingCompleteKey = 'onboardingComplete';
  static const INITIAL_API_KEY = 'AIzaSyDIVOgjJ-jvYUxwdMKnHlJuLZszR40qzUo';

  /// Initial value that is used for the locale
  static const INITIAL_LOCALE = Locale('en');
  static const List<String> occupation = [
    'Not Set',
    'housewife',
    'company employee',
    'self employed',
    'part-time job',
    'university student',
    'high school student',
    'Middle school students',
    'Elementary school student',
    'preschooler',
    'others'
  ];
  static const List<String> role = [
    'Not Set',
    'Mother',
    'Father',
    'Child',
    'Grandchild',
    'grandfather',
    'grandmother',
    'lover'
  ];
  static const List<String> display = [
    'Show Event Details',
    'Show only free/busy',
  ];
}
