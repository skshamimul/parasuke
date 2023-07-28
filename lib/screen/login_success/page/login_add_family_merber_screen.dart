
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../core/constants/app_color.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../widget/checkbox_group_widget.dart';
import '../../../widget/text_field_widget.dart';
import '../login_success_controller.dart';

@RoutePage<String>()
class LoginAddFamilyMemberScreen extends ConsumerWidget {
  final String calendarName;
  final List<String> emailList;
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  LoginAddFamilyMemberScreen({
    super.key,
    required this.emailList,
    required this.calendarName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final model = ref.watch(loginSuccessScreenProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? Colors.white : Colors.white,
        noAppBar: true,
        invertStatusIcons: false,
      ),
      child: Scaffold(
        backgroundColor: isLight ? Colors.black : Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 200,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(Icons.close_rounded,
                                color: Colors.grey.shade700),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              '$calendarName さんを\n招待しましょう',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Stack(
                              children: [
                                Image.asset(
                                  height: 280,
                                  width: double.infinity,
                                  'assets/images/mv.png',
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
                              height: 8,
                            ),
                            FormBuilder(
                              key: _formKey,
                              child: Column(children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CheckboxGroupWidget(
                                        optionList: emailList,
                                        label: 'Family Member Who have Gmail',
                                        name: 'member',
                                        minSelect: 0,
                                        maxSelect: 10)),
                                Text(
                                  LocaleKeys.invite_screen_gmail_address.tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Card(
                                    color: AppColor.bgColor,
                                    child: FBTextField(
                                      validators: [
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.email(),
                                      ],
                                      controller: _textEditingController,
                                      name: 'email',
                                      hintText: LocaleKeys
                                          .create_calender_enter_name
                                          .tr(),
                                      prefixIcon: Icons.email,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                FilledButton(
                                    style: model.isBusy
                                        ? null
                                        : ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    const Size(230, 48)),
                                          ),
                                    onPressed: model.isBusy
                                        ? null
                                        : () async {
                                            final bool isValid = _formKey
                                                .currentState!
                                                .saveAndValidate();
                                            final bool isMatch =
                                                emailList.contains(
                                                    _textEditingController.text
                                                        .trim());
                                            if (isMatch) {
                                              _formKey
                                                  .currentState?.fields['email']
                                                  ?.invalidate(
                                                      'Email already have');
                                            }

                                            if (isValid &&
                                                !model.isBusy &&
                                                !isMatch) {
                                              final formData =
                                                  _formKey.currentState?.value;
                                              // model.navToFamilyMemberFinish(
                                              //     formData);
                                              // await model.subscribeToCaldender(
                                              //     formData!,
                                              //     calendarName,
                                              //     context);
                                              await model
                                                  .addCalenderForGmailUser(
                                                      formData!, calendarName);
                                            }
                                          },
                                    child: model.isBusy
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            LocaleKeys.invite_screen_invite
                                                .tr(),
                                          )),
                              ]),
                            ),
                            const SizedBox(
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
