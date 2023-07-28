import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/custom_steper_widget.dart';
import '../login_success_controller.dart';

class FamilyMemberFinishWidget extends ConsumerWidget {
  const FamilyMemberFinishWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(loginSuccessScreenProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const CustomSteperWidget(
            stepOneStatus: StepperState.active,
            stepTwoStatus: StepperState.active,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            '招待メールを送りました\n さんが\n招待を受け入れたら\nカレンダーに表示されます',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Stack(
            children: [
              Image.asset(
                height: 280,
                width: double.infinity,
                'assets/images/step-2.png',
                fit: BoxFit.contain,
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
          AppButtonWidget(
              onPressed: () async {
                model.setWidget(LoginSuccessState.addMember);
              },
              text: 'Continue adding members'),
          const SizedBox(
            height: 5,
          ),
          AppButtonWidget(
              onPressed: () async {
                model.setWidget(LoginSuccessState.finish);
              },
              text: 'Finish adding members'),
        ],
      ),
    );
  }
}
