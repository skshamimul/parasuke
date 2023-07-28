import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_const.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/app_insets.dart';
import '../../../core/utils/app_scroll_behavior.dart';
import '../../../provider.dart';
import '../../../provider/auth_notifier.dart';
import '../../../router/app_route.dart';
import '../../../router/app_route.gr.dart';
import '../../../screen/about/views/about.dart';
import '../../../screen/settings/controllers/settings.dart';

import '../../../service/setup_services.dart';
import '../controllers/drawer_controller.dart';

/// An AppDrawer widget used on two pages in this demo application.
///
/// The Drawer shows that for example that our ThemeModeSwitch() widget can
/// just be dropped in the drawer to control theme mode from there as well.
class AppDrawer extends ConsumerWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final double drawerWidth =
        theme.drawerTheme.width ?? (theme.useMaterial3 ? 360 : 304);

    final double screenWidth = MediaQuery.of(context).size.width;

    final AuthNotifier model = ref.read(authStateProvider.notifier);
    final modelDrawer = ref.watch(drawerProvider);
    return Drawer(
      width: screenWidth,
      backgroundColor: AppColor.bgColor,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () async => getIt<AppRouter>().pop(),
                child: Container(
                  margin: EdgeInsets.only(top: 35, left: 16, right: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text('閉じる'), Icon(Icons.close)],
                  ),
                ),
              )),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ScrollConfiguration(
              // The menu can scroll, but bounce and glow scroll effects removed.
              behavior: ScrollNoEdgeEffect(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: <Widget>[
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Offline Camara'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>().popAndPush(const OCRRoute());
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Calander Details'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await modelDrawer.navToCalDetails();
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Member Settings'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>()
                            .popAndPush(MemberSettingRoute());
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Print Calendar'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>()
                            .popAndPush(PrintCalendarRoute());
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Settings'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>().popAndPush(SettingRoute());
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Private Privacy'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>().popAndPush(PrivacyRoute());
                      },
                    ),
                  ),

                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Billing Plan'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>()
                            .popAndPush(BullingWidgetRoute());
                      },
                    ),
                  ),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: const Text('Invitation'),
                      trailing: const Icon(AppIcons.menuItemOpen),
                      onTap: () async {
                        await getIt<AppRouter>()
                            .popAndPush(PendingInvitionRoute());
                      },
                    ),
                  ),

                  // ListTile(
                  //   title: const Text('App showcase'),
                  //   trailing: const Icon(AppIcons.menuItemOpen),
                  //   onTap: () async {
                  //     Navigator.pop(context);
                  //     await getIt<AppRouter>().push(const ThemeShowcaseRoute());
                  //   },
                  // ),
                  // ListTile(
                  //   title: const Text('Bottom sheet'),
                  //   trailing: const Icon(AppIcons.menuItemOpen),
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     showBottomSheet<void>(
                  //       context: context,
                  //       builder: (BuildContext context) =>
                  //           const BottomSheetSettings(),
                  //     );
                  //   },
                  // ),

                  // The logout option is only shown if we are logged in.
                  // const Divider(),
                  //const _Header('Settings'),

                  /// const UseMaterial3Switch(),
                  // const UseSubThemesListTile(
                  //   title: Text('Component themes'),
                  // ),
                  // const ThemeModeListTile(title: Text('Theme')),

                  // ListTile(
                  //   title: const Text('Reset settings'),
                  //   onTap: () async {
                  //     final bool? reset = await showDialog<bool?>(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return const ResetSettingsDialog();
                  //       },
                  //     );
                  //     if (reset ?? false) {
                  //       Settings.reset(ref);
                  //     }
                  //   },
                  // ),
                  const Divider(),
                  const _Header('About'),

                  ListTile(
                    title: const Text('About ${AppConst.appName}'),
                    trailing: const Icon(AppIcons.menuItemOpen),
                    onTap: () {
                      Navigator.pop(context);
                      showAppAboutDialog(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    trailing: const Icon(AppIcons.menuItemOpen),
                    onTap: () async {
                      ref
                          .read(Settings.isFireBaseLoginProvider.notifier)
                          .set(false);
                      await model.signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppInsets.l,
        AppInsets.s,
        AppInsets.l,
        AppInsets.xs,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
