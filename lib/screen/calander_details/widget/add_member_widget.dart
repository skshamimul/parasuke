import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../router/app_route.dart';
import '../../../service/setup_services.dart';
import '../calendar_details_controller.dart';

@RoutePage<String>()
class AddMemberWidgetScreen extends ConsumerStatefulWidget {
  final Map<String, String> memberList;
  const AddMemberWidgetScreen({super.key, required this.memberList});

  @override
  ConsumerState<AddMemberWidgetScreen> createState() =>
      _AddMemberWidgetScreenState();
}

class _AddMemberWidgetScreenState extends ConsumerState<AddMemberWidgetScreen> {
  List<String> selectedMembers = [];
  final _formKey = GlobalKey<FormBuilderState>();
  final List<FormBuilderFieldOption<String>> listOption = [];
  final List<String> _initialValue = [];

  @override
  void initState() {
    widget.memberList.forEach((k, v) {
      //  _initialValue.add(k);
      listOption.add(FormBuilderFieldOption(
        value: k,
        child: Text(v),
      ));
    });
    //selectedMembers.addAll(_initialValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isLight = theme.brightness == Brightness.light;
    final CalanderDetailsController model = ref.watch(calanderDetailsProvider);
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              getIt<AppRouter>().pop();
                            },
                            child: const Text('Cancel')),
                        TextButton(
                            onPressed: () {}, child: const Text('Edit Icon')),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                await model.setMemberList(selectedMembers);

                                debugPrint(
                                    _formKey.currentState?.value.toString());
                              } else {
                                debugPrint(
                                    _formKey.currentState?.value.toString());
                                debugPrint('validation failed');
                              }
                            },
                            child: Text(
                              'Keep',
                              style: theme.textTheme.labelLarge!
                                  .copyWith(color: Colors.blue.shade900),
                            )),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    FormBuilder(
                      key: _formKey,
                      child: FormBuilderCheckboxGroup<String>(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        name: 'member',
                        orientation: OptionsOrientation.vertical,
                        wrapDirection: Axis.horizontal,
                        separator: const Divider(),
                        initialValue: _initialValue,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        options: listOption,
                        onChanged: (value) {
                          selectedMembers.clear();
                          if (value != null) {
                            selectedMembers.addAll(value);

                            setState(() {});
                          }
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(1),
                          FormBuilderValidators.maxLength(10),
                        ]),
                      ),
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
}
