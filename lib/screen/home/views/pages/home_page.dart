import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_insets.dart';
import '../../../../core/views/widgets/universal/page_body.dart';
import '../../../../router/app_route.dart';
import '../../../../router/app_route.gr.dart';
import '../../../../service/setup_services.dart';
import '../../../../widget/drawer/views/app_drawer.dart';
import '../../../login_success/page/login_success_screen.dart';
import '../../../settings/controllers/settings.dart';
import '../../controllers/home_controller.dart';
import '../widgets/home_calendar_widget.dart';

/// Home page showing with a simple Riverpod count and theme controls.
///
/// Also displays the active
@RoutePage<String>()
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  static const String route = '/home';

  @override
  ConsumerState<HomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends ConsumerState<HomeScreen> {
  late final ScrollController scrollController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      keepScrollOffset: true,
      debugLabel: 'pageBodyScroll',
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle medium = textTheme.headlineMedium!;

    final MediaQueryData media = MediaQuery.of(context);
    final double topPadding = media.padding.top + kToolbarHeight + AppInsets.m;
    final double bottomPadding =
        media.padding.bottom + kBottomNavigationBarHeight;

    final bool isNarrow = media.size.width < AppInsets.phoneWidthBreakpoint;
    final double sideMargin = isNarrow ? 0 : AppInsets.l;
    final HomeScreenController model = ref.watch(homeScreenProvider);
    final bool isMemberSetup = ref.watch(Settings.setMemberScreenProvider);
    final isProfileSetup = ref.watch(Settings.setAddProfileProvider);
    return isMemberSetup
        ? const LoginSuccessScreen()
        : Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            extendBody: true,
            //backgroundColor: theme.appBarTheme.backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(DateFormat.yMMM().format(DateTime.now())),
              actions: <Widget>[
                IconButton(
                    onPressed: () async {
                      await getIt<AppRouter>().push(const OCRRoute());
                    },
                    icon: const Icon(Icons.photo_camera_outlined)),
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu))
              ],
            ),
            drawer: const AppDrawer(),
            // This annotated region will change the Android system navigation bar to
            // a theme color, matching active theme mode and FlexColorScheme theme.
            body: !isProfileSetup
                ? const Center(child: CircularProgressIndicator())
                : AnnotatedRegion<SystemUiOverlayStyle>(
                    value: FlexColorScheme.themedSystemNavigationBar(context),
                    child: SafeArea(
                      // left: false,
                      // right: false,
                      child: PageBody(
                        controller: scrollController,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: theme.appBarTheme.backgroundColor),
                            child: HomeCalendarWidget()),
                      ),
                    ),
                  ));
  }
}
