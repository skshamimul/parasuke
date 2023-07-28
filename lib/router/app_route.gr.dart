// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i33;
import 'package:flutter/cupertino.dart' as _i35;
import 'package:flutter/foundation.dart' as _i38;
import 'package:flutter/material.dart' as _i34;
import 'package:parasuke_app/repository/profile/domain/profile_model.dart'
    as _i36;
import 'package:parasuke_app/repository/relation/relation_model.dart' as _i37;
import 'package:parasuke_app/screen/billing_plan/billing_plan_screen.dart'
    as _i8;
import 'package:parasuke_app/screen/billing_plan/bolling_plan_widget.dart'
    as _i7;
import 'package:parasuke_app/screen/calander_details/calander_details_screen.dart'
    as _i4;
import 'package:parasuke_app/screen/calander_details/widget/add_icon_widget.dart'
    as _i3;
import 'package:parasuke_app/screen/calander_details/widget/add_member_widget.dart'
    as _i1;
import 'package:parasuke_app/screen/calander_details/widget/add_place_widget.dart'
    as _i2;
import 'package:parasuke_app/screen/calender_day/calender_day_screen.dart'
    as _i15;
import 'package:parasuke_app/screen/family_setting/add_family_merber_nomail_screen.dart'
    as _i25;
import 'package:parasuke_app/screen/family_setting/add_family_merber_screen.dart'
    as _i27;
import 'package:parasuke_app/screen/family_setting/edit_personal_setting_screen.dart'
    as _i23;
import 'package:parasuke_app/screen/family_setting/member_setting_details_screen.dart'
    as _i26;
import 'package:parasuke_app/screen/family_setting/member_setting_screen.dart'
    as _i28;
import 'package:parasuke_app/screen/family_setting/set_family_complete_screen.dart'
    as _i24;
import 'package:parasuke_app/screen/family_setting/set_my_family_screen.dart'
    as _i29;
import 'package:parasuke_app/screen/first_signup/add_merber_screen.dart'
    as _i21;
import 'package:parasuke_app/screen/first_signup/first_signup_screen.dart'
    as _i22;
import 'package:parasuke_app/screen/first_signup/invite_send_screen.dart'
    as _i20;
import 'package:parasuke_app/screen/home/views/pages/home_page.dart' as _i6;
import 'package:parasuke_app/screen/inital/initial_screen.dart' as _i30;
import 'package:parasuke_app/screen/invatation/pending_invition_screen.dart'
    as _i12;
import 'package:parasuke_app/screen/login_success/page/login_add_family_merber_nomail_screen.dart'
    as _i11;
import 'package:parasuke_app/screen/login_success/page/login_add_family_merber_screen.dart'
    as _i10;
import 'package:parasuke_app/screen/offline_camara_scanner/ocr_screen.dart'
    as _i16;
import 'package:parasuke_app/screen/offline_camara_scanner/offline_camara_scanner_screen.dart'
    as _i17;
import 'package:parasuke_app/screen/onboard/onboarding_screen.dart' as _i19;
import 'package:parasuke_app/screen/print_calendar/pdf_view_screen.dart'
    as _i31;
import 'package:parasuke_app/screen/print_calendar/print_calendar_screen.dart'
    as _i32;
import 'package:parasuke_app/screen/privacy/privacy_screen.dart' as _i13;
import 'package:parasuke_app/screen/settings/views/screen/setting_screen.dart'
    as _i5;
import 'package:parasuke_app/screen/signup/google_signup_screen.dart' as _i14;
import 'package:parasuke_app/screen/splash/views/splash_screen.dart' as _i9;
import 'package:parasuke_app/screen/theme_showcase/views/pages/theme_showcase_page.dart'
    as _i18;

abstract class $AppRouter extends _i33.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i33.PageFactory> pagesMap = {
    AddMemberWidgetRoute.name: (routeData) {
      final args = routeData.argsAs<AddMemberWidgetRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i1.AddMemberWidgetScreen(
          key: args.key,
          memberList: args.memberList,
        ),
      );
    },
    AddLocationRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i2.AddLocationScreen(),
      );
    },
    AddIconWidgetRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i3.AddIconWidgetScreen(),
      );
    },
    CalanderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CalanderDetailsRouteArgs>(
          orElse: () => const CalanderDetailsRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i4.CalanderDetailsScreen(key: args.key),
      );
    },
    SettingRoute.name: (routeData) {
      final args = routeData.argsAs<SettingRouteArgs>(
          orElse: () => const SettingRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i5.SettingScreen(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    BullingWidgetRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i7.BullingWidgetScreen(),
      );
    },
    BillingplanRoute.name: (routeData) {
      final args = routeData.argsAs<BillingplanRouteArgs>(
          orElse: () => const BillingplanRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i8.BillingplanScreen(key: args.key),
      );
    },
    SplashRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i9.SplashScreen(),
      );
    },
    LoginAddFamilyMemberRoute.name: (routeData) {
      final args = routeData.argsAs<LoginAddFamilyMemberRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i10.LoginAddFamilyMemberScreen(
          key: args.key,
          emailList: args.emailList,
          calendarName: args.calendarName,
        ),
      );
    },
    LoginAddFamilyMemberNomailRoute.name: (routeData) {
      final args = routeData.argsAs<LoginAddFamilyMemberNomailRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i11.LoginAddFamilyMemberNomailScreen(
          args.calendarName,
          key: args.key,
        ),
      );
    },
    PendingInvitionRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i12.PendingInvitionScreen(),
      );
    },
    PrivacyRoute.name: (routeData) {
      final args = routeData.argsAs<PrivacyRouteArgs>(
          orElse: () => const PrivacyRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i13.PrivacyScreen(key: args.key),
      );
    },
    GoogleSignupRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i14.GoogleSignupScreen(),
      );
    },
    CalendarDayRoute.name: (routeData) {
      final args = routeData.argsAs<CalendarDayRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i15.CalendarDayScreen(
          key: args.key,
          date: args.date,
          calenderID: args.calenderID,
          titleColumn: args.titleColumn,
          events: args.events,
        ),
      );
    },
    OCRRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i16.OCRScreen(),
      );
    },
    OfflineCameraScannerRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i17.OfflineCameraScannerScreen(),
      );
    },
    ThemeShowcaseRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i18.ThemeShowcaseScreen(),
      );
    },
    OnboardingRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i19.OnboardingScreen(),
      );
    },
    InviteSendRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i20.InviteSendScreen(),
      );
    },
    AddMemberRoute.name: (routeData) {
      final args = routeData.argsAs<AddMemberRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i21.AddMemberScreen(
          args.calendarName,
          key: args.key,
        ),
      );
    },
    FirstSignupRoute.name: (routeData) {
      final args = routeData.argsAs<FirstSignupRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i22.FirstSignupScreen(
          key: args.key,
          profile: args.profile,
        ),
      );
    },
    EditPersonalSettingRoute.name: (routeData) {
      final args = routeData.argsAs<EditPersonalSettingRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i23.EditPersonalSettingScreen(
          key: args.key,
          relation: args.relation,
        ),
      );
    },
    SetFamilyCompleteRoute.name: (routeData) {
      final args = routeData.argsAs<SetFamilyCompleteRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i24.SetFamilyCompleteScreen(
          args.name,
          key: args.key,
        ),
      );
    },
    AddFamilyMemberNomailRoute.name: (routeData) {
      final args = routeData.argsAs<AddFamilyMemberNomailRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i25.AddFamilyMemberNomailScreen(
          args.calendarName,
          key: args.key,
        ),
      );
    },
    MemberSettingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<MemberSettingDetailsRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i26.MemberSettingDetailsScreen(
          key: args.key,
          relation: args.relation,
        ),
      );
    },
    AddFamilyMemberRoute.name: (routeData) {
      final args = routeData.argsAs<AddFamilyMemberRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i27.AddFamilyMemberScreen(
          key: args.key,
          emailList: args.emailList,
          calendarName: args.calendarName,
        ),
      );
    },
    MemberSettingRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i28.MemberSettingScreen(),
      );
    },
    SetMyFamilyRoute.name: (routeData) {
      final args = routeData.argsAs<SetMyFamilyRouteArgs>(
          orElse: () => const SetMyFamilyRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i29.SetMyFamilyScreen(key: args.key),
      );
    },
    InitalRoute.name: (routeData) {
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: const _i30.InitalScreen(),
      );
    },
    PdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<PdfViewRouteArgs>();
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i31.PdfViewScreen(
          key: args.key,
          listMonth: args.listMonth,
        ),
      );
    },
    PrintCalendarRoute.name: (routeData) {
      final args = routeData.argsAs<PrintCalendarRouteArgs>(
          orElse: () => const PrintCalendarRouteArgs());
      return _i33.AutoRoutePage<String>(
        routeData: routeData,
        child: _i32.PrintCalendarScreen(key: args.key),
      );
    },
  };
}

/// generated route for
/// [_i1.AddMemberWidgetScreen]
class AddMemberWidgetRoute
    extends _i33.PageRouteInfo<AddMemberWidgetRouteArgs> {
  AddMemberWidgetRoute({
    _i34.Key? key,
    required Map<String, String> memberList,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddMemberWidgetRoute.name,
          args: AddMemberWidgetRouteArgs(
            key: key,
            memberList: memberList,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMemberWidgetRoute';

  static const _i33.PageInfo<AddMemberWidgetRouteArgs> page =
      _i33.PageInfo<AddMemberWidgetRouteArgs>(name);
}

class AddMemberWidgetRouteArgs {
  const AddMemberWidgetRouteArgs({
    this.key,
    required this.memberList,
  });

  final _i34.Key? key;

  final Map<String, String> memberList;

  @override
  String toString() {
    return 'AddMemberWidgetRouteArgs{key: $key, memberList: $memberList}';
  }
}

/// generated route for
/// [_i2.AddLocationScreen]
class AddLocationRoute extends _i33.PageRouteInfo<void> {
  const AddLocationRoute({List<_i33.PageRouteInfo>? children})
      : super(
          AddLocationRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddLocationRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddIconWidgetScreen]
class AddIconWidgetRoute extends _i33.PageRouteInfo<void> {
  const AddIconWidgetRoute({List<_i33.PageRouteInfo>? children})
      : super(
          AddIconWidgetRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddIconWidgetRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CalanderDetailsScreen]
class CalanderDetailsRoute
    extends _i33.PageRouteInfo<CalanderDetailsRouteArgs> {
  CalanderDetailsRoute({
    _i35.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          CalanderDetailsRoute.name,
          args: CalanderDetailsRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CalanderDetailsRoute';

  static const _i33.PageInfo<CalanderDetailsRouteArgs> page =
      _i33.PageInfo<CalanderDetailsRouteArgs>(name);
}

class CalanderDetailsRouteArgs {
  const CalanderDetailsRouteArgs({this.key});

  final _i35.Key? key;

  @override
  String toString() {
    return 'CalanderDetailsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.SettingScreen]
class SettingRoute extends _i33.PageRouteInfo<SettingRouteArgs> {
  SettingRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          SettingRoute.name,
          args: SettingRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const _i33.PageInfo<SettingRouteArgs> page =
      _i33.PageInfo<SettingRouteArgs>(name);
}

class SettingRouteArgs {
  const SettingRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'SettingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i33.PageRouteInfo<void> {
  const HomeRoute({List<_i33.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i7.BullingWidgetScreen]
class BullingWidgetRoute extends _i33.PageRouteInfo<void> {
  const BullingWidgetRoute({List<_i33.PageRouteInfo>? children})
      : super(
          BullingWidgetRoute.name,
          initialChildren: children,
        );

  static const String name = 'BullingWidgetRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i8.BillingplanScreen]
class BillingplanRoute extends _i33.PageRouteInfo<BillingplanRouteArgs> {
  BillingplanRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          BillingplanRoute.name,
          args: BillingplanRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'BillingplanRoute';

  static const _i33.PageInfo<BillingplanRouteArgs> page =
      _i33.PageInfo<BillingplanRouteArgs>(name);
}

class BillingplanRouteArgs {
  const BillingplanRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'BillingplanRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i33.PageRouteInfo<void> {
  const SplashRoute({List<_i33.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i10.LoginAddFamilyMemberScreen]
class LoginAddFamilyMemberRoute
    extends _i33.PageRouteInfo<LoginAddFamilyMemberRouteArgs> {
  LoginAddFamilyMemberRoute({
    _i34.Key? key,
    required List<String> emailList,
    required String calendarName,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          LoginAddFamilyMemberRoute.name,
          args: LoginAddFamilyMemberRouteArgs(
            key: key,
            emailList: emailList,
            calendarName: calendarName,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginAddFamilyMemberRoute';

  static const _i33.PageInfo<LoginAddFamilyMemberRouteArgs> page =
      _i33.PageInfo<LoginAddFamilyMemberRouteArgs>(name);
}

class LoginAddFamilyMemberRouteArgs {
  const LoginAddFamilyMemberRouteArgs({
    this.key,
    required this.emailList,
    required this.calendarName,
  });

  final _i34.Key? key;

  final List<String> emailList;

  final String calendarName;

  @override
  String toString() {
    return 'LoginAddFamilyMemberRouteArgs{key: $key, emailList: $emailList, calendarName: $calendarName}';
  }
}

/// generated route for
/// [_i11.LoginAddFamilyMemberNomailScreen]
class LoginAddFamilyMemberNomailRoute
    extends _i33.PageRouteInfo<LoginAddFamilyMemberNomailRouteArgs> {
  LoginAddFamilyMemberNomailRoute({
    required String calendarName,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          LoginAddFamilyMemberNomailRoute.name,
          args: LoginAddFamilyMemberNomailRouteArgs(
            calendarName: calendarName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginAddFamilyMemberNomailRoute';

  static const _i33.PageInfo<LoginAddFamilyMemberNomailRouteArgs> page =
      _i33.PageInfo<LoginAddFamilyMemberNomailRouteArgs>(name);
}

class LoginAddFamilyMemberNomailRouteArgs {
  const LoginAddFamilyMemberNomailRouteArgs({
    required this.calendarName,
    this.key,
  });

  final String calendarName;

  final _i34.Key? key;

  @override
  String toString() {
    return 'LoginAddFamilyMemberNomailRouteArgs{calendarName: $calendarName, key: $key}';
  }
}

/// generated route for
/// [_i12.PendingInvitionScreen]
class PendingInvitionRoute extends _i33.PageRouteInfo<void> {
  const PendingInvitionRoute({List<_i33.PageRouteInfo>? children})
      : super(
          PendingInvitionRoute.name,
          initialChildren: children,
        );

  static const String name = 'PendingInvitionRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i13.PrivacyScreen]
class PrivacyRoute extends _i33.PageRouteInfo<PrivacyRouteArgs> {
  PrivacyRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          PrivacyRoute.name,
          args: PrivacyRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrivacyRoute';

  static const _i33.PageInfo<PrivacyRouteArgs> page =
      _i33.PageInfo<PrivacyRouteArgs>(name);
}

class PrivacyRouteArgs {
  const PrivacyRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'PrivacyRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i14.GoogleSignupScreen]
class GoogleSignupRoute extends _i33.PageRouteInfo<void> {
  const GoogleSignupRoute({List<_i33.PageRouteInfo>? children})
      : super(
          GoogleSignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'GoogleSignupRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i15.CalendarDayScreen]
class CalendarDayRoute extends _i33.PageRouteInfo<CalendarDayRouteArgs> {
  CalendarDayRoute({
    _i34.Key? key,
    required DateTime date,
    required String calenderID,
    required List<String> titleColumn,
    required List<Map<String, dynamic>> events,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          CalendarDayRoute.name,
          args: CalendarDayRouteArgs(
            key: key,
            date: date,
            calenderID: calenderID,
            titleColumn: titleColumn,
            events: events,
          ),
          initialChildren: children,
        );

  static const String name = 'CalendarDayRoute';

  static const _i33.PageInfo<CalendarDayRouteArgs> page =
      _i33.PageInfo<CalendarDayRouteArgs>(name);
}

class CalendarDayRouteArgs {
  const CalendarDayRouteArgs({
    this.key,
    required this.date,
    required this.calenderID,
    required this.titleColumn,
    required this.events,
  });

  final _i34.Key? key;

  final DateTime date;

  final String calenderID;

  final List<String> titleColumn;

  final List<Map<String, dynamic>> events;

  @override
  String toString() {
    return 'CalendarDayRouteArgs{key: $key, date: $date, calenderID: $calenderID, titleColumn: $titleColumn, events: $events}';
  }
}

/// generated route for
/// [_i16.OCRScreen]
class OCRRoute extends _i33.PageRouteInfo<void> {
  const OCRRoute({List<_i33.PageRouteInfo>? children})
      : super(
          OCRRoute.name,
          initialChildren: children,
        );

  static const String name = 'OCRRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i17.OfflineCameraScannerScreen]
class OfflineCameraScannerRoute extends _i33.PageRouteInfo<void> {
  const OfflineCameraScannerRoute({List<_i33.PageRouteInfo>? children})
      : super(
          OfflineCameraScannerRoute.name,
          initialChildren: children,
        );

  static const String name = 'OfflineCameraScannerRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ThemeShowcaseScreen]
class ThemeShowcaseRoute extends _i33.PageRouteInfo<void> {
  const ThemeShowcaseRoute({List<_i33.PageRouteInfo>? children})
      : super(
          ThemeShowcaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'ThemeShowcaseRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i19.OnboardingScreen]
class OnboardingRoute extends _i33.PageRouteInfo<void> {
  const OnboardingRoute({List<_i33.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i20.InviteSendScreen]
class InviteSendRoute extends _i33.PageRouteInfo<void> {
  const InviteSendRoute({List<_i33.PageRouteInfo>? children})
      : super(
          InviteSendRoute.name,
          initialChildren: children,
        );

  static const String name = 'InviteSendRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i21.AddMemberScreen]
class AddMemberRoute extends _i33.PageRouteInfo<AddMemberRouteArgs> {
  AddMemberRoute({
    required String calendarName,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddMemberRoute.name,
          args: AddMemberRouteArgs(
            calendarName: calendarName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddMemberRoute';

  static const _i33.PageInfo<AddMemberRouteArgs> page =
      _i33.PageInfo<AddMemberRouteArgs>(name);
}

class AddMemberRouteArgs {
  const AddMemberRouteArgs({
    required this.calendarName,
    this.key,
  });

  final String calendarName;

  final _i34.Key? key;

  @override
  String toString() {
    return 'AddMemberRouteArgs{calendarName: $calendarName, key: $key}';
  }
}

/// generated route for
/// [_i22.FirstSignupScreen]
class FirstSignupRoute extends _i33.PageRouteInfo<FirstSignupRouteArgs> {
  FirstSignupRoute({
    _i34.Key? key,
    required _i36.Profile profile,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          FirstSignupRoute.name,
          args: FirstSignupRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'FirstSignupRoute';

  static const _i33.PageInfo<FirstSignupRouteArgs> page =
      _i33.PageInfo<FirstSignupRouteArgs>(name);
}

class FirstSignupRouteArgs {
  const FirstSignupRouteArgs({
    this.key,
    required this.profile,
  });

  final _i34.Key? key;

  final _i36.Profile profile;

  @override
  String toString() {
    return 'FirstSignupRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [_i23.EditPersonalSettingScreen]
class EditPersonalSettingRoute
    extends _i33.PageRouteInfo<EditPersonalSettingRouteArgs> {
  EditPersonalSettingRoute({
    _i35.Key? key,
    required _i37.Relation relation,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          EditPersonalSettingRoute.name,
          args: EditPersonalSettingRouteArgs(
            key: key,
            relation: relation,
          ),
          initialChildren: children,
        );

  static const String name = 'EditPersonalSettingRoute';

  static const _i33.PageInfo<EditPersonalSettingRouteArgs> page =
      _i33.PageInfo<EditPersonalSettingRouteArgs>(name);
}

class EditPersonalSettingRouteArgs {
  const EditPersonalSettingRouteArgs({
    this.key,
    required this.relation,
  });

  final _i35.Key? key;

  final _i37.Relation relation;

  @override
  String toString() {
    return 'EditPersonalSettingRouteArgs{key: $key, relation: $relation}';
  }
}

/// generated route for
/// [_i24.SetFamilyCompleteScreen]
class SetFamilyCompleteRoute
    extends _i33.PageRouteInfo<SetFamilyCompleteRouteArgs> {
  SetFamilyCompleteRoute({
    required String name,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          SetFamilyCompleteRoute.name,
          args: SetFamilyCompleteRouteArgs(
            name: name,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'SetFamilyCompleteRoute';

  static const _i33.PageInfo<SetFamilyCompleteRouteArgs> page =
      _i33.PageInfo<SetFamilyCompleteRouteArgs>(name);
}

class SetFamilyCompleteRouteArgs {
  const SetFamilyCompleteRouteArgs({
    required this.name,
    this.key,
  });

  final String name;

  final _i34.Key? key;

  @override
  String toString() {
    return 'SetFamilyCompleteRouteArgs{name: $name, key: $key}';
  }
}

/// generated route for
/// [_i25.AddFamilyMemberNomailScreen]
class AddFamilyMemberNomailRoute
    extends _i33.PageRouteInfo<AddFamilyMemberNomailRouteArgs> {
  AddFamilyMemberNomailRoute({
    required String calendarName,
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddFamilyMemberNomailRoute.name,
          args: AddFamilyMemberNomailRouteArgs(
            calendarName: calendarName,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFamilyMemberNomailRoute';

  static const _i33.PageInfo<AddFamilyMemberNomailRouteArgs> page =
      _i33.PageInfo<AddFamilyMemberNomailRouteArgs>(name);
}

class AddFamilyMemberNomailRouteArgs {
  const AddFamilyMemberNomailRouteArgs({
    required this.calendarName,
    this.key,
  });

  final String calendarName;

  final _i34.Key? key;

  @override
  String toString() {
    return 'AddFamilyMemberNomailRouteArgs{calendarName: $calendarName, key: $key}';
  }
}

/// generated route for
/// [_i26.MemberSettingDetailsScreen]
class MemberSettingDetailsRoute
    extends _i33.PageRouteInfo<MemberSettingDetailsRouteArgs> {
  MemberSettingDetailsRoute({
    _i34.Key? key,
    required _i37.Relation relation,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          MemberSettingDetailsRoute.name,
          args: MemberSettingDetailsRouteArgs(
            key: key,
            relation: relation,
          ),
          initialChildren: children,
        );

  static const String name = 'MemberSettingDetailsRoute';

  static const _i33.PageInfo<MemberSettingDetailsRouteArgs> page =
      _i33.PageInfo<MemberSettingDetailsRouteArgs>(name);
}

class MemberSettingDetailsRouteArgs {
  const MemberSettingDetailsRouteArgs({
    this.key,
    required this.relation,
  });

  final _i34.Key? key;

  final _i37.Relation relation;

  @override
  String toString() {
    return 'MemberSettingDetailsRouteArgs{key: $key, relation: $relation}';
  }
}

/// generated route for
/// [_i27.AddFamilyMemberScreen]
class AddFamilyMemberRoute
    extends _i33.PageRouteInfo<AddFamilyMemberRouteArgs> {
  AddFamilyMemberRoute({
    _i34.Key? key,
    required List<String> emailList,
    required String calendarName,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          AddFamilyMemberRoute.name,
          args: AddFamilyMemberRouteArgs(
            key: key,
            emailList: emailList,
            calendarName: calendarName,
          ),
          initialChildren: children,
        );

  static const String name = 'AddFamilyMemberRoute';

  static const _i33.PageInfo<AddFamilyMemberRouteArgs> page =
      _i33.PageInfo<AddFamilyMemberRouteArgs>(name);
}

class AddFamilyMemberRouteArgs {
  const AddFamilyMemberRouteArgs({
    this.key,
    required this.emailList,
    required this.calendarName,
  });

  final _i34.Key? key;

  final List<String> emailList;

  final String calendarName;

  @override
  String toString() {
    return 'AddFamilyMemberRouteArgs{key: $key, emailList: $emailList, calendarName: $calendarName}';
  }
}

/// generated route for
/// [_i28.MemberSettingScreen]
class MemberSettingRoute extends _i33.PageRouteInfo<void> {
  const MemberSettingRoute({List<_i33.PageRouteInfo>? children})
      : super(
          MemberSettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'MemberSettingRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i29.SetMyFamilyScreen]
class SetMyFamilyRoute extends _i33.PageRouteInfo<SetMyFamilyRouteArgs> {
  SetMyFamilyRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          SetMyFamilyRoute.name,
          args: SetMyFamilyRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SetMyFamilyRoute';

  static const _i33.PageInfo<SetMyFamilyRouteArgs> page =
      _i33.PageInfo<SetMyFamilyRouteArgs>(name);
}

class SetMyFamilyRouteArgs {
  const SetMyFamilyRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'SetMyFamilyRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i30.InitalScreen]
class InitalRoute extends _i33.PageRouteInfo<void> {
  const InitalRoute({List<_i33.PageRouteInfo>? children})
      : super(
          InitalRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitalRoute';

  static const _i33.PageInfo<void> page = _i33.PageInfo<void>(name);
}

/// generated route for
/// [_i31.PdfViewScreen]
class PdfViewRoute extends _i33.PageRouteInfo<PdfViewRouteArgs> {
  PdfViewRoute({
    _i38.Key? key,
    required List<String> listMonth,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          PdfViewRoute.name,
          args: PdfViewRouteArgs(
            key: key,
            listMonth: listMonth,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfViewRoute';

  static const _i33.PageInfo<PdfViewRouteArgs> page =
      _i33.PageInfo<PdfViewRouteArgs>(name);
}

class PdfViewRouteArgs {
  const PdfViewRouteArgs({
    this.key,
    required this.listMonth,
  });

  final _i38.Key? key;

  final List<String> listMonth;

  @override
  String toString() {
    return 'PdfViewRouteArgs{key: $key, listMonth: $listMonth}';
  }
}

/// generated route for
/// [_i32.PrintCalendarScreen]
class PrintCalendarRoute extends _i33.PageRouteInfo<PrintCalendarRouteArgs> {
  PrintCalendarRoute({
    _i34.Key? key,
    List<_i33.PageRouteInfo>? children,
  }) : super(
          PrintCalendarRoute.name,
          args: PrintCalendarRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'PrintCalendarRoute';

  static const _i33.PageInfo<PrintCalendarRouteArgs> page =
      _i33.PageInfo<PrintCalendarRouteArgs>(name);
}

class PrintCalendarRouteArgs {
  const PrintCalendarRouteArgs({this.key});

  final _i34.Key? key;

  @override
  String toString() {
    return 'PrintCalendarRouteArgs{key: $key}';
  }
}
