import 'package:auto_route/annotations.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../core/constants/app_color.dart';
import '../../widget/button_widget.dart';
import '../../widget/text_field_widget.dart';
import 'member_setting_controller.dart';

// ignore: must_be_immutable
@RoutePage<String>()
class SetMyFamilyScreen extends ConsumerWidget {
  SetMyFamilyScreen({super.key});

  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final ColorScheme colors = Theme.of(context).colorScheme;
    final model = ref.watch(memberSettingProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? AppColor.bgColor : Colors.white,
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
                '追加メンバーの\n設定をしましょう',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
              Text(
                'お名前を教えてください',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              FormBuilder(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FBTextField(
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.minLength(4),
                        FormBuilderValidators.maxLength(7),
                      ],
                      controller: _textEditingController,
                      name: 'name',
                      hintText: 'お名前を入力してください',
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Gmailアドレスをお持ちですか？',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: AppButtonWidget(
                              onPressed: () async {
                                bool isValidete =
                                    _formKey.currentState!.saveAndValidate();
                                if (isValidete) {
                                  await model.navToAddMember(
                                      _textEditingController.text);
                                }
                              },
                              text: '持っている')),
                      Expanded(
                          child: AppButtonWidget(
                        onPressed: () async {
                          bool isValidete = _formKey.currentState!.validate();
                          if (isValidete) {
                            await model
                                .navToNomailScreen(_textEditingController.text);
                          }
                        },
                        text: '持っていない',
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      )),
                    ],
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
