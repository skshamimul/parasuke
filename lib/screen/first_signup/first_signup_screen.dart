import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widget/custom_stepper.dart';
import '../../repository/profile/domain/profile_model.dart';
import 'first_signup_controller.dart';
import 'widget/step_one_widget.dart';
import 'widget/step_three_widget.dart';
import 'widget/step_two_widget.dart';

@RoutePage<String>()
class FirstSignupScreen extends ConsumerStatefulWidget {
  final Profile profile;
  const FirstSignupScreen({super.key, required this.profile});

  @override
  ConsumerState<FirstSignupScreen> createState() => _FirstSignupScreenState();
}

class _FirstSignupScreenState extends ConsumerState<FirstSignupScreen> {
  int _activeCurrentStep = 0;

  // Here we have created list of steps
  // that are required to complete the form
  List<CustomStep> stepList() => [
        // This is step1 which is called Account.
        // Here we will fill our personal details
        CustomStep(
            state: _activeCurrentStep <= 0
                ? CustomStepState.editing
                : CustomStepState.complete,
            isActive: _activeCurrentStep >= 0,
            title: const Text(
              'STEP1\n利用者設定',
              textAlign: TextAlign.center,
            ),
            content: StepOneWidget(
              profile: widget.profile,
            )),
        // This is Step2 here we will enter our address
        CustomStep(
            state: _activeCurrentStep <= 1
                ? CustomStepState.editing
                : CustomStepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text(
              'STEP2\nメンバー設定',
              textAlign: TextAlign.center,
            ),
            content: const StepTwoWidget()),

        // This is Step3 here we will display all the details
        // that are entered by the user
        CustomStep(
            state: CustomStepState.complete,
            isActive: _activeCurrentStep >= 2,
            title: const Text(
              'STEP3\n利用開始',
              textAlign: TextAlign.center,
            ),
            content: const StepThreeWidget())
      ];

  @override
  Widget build(BuildContext context) {
    final FirstSignUpsScreenController model= ref.watch(firstSignUpsScreenProvider);
    return Scaffold(
      body: SafeArea(
          child: CustomStepper(
        currentStep: _activeCurrentStep,
        elevation: 0,
        steps: stepList(),

        // onStepContinue takes us to the next step
        onStepContinue: () async {
          if (_activeCurrentStep < (stepList().length - 1)) {
            setState(() {
              _activeCurrentStep += 1;
            });
          } else {
         await model.firstStepComplete(widget.profile);
          }
        },

        // onStepCancel takes us to the previous step
        onStepCancel: () {
          if (_activeCurrentStep == 0) {
            return;
          }

          setState(() {
            _activeCurrentStep -= 1;
          });
        },

        // onStepTap allows to directly click on the particular step we want
        onStepTapped: (int index) {
          setState(() {
            _activeCurrentStep = index;
          });
        },
      )),
    );
  }
}
