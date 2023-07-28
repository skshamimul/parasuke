import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final Size? size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final void Function()? onPressed;
  final bool isLoading;
  final String text;
  final String? errorText;
  const AppButtonWidget(
      {super.key,
      this.size,
      this.backgroundColor,
      this.foregroundColor,
      this.elevation = 8,
      this.isLoading = false,
      this.onPressed,
      required this.text,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FilledButton(
            style: FilledButton.styleFrom(
                minimumSize: isLoading ? null : size,
                maximumSize: isLoading ? null : size,
                backgroundColor: backgroundColor ?? colors.primary,
                foregroundColor: foregroundColor ?? Colors.white,
                elevation: elevation),
            onPressed: isLoading ? null : onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: colors.primary,
                      ),
                    )
                  : Text(
                      text.tr(),
                      textAlign: TextAlign.center,
                    ),
            )),
        if (errorText != null) ...[
          Text(
            '$errorText',
            style: TextStyle(fontWeight: FontWeight.bold, color: colors.error),
          )
        ]
      ],
    );
  }
}
