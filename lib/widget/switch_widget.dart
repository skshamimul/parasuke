import 'package:flutter/material.dart';
import 'package:form_builder_cupertino_fields/form_builder_cupertino_fields.dart';

class FBSwitchWidget extends StatelessWidget {
  const FBSwitchWidget(
      {super.key,
      required this.name,
      required this.hint,
      this.onChanged,
      this.initialValue});

  final String name;
  final String hint;
  final bool? initialValue;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            theme.brightness == Brightness.dark ? Colors.black : Colors.white,
      ),
      child: FormBuilderCupertinoSwitch(
        onChanged: onChanged,
        name: name,
        initialValue: initialValue,
        prefix: Text(hint),
      ),
    );
    // return FormBuilderCupertinoSwitch(
    //   name: name,
    //   title: Text(hint),
    //   onChanged: onChanged,
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor:
    //         theme.brightness == Brightness.dark ? Colors.black : Colors.white,
    //     border: InputBorder.none,
    //     enabledBorder: InputBorder.none,
    //   ),
    // );
  }
}
