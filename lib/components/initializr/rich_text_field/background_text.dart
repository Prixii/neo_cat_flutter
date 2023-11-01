import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_field.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class BackgroundText extends SpecialText {
  BackgroundText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback? onTap, {
    required this.type,
    required this.start,
    required this.context,
    this.backgroundColor,
  }) : super(
          flag,
          " ",
          textStyle,
          onTap: onTap,
        );

  static const String flag = "€";

  final Color? backgroundColor;
  final BuildContext context;
  final int start;
  final BuilderType type;

  @override
  InlineSpan finishText() {
    String fullText = " ${toString().substring(1)}";
    final index = fullText.indexOf('£');
    String label = " ";
    if (index != -1) {
      label = " ${fullText.substring(0, index)} ";
      fullText = fullText.substring(index + 1, fullText.length - 1);
    }
    TextStyle textStyle = this.textStyle ?? defaultText;
    var background = getColor(label);
    var backgroundTextSpan = SpecialTextSpan(
      children: [
        TextSpan(
          text: fullText,
          style: calculateTextColor(background).copyWith(
            background: Paint()..color = getColor(label),
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
          recognizer: TapGestureRecognizer()..onTap = () => fullText = "",
        )
      ],
      text: label,
      style: textStyle.copyWith(
        fontSize: 8,
        background: Paint()..color = Colors.grey[20],
      ),
      actualText: label,
      start: start,
      deleteAll: true,
      recognizer: TapGestureRecognizer()..onTap = () => label,
    );
    return backgroundTextSpan;
  }

  Color getColor(LabelName label) {
    var color = relationChartDataBloc(context)
        .state
        .labelMap[label.trim()]
        ?.color
        .toColor();
    return color ?? Colors.blue.withOpacity(0.15);
  }
}
