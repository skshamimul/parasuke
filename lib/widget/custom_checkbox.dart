import 'package:flutter/material.dart';

class CustomCheckBoxWidget extends StatefulWidget {
  final String title;
  final void Function(bool) onChange;
  const CustomCheckBoxWidget(
      {super.key, required this.title, required this.onChange});

  @override
  State<CustomCheckBoxWidget> createState() => _CustomCheckBoxWidgetState();
}

class _CustomCheckBoxWidgetState extends State<CustomCheckBoxWidget> {
  bool _value = false;

  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          _value = !_value;
        });
        widget.onChange(_value);
      },
      title: Text(widget.title),
      trailing: _value
          ? const Icon(
              Icons.check_circle_outline,
              size: 30.0,
              color: Colors.blue,
            )
          : const Icon(
              Icons.check_circle_outline,
              size: 30.0,
              color: Colors.grey,
            ),
    );
  }
}
