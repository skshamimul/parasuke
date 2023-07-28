import 'package:flutter/material.dart';

class DropDownButtonFormFieldWidget extends StatefulWidget {
  final String label;
  final String selectedItem;
  final List<String> itemList;
  final bool explainUsage;
  const DropDownButtonFormFieldWidget(
      {super.key,
      required this.selectedItem,
      required this.itemList,
      this.label = '',
      this.explainUsage = false});

  @override
  State<DropDownButtonFormFieldWidget> createState() =>
      _DropDownButtonFormFieldState();
}

class _DropDownButtonFormFieldState
    extends State<DropDownButtonFormFieldWidget> {
  late String selectedItem;
  late List<String> itemList;

  @override
  void initState() {
    selectedItem = widget.selectedItem;
    itemList = widget.itemList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle denseHeader = theme.textTheme.titleMedium!.copyWith(
      fontSize: 13,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.explainUsage)
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              widget.label,
              style: denseHeader,
            ),
          ),
        DropdownButtonFormField<String>(
          value: selectedItem,
          onChanged: (String? value) {
            setState(() {
              selectedItem = value ?? itemList[0];
            });
          },
          items: itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
