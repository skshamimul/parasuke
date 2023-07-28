import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';
import '../../generated/locale_keys.g.dart';
import '../../provider.dart';
import '../../state/auth_state.dart';
import '../../widget/button_widget.dart';
import '../../widget/custom_steper_widget.dart';
import 'sign_up_controller.dart';

@RoutePage<String>()
class GoogleSignupScreen extends ConsumerWidget {
  const GoogleSignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthState state = ref.watch(authStateProvider);
    final SignupsScreenController model =
        ref.read(signupsScreenControllerProvider.notifier);
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? AppColor.bgColor : Colors.black,
        noAppBar: true,
        invertStatusIcons: false,
      ),
      child: Scaffold(
        backgroundColor: isLight ? AppColor.bgColor : Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomSteperWidget(
                stepOneStatus: StepperState.active,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                LocaleKeys.create_calender_create.tr(),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Stack(
                children: [
                  Image.asset(
                    height: 280,
                    width: double.infinity,
                    'assets/images/bgPattern.png',
                    opacity: const AlwaysStoppedAnimation(1.5),
                  ),
                  Image.asset(
                    height: 280,
                    width: 350,
                    'assets/images/calender_img.png',
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    left: 40,
                    bottom: 10,
                    child: Image.asset(
                      height: 250,
                      width: 150,
                      'assets/images/codeIcon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Image.asset(
                    'assets/images/dummyImg.png',
                    height: 280,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.7),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                LocaleKeys.create_calender_your_name.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 45,
              ),
              Text(
                LocaleKeys.create_calender_have_an_acount.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.when(
                    initializing: () => AppButtonWidget(
                      size: const Size(146, 48),
                      text: LocaleKeys.create_calender_have,
                      onPressed: () async {
                        await model.signInWithGoogle();
                      },
                    ),
                    error: (String errorText) => AppButtonWidget(
                      size: const Size(146, 48),
                      text: LocaleKeys.create_calender_have,
                      onPressed: () async {
                        await model.signInWithGoogle();
                      },
                      errorText: errorText,
                    ),
                    loading: () => AppButtonWidget(
                      size: const Size(146, 48),
                      text: LocaleKeys.create_calender_have,
                      isLoading: true,
                      onPressed: () async {
                        await model.signInWithGoogle();
                      },
                    ),
                    ready: (User user) => const AppButtonWidget(
                      size: Size(146, 48),
                      text: LocaleKeys.create_calender_have,
                      onPressed: null,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  AppButtonWidget(
                    size: const Size(146, 48),
                    text: LocaleKeys.create_calender_have,
                    backgroundColor: Colors.white,
                    foregroundColor: theme.colorScheme.primary,
                    onPressed: () async {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
