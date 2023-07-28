import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class CheckboxGroupWidget extends StatelessWidget {
  const CheckboxGroupWidget(
      {super.key,
      this.validators,
      required this.optionList,
      required this.label,
      required this.name,
      this.onChanged,
      required this.minSelect,
      required this.maxSelect});
  final List<FormFieldValidator<String>>? validators;
  final List<String> optionList;
  final String label;
  final String name;
  final void Function(List<String>?)? onChanged;
  final int minSelect;
  final int maxSelect;

  @override
  Widget build(BuildContext context) {
    final bool isLignt = Theme.of(context).brightness == Brightness.light;
    return FormBuilderCheckboxGroup<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: label,
          fillColor: isLignt ? Colors.white : Colors.grey),
      name: name,
      initialValue: optionList,
      options: optionList.map((e) => FormBuilderFieldOption(value: e)).toList(),
      onChanged: onChanged,
      orientation: OptionsOrientation.vertical,
      separator: const VerticalDivider(
        width: 10,
        thickness: 5,
        color: Colors.red,
      ),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.maxLength(maxSelect),
      ]),
    );
  }
}
