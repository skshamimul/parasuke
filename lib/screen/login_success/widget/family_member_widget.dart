import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../widget/button_widget.dart';
import '../../../widget/custom_steper_widget.dart';
import '../../../widget/text_field_widget.dart';
import '../login_success_controller.dart';

class FamilyMemberWidget extends ConsumerStatefulWidget {
  FamilyMemberWidget({super.key});

  @override
  ConsumerState<FamilyMemberWidget> createState() => _FamilyMemberWidgetState();
}

class _FamilyMemberWidgetState extends ConsumerState<FamilyMemberWidget> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _nameHasError = false;
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(loginSuccessScreenProvider);
    final theme = Theme.of(context);
    return ListView(
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
        Text(
          '追加メンバーの\n設定をしましょう',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FormBuilderTextField(
              controller: _textEditingController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              name: 'name',
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.brightness == Brightness.dark
                    ? Colors.black
                    : Colors.white,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: 'お名前を入力してください',
                prefixIcon: Icon(Icons.person),
                suffixIcon: _nameHasError
                    ? const Icon(Icons.error, color: Colors.red)
                    : const Icon(Icons.check, color: Colors.green),
              ),
              onChanged: (val) {
                setState(() {
                  _nameHasError =
                      !(_formKey.currentState?.fields['name']?.validate() ??
                          false);
                });
              },
              // valueTransformer: (text) => num.tryParse(text),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(4),
                FormBuilderValidators.minLength(7),
              ]),
              // initialValue: '12',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
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
                    onPressed: () {
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        model.navToAddMember(_textEditingController.text);

                        debugPrint(_formKey.currentState?.value.toString());
                      } else {
                        debugPrint(_formKey.currentState?.value.toString());
                        debugPrint('validation failed');
                      }
                    },
                    text: '持っている')),
            Expanded(
                child: AppButtonWidget(
              onPressed: () async {
                bool isValidete = _formKey.currentState!.validate();

                // model.setWidget(LoginSuccessState.addMemberFinish);
              },
              text: '持っていない',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            )),
          ],
        ),
      ],
    );
  }
}
