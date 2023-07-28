import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../login_success_controller.dart';
import '../widget/family_member_finish_widget.dart';
import '../widget/family_member_widget.dart';
import '../widget/login_success_finish_widget.dart';
import '../widget/login_success_widget.dart';

class LoginSuccessScreen extends ConsumerWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;

    final model = ref.watch(loginSuccessScreenProvider);
    return !model.isProfileSetup
        ? Scaffold(
            body: Container(
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          )
        : Scaffold(
            body: SafeArea(child: buildBody(context, model)),
          );
  }

  Widget buildBody(
    BuildContext context,
    LoginSuccessScreenController model,
  ) {
    switch (model.loginSuccessState) {
      case LoginSuccessState.initial:
        return LoginSuccessWidget();
      case LoginSuccessState.addMember:
        return FamilyMemberWidget();
      case LoginSuccessState.addMemberFinish:
        return FamilyMemberFinishWidget();
      case LoginSuccessState.finish:
        return LoginSuccessFinishWidget();
      default:
        return LoginSuccessWidget();
    }
  }
}
