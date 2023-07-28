import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/custom_steper_widget.dart';
import '../../settings/controllers/settings.dart';
import '../login_success_controller.dart';

class LoginSuccessWidget extends ConsumerWidget {
  const LoginSuccessWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final model = ref.watch(loginSuccessScreenProvider);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomSteperWidget(
            stepOneStatus: StepperState.active,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'パラスケカレンダーを\n作成しました',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
            height: 16,
          ),
          AppButtonWidget(
            size: const Size(246, 48),
            text: 'メンバーを設定する',
            onPressed: () async {
              model.setWidget(LoginSuccessState.addMember);
            },
          ),
          const SizedBox(
            height: 25,
          ),
          TextButton(
              onPressed: () {
                ref.read(Settings.setMemberScreenProvider.notifier).set(false);
              },
              child: Text(
                'あとで設定する',
                style: theme.textTheme.labelLarge!.copyWith(
                    color: theme.colorScheme.primary,
                    decoration: TextDecoration.underline),
              ))
        ],
      ),
    );
  }
}
