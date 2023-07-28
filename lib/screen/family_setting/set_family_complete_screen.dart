import 'package:auto_route/annotations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/constants/app_color.dart';

import '../../widget/button_widget.dart';

import 'family_setup_notifier.dart';


// ignore: must_be_immutable
@RoutePage<String>()
class SetFamilyCompleteScreen extends ConsumerWidget {
  final String name;

  SetFamilyCompleteScreen(this.name, {super.key});

  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final ColorScheme colors = Theme.of(context).colorScheme;
   
    final model = ref.read(familySetupProvider.notifier);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? AppColor.bgColor : Colors.black,
        noAppBar: true,
        invertStatusIcons: false,
      ),
      child: Scaffold(
        backgroundColor: isLight ? AppColor.bgColor : Colors.black,
        appBar: AppBar(
          title: Text(
            'メンバー追加設定',
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                '招待メールを送りました\n $name さんが\n招待を受け入れたら\nカレンダーに表示されます',
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
                    if (context.mounted) {
                      await model.repalceToSetMyFamily();
                    }
                  },
                  text: 'Continue adding members'),
              const SizedBox(
                height: 5,
              ),
              AppButtonWidget(
                  onPressed: () async {
                    if (context.mounted) {
                      await model.navToPop();
                    }
                  },
                  text: 'Finish adding members'),
            ],
          ),
        ),
      ),
    );
  }
}
