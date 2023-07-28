import 'dart:math';

import 'package:flutter/material.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';

import '../../../../core/constants/app_color.dart';

class TableCellWidget extends StatelessWidget {
  TableCellWidget.content(
    this.text, {
    super.key,
    this.textStyle,
    this.index = 0,
    this.listText,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.black38,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCellWidget.legend(
    this.text, {
    super.key,
    this.textStyle,
    this.index = 0,
    this.listText,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = AppColor.bgColor,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = const EdgeInsets.only(left: 0.0);

  TableCellWidget.stickyRow(
    this.text, {
    super.key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.blue,
    this.index = 0,
    this.listText,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = Colors.white,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  TableCellWidget.stickyColumn(
    this.text, {
    super.key,
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = Colors.white,
    this.index = 0,
    this.listText,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = Colors.black38,
        _colorVerticalBorder = Colors.black38,
        _textAlign = TextAlign.center,
        _padding = const EdgeInsets.only(left: 0.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final Color colorBg;
  final Color _colorHorizontalBorder;
  final Color _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;
  final int index;

  final List<Map<String,dynamic>>? listText;

  int getRandom() {
    final Random random = Random();
    return random.nextInt(10);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: colorBg == Colors.blue
            ? const EdgeInsets.only(top: 5, bottom: 5)
            : EdgeInsets.zero,
        child: Container(
          width: cellWidth,
          height: cellHeight,
          padding: _padding,
          decoration: colorBg == Colors.blue
              ? BoxDecoration(
                  borderRadius: index == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : null,
                  color: AppColor.cHeaderColor[index])
              : BoxDecoration(
                  border: Border(
                    top: BorderSide(color: _colorHorizontalBorder),
                    left: BorderSide(color: _colorHorizontalBorder),
                    right: BorderSide(color: _colorHorizontalBorder),
                  ),
                  color: colorBg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (listText != null)
                ...listText!.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2.0, vertical: 5),
                    child: Text(
                      "${e['summary']}",
                      style: textStyle,
                      maxLines: 1,
                      textAlign: _textAlign,
                    ),
                  ),
                ),
              if (listText == null)
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      text,
                      style: textStyle,
                      maxLines: 10,
                      textAlign: _textAlign,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
