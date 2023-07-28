// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../router/app_route.dart';
import '../../service/setup_services.dart';
import '../../widget/dropdown_widget.dart';
import '../../widget/switch_widget.dart';
import '../../widget/text_field_widget.dart';
import 'calendar_details_controller.dart';
import 'package:intl/intl.dart';

import 'event_notifier.dart';

@RoutePage<String>()
class CalanderDetailsScreen extends ConsumerWidget {
  CalanderDetailsScreen({super.key});
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _memberTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    final CalanderDetailsController model = ref.watch(calanderDetailsProvider);
    final Size size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    final bool isLight = theme.brightness == Brightness.light;
    _memberTextController.text = model.addMemberFieldText;
    final eventState = ref.watch(eventProvider);
    final eventModel = ref.read(eventProvider.notifier);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavigationBarColor: isLight ? Colors.white : Colors.black,
        noAppBar: true,
        invertStatusIcons: true,
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
                            onPressed: () {},
                            child: const Text('Edit Schedule')),
                        eventState.when(
                            initializing: () => TextButton(
                                onPressed: () async {
                                        if (_formKey.currentState
                                                ?.saveAndValidate() ??
                                            false) {
                                          if (_memberTextController
                                              .text.isEmpty) {
                                            _formKey
                                                .currentState?.fields['member']
                                                ?.invalidate(
                                                    'Select Minimum One Member');
                                          } else {
                                            await eventModel
                                                .addEventIntoCalendar(
                                                    _formKey
                                                        .currentState?.value,
                                                    model.selectedMember,
                                                    model.selectedPlace,
                                                    model.startDateTime,
                                                    model.endDateTime);
                                            // await model.addEventIntoCalendar(
                                            //     _formKey.currentState?.value);
                                          }
                                        } else {
                                          debugPrint(_formKey
                                              .currentState?.value
                                              .toString());
                                        }
                                      },
                                child:  Text(
                                        'Keep',
                                        style: theme.textTheme.labelLarge!
                                            .copyWith(
                                                color: Colors.blue.shade900),
                                      )),
                            loading: () => CircularProgressIndicator(),
                            success: (value) {
                              eventModel.navToPop();

                              return Container();
                            },
                            error: (text) => Text(text))
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 10),
                    Expanded(
                      child:
                          ListView(padding: const EdgeInsets.all(8), children: [
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              FBTextField(
                                controller: model.emoji != null
                                    ? TextEditingController(text: model.emoji)
                                    : null,
                                onTap: () async {
                                  final String? result =
                                      await model.navToAddIcon();
                                  if (result != null) model.setEmogi(result);
                                },
                                name: 'icon',
                                hintText: 'Add Icon',
                                prefixIcon: Icons.mode,
                                suffixIcon: Icons.keyboard_arrow_right,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FBTextField(
                                name: 'title',
                                hintText: 'Enter Tittle',
                                prefixIcon: Icons.calendar_month,
                                validators: [
                                  FormBuilderValidators.required(),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FBTextField(
                                controller: _memberTextController,
                                onTap: () async {
                                  await model.navToAddMember();
                                },
                                name: 'member',
                                hintText: 'add person',
                                labelText: 'add person',
                                prefixIcon: Icons.person,
                                suffixIcon: Icons.keyboard_arrow_right,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: FBTextField(
                                      controller: TextEditingController(
                                          text: getDateFormate(
                                              model.startDateTime)),
                                      onTap: () async {
                                        await showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .dateAndTime,
                                                initialDateTime:
                                                    model.startDateTime,
                                                onDateTimeChanged:
                                                    model.setStartDateTime,
                                                minimumDate:
                                                    model.startDateTime,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      name: 'start',
                                      hintText: 'Start',
                                      labelText: 'Start',
                                      prefixIcon: Icons.date_range,
                                    ),
                                  ),
                                  Expanded(
                                    child: FBTextField(
                                      controller: TextEditingController(
                                          text: getDateFormate(
                                              model.endDateTime)),
                                      onTap: () async {
                                        await showCupertinoModalPopup<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return _buildBottomPicker(
                                              CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .dateAndTime,
                                                initialDateTime:
                                                    model.endDateTime,
                                                onDateTimeChanged:
                                                    model.setEndDateTime,
                                                minimumDate: model.startDateTime
                                                    .add(const Duration(
                                                        minutes: 10)),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      name: 'end',
                                      hintText: 'End',
                                      labelText: 'End',
                                      prefixIcon: Icons.date_range,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FBSwitchWidget(
                                name: 'all_day',
                                hint: 'All Day',
                                onChanged: (value) {},
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const FbDropDownWidget(
                                name: 'repead',
                                hintText: 'Repead',
                                valueList: [
                                  'Every Day',
                                  'Every Week',
                                  'Every Month'
                                ],
                                prefixIcon: Icons.sync,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const FbDropDownWidget(
                                name: 'notification',
                                hintText: 'Notification',
                                valueList: ['Me', 'Husbend', 'Son'],
                                prefixIcon: Icons.notifications,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FBTextField(
                                controller: model.selectedPlace.isNotEmpty
                                    ? TextEditingController(
                                        text: model.selectedPlace)
                                    : null,
                                onTap: () async {
                                  await model.navToAddLocation();
                                },
                                name: 'localtion',
                                hintText: 'Add Localtion',
                                prefixIcon: Icons.location_pin,
                                suffixIcon: Icons.keyboard_arrow_right,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              FBTextField(
                                maxLines: 2,
                                name: 'description',
                                hintText: 'Description',
                                prefixIcon: Icons.description,
                                validators: [
                                  FormBuilderValidators.required(),
                                ],
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

  String getDateFormate(DateTime dateTime) {
    String updateDateAt = DateFormat('dd/MM/yy').format(dateTime);
    String updateTimeAt = DateFormat.jm().format(dateTime);

    return '$updateDateAt $updateTimeAt';
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
}
