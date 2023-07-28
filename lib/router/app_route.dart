import 'package:auto_route/auto_route.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.custom(
        reverseDurationInMilliseconds: 800,
        transitionsBuilder: (BuildContext ctx, Animation<double> animation1,
            Animation<double> animation2, Widget child) {
          // print('Anim1 ${animation1.value}');

          return child;
        },
      );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: '/',
        ),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: InitalRoute.page),
        AutoRoute(page: ThemeShowcaseRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: GoogleSignupRoute.page),
        AutoRoute(page: FirstSignupRoute.page),
        AutoRoute(page: AddMemberRoute.page),
        AutoRoute(page: InviteSendRoute.page),
        AutoRoute(page: OfflineCameraScannerRoute.page),
        AutoRoute(page: CalendarDayRoute.page),
        AutoRoute(page: OCRRoute.page),
        AutoRoute(page: CalanderDetailsRoute.page),
        AutoRoute(page: AddIconWidgetRoute.page),
        AutoRoute(page: AddMemberWidgetRoute.page),
        AutoRoute(page: AddLocationRoute.page),
        AutoRoute(page: MemberSettingRoute.page),
        AutoRoute(page: MemberSettingDetailsRoute.page),
        AutoRoute(page: EditPersonalSettingRoute.page),
        AutoRoute(page: PrintCalendarRoute.page),
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: PrivacyRoute.page),
        AutoRoute(page: BillingplanRoute.page),
        AutoRoute(page: SetMyFamilyRoute.page),
        AutoRoute(page: SetFamilyCompleteRoute.page),
        AutoRoute(page: AddFamilyMemberRoute.page),
        AutoRoute(page: AddFamilyMemberNomailRoute.page),
        AutoRoute(page: LoginAddFamilyMemberRoute.page),
        AutoRoute(page: PendingInvitionRoute.page),
        AutoRoute(page: BullingWidgetRoute.page),
        AutoRoute(page: PdfViewRoute.page)
      ];
}
