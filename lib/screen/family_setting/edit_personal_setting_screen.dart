// ignore_for_file: must_be_immutable, lines_longer_than_80_chars

import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_color.dart';
import '../../core/constants/app_const.dart';
import '../../repository/relation/relation_model.dart';
import '../../router/app_route.dart';
import '../../service/setup_services.dart';
import '../../widget/dropdown_widget.dart';
import '../../widget/text_field_widget.dart';
import 'member_setting_controller.dart';
import 'package:intl/intl.dart';

@RoutePage<String>()
class EditPersonalSettingScreen extends ConsumerWidget {
  final Relation relation;
  EditPersonalSettingScreen({super.key, required this.relation});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(memberSettingProvider);
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? Colors.white : Colors.white,
        noAppBar: true,
        invertStatusIcons: true,
      ),
      child: Scaffold(
        backgroundColor: isLight ? Colors.black : AppColor.bgColor,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 25),
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
                  color: isLight ? AppColor.bgColor : Colors.black,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              getIt<AppRouter>().pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Edit Personal Setting')),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                await model.updateRelation(
                                    _formKey.currentState!.value, relation.id);
                                // debugPrint(
                                //     _formKey.currentState?.value.toString());
                              } else {
                                debugPrint(
                                    _formKey.currentState?.value.toString());
                              }
                            },
                            child: model.isBusy
                                ? CircularProgressIndicator.adaptive()
                                : Text(
                                    'Keep',
                                    style: theme.textTheme.labelLarge!
                                        .copyWith(color: Colors.blue.shade900),
                                  )),
                      ],
                    ),
                    const Divider(),
                    Expanded(
                      child:
                          ListView(padding: const EdgeInsets.all(8), children: [
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TitleWidget(
                                  title: '名前',
                                  alertMsg:
                                      'カレンダー上に表示されるお名前を設定してく\nださい。最大7文字まで入力できます。'),
                              FBTextField(
                                initialValue: relation.name,
                                name: 'name',
                                hintText: 'Enter Name',
                                prefixIcon: Icons.person,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const TitleWidget(
                                  title: '表示',
                                  alertMsg:
                                      'カレンダー上の表示設定です。「予定の有無の\nみ表示」を選択した場合は「予定あり」や\n「Busy」と表示されます。\n\nただし、Google側で権限設定をさている場合\nはGoogle側の設定が優先されます。'),
                              FbDropDownWidget(
                                initialValue: relation.display,
                                name: 'display',
                                hintText: 'Select Display',
                                valueList: AppConst.display,
                                prefixIcon: Icons.sync,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const TitleWidget(
                                  title: '通知',
                                  alertMsg: 'アプリのない方はSMSでの通知が可能です。'),
                              FBTextField(
                                onTap: () async {
                                  await showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return _buildBottomPicker(
                                        CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.date,
                                          onDateTimeChanged: model.setBirthDay,
                                        ),
                                      );
                                    },
                                  );
                                },
                                initialValue: relation.birthday.year == 1970
                                    ? null
                                    : getDateFormate(relation.birthday),
                                name: 'Birthday',
                                hintText: 'Birthday',
                                prefixIcon: Icons.date_range,
                              ),
                              // if (model.isBirthdaySelected)
                              //   SizedBox(
                              //     width: double.maxFinite,
                              //     height: 200,
                              //     child: CupertinoDatePicker(
                              //         initialDateTime: _today,
                              //         onDateTimeChanged: (DateTime date) {
                              //           _today = date;
                              //         }),
                              //   ),
                              const SizedBox(
                                height: 8,
                              ),
                              const TitleWidget(
                                  title: '誕生日', alertMsg: '誕生日の予定がカレンダーに入ります。'),
                              FbDropDownWidget(
                                initialValue: relation.role,
                                name: 'role',
                                hintText: 'Select Role',
                                valueList: AppConst.role,
                                prefixIcon: Icons.sync,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const TitleWidget(
                                  title: '役割',
                                  alertMsg: '役割を活用した改修を検討しています。設定は任意です。'),
                              FbDropDownWidget(
                                initialValue: relation.occupation,
                                name: 'occupation',
                                hintText: 'Occupation',
                                valueList: AppConst.occupation,
                                prefixIcon: Icons.sync,
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  String getDateFormate(DateTime dateTime) {
    String updateDateAt = DateFormat('dd/MM/yy').format(dateTime);

    return '$updateDateAt';
  }
}

class TitleWidget extends StatelessWidget {
  final String title;

  final String alertMsg;
  const TitleWidget({super.key, required this.title, required this.alertMsg});

  Future<void> _openDialog(BuildContext context) async {
    await showDialog<void>(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext context) => _AlertDialogWidget(title, alertMsg));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: _theme.textTheme.labelMedium,
          ),
          IconButton(
              onPressed: () async {
                await _openDialog(context);
              },
              icon: Icon(
                Icons.question_mark,
                size: 12,
              ))
        ],
      ),
    );
  }
}

class _AlertDialogWidget extends StatelessWidget {
  final String title;
  final String msg;

  const _AlertDialogWidget(this.title, this.msg);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text('Close')),
      ],
    );
  }
}
