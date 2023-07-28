import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FBTextField extends StatelessWidget {
  const FBTextField(
      {super.key,
      required this.name,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.validators,
      this.onTap,
      this.initialValue,
      this.controller,
      this.onEditingComplete,
      this.onSubmitted,
      this.onSaved,
      this.maxLines = 1,
      this.minLines,
      this.labelText,
      this.keyboardType});

  final String name;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final List<FormFieldValidator<String>>? validators;
  final String? initialValue;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FormBuilderTextField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      onTap: onTap,
      keyboardType: keyboardType,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      onSaved: onSaved,
      readOnly: onTap != null ? true : false,
      initialValue: initialValue,
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        filled: true,
        fillColor:
            theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
      validator: validators != null
          ? FormBuilderValidators.compose(validators!)
          : null,
    );
  }
}
