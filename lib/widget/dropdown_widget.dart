import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FbDropDownWidget extends StatelessWidget {
  const FbDropDownWidget(
      {super.key,
      this.prefixIcon,
      required this.name,
      required this.hintText,
      this.initialValue,
      this.onChanged,
      required this.valueList});
  final String name;
  final List<String> valueList;
  final String hintText;
  final IconData? prefixIcon;
  final int?  initialValue;
  final void Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return FormBuilderDropdown<int>(
      initialValue: initialValue,
      name: name,
      icon: const Icon(Icons.unfold_more),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        filled: true,
        fillColor:
            theme.brightness == Brightness.dark ? Colors.black : Colors.white,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      onChanged: onChanged,
      items: valueList
          .mapIndexed(
            (int index, String element) => DropdownMenuItem(
              value: index,
              child: Text(element),
            ),
          )
          .toList(),
    );
  }
}
