import 'package:pdf/widgets.dart';
import 'package:table_sticky_headers/table_sticky_headers.dart';
import 'package:pdf/pdf.dart';


List<PdfColor> pdfHeaderColor = const [
    PdfColor.fromInt(0xFF2F3E55),
    PdfColor.fromInt(0xFF2F5533),
    PdfColor.fromInt(0xFF58481A),
    PdfColor.fromInt(0xFF48113B),
    PdfColor.fromInt(0xFF722E2E),
    PdfColor.fromInt(0xFF2D5366),
    PdfColor.fromInt(0xFF485A38),
    PdfColor.fromInt(0xFF5F5B01),
    PdfColor.fromInt(0xFF6E1F74),
    PdfColor.fromInt(0xFF8A4622),
    PdfColor.fromInt(0xFF2F3E55),
    PdfColor.fromInt(0xFF2F5533),
    PdfColor.fromInt(0xFF58481A),
    PdfColor.fromInt(0xFF48113B),
    PdfColor.fromInt(0xFF722E2E),
  ];


class PdfTableCellWidget extends StatelessWidget {
  PdfTableCellWidget.content(
    this.text, {

    this.textStyle,
    this.index = 0,
    this.listText,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = PdfColors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = PdfColors.black,
        _colorVerticalBorder = PdfColors.black,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  PdfTableCellWidget.legend(
    this.text, {
   
    this.textStyle,
    this.index = 0,
    this.listText,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = PdfColors.white,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = PdfColors.black,
        _colorVerticalBorder = PdfColors.black,
        _textAlign = TextAlign.center,
        _padding = const EdgeInsets.only(left: 0.0);

  PdfTableCellWidget.stickyRow(
    this.text, {
    
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = PdfColors.blue,
    this.index = 0,
    this.listText,
    this.onTap,
  })  : cellWidth = cellDimensions.contentCellWidth,
        cellHeight = cellDimensions.stickyLegendHeight,
        _colorHorizontalBorder = PdfColors.white,
        _colorVerticalBorder = PdfColors.black,
        _textAlign = TextAlign.center,
        _padding = EdgeInsets.zero;

  PdfTableCellWidget.stickyColumn(
    this.text, {
  
    this.textStyle,
    this.cellDimensions = CellDimensions.base,
    this.colorBg = PdfColors.white,
    this.index = 0,
    this.listText,
    this.onTap,
  })  : cellWidth = cellDimensions.stickyLegendWidth,
        cellHeight = cellDimensions.contentCellHeight,
        _colorHorizontalBorder = PdfColors.black,
        _colorVerticalBorder = PdfColors.black,
        _textAlign = TextAlign.center,
        _padding = const EdgeInsets.only(left: 0.0);

  final CellDimensions cellDimensions;

  final String text;
  final Function()? onTap;

  final double? cellWidth;
  final double? cellHeight;

  final PdfColor colorBg;
  final PdfColor _colorHorizontalBorder;
  final PdfColor _colorVerticalBorder;

  final TextAlign _textAlign;
  final EdgeInsets _padding;

  final TextStyle? textStyle;
  final int index;

  final List<Map<String,dynamic>>? listText;



  @override
  Widget build(Context context) {
    return  Padding(
        padding: colorBg == PdfColors.blue
            ? const EdgeInsets.only(top: 5, bottom: 5)
            : EdgeInsets.zero,
        child: Container(
          width: cellWidth,
          height: cellHeight,
          padding: _padding,
          decoration: colorBg == PdfColors.blue
              ? BoxDecoration(
                  borderRadius: index == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))
                      : null,
                  color: pdfHeaderColor[index])
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
      );
  }
}
