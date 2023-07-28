import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider.dart';
import '../../state/auth_state.dart';
import '../error_page/error_page.dart';
import '../family_setting/edit_personal_setting_screen.dart';
import '../home/views/pages/home_page.dart';
import '../loding/loading_screen.dart';
import '../signup/google_signup_screen.dart';

@RoutePage<String>()
class InitalScreen extends ConsumerWidget {
  const InitalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authStateChanges = ref.watch(authStateChangesProvider);
    //  return authStateChanges.when(
    //     data: (user) {
    //       if (user != null) {
    //         return HomeScreen();
    //       } else {
    //         return GoogleSignupScreen();
    //       }
    //     },
    //     loading: () => LoadingScreen(),
    //     error: (error, _) => ErrorPage(
    //       message: error.toString(),
    //     ),
    //   );

    final AuthState state = ref.watch(authStateProvider);
    //return EditPersonalSettingScreen();
    return state.when(
        initializing: () => const GoogleSignupScreen(),
        loading: () => const LoadingScreen(),
        ready: (User user) => const HomeScreen(),
        error: (String error) => ErrorPage(
              message: error,
            ));
  }
}
