import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_field.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

class BackgroundText extends SpecialText {
  static const String flag = "€";
  final BuilderType type;
  final int start;
  final Color? backgroundColor;

  BackgroundText(
    TextStyle textStyle,
    SpecialTextGestureTapCallback? onTap, {
    required this.type,
    required this.start,
    this.backgroundColor,
  }) : super(
          flag,
          " ",
          textStyle,
          onTap: onTap,
        );

  @override
  InlineSpan finishText() {
    String fullText = " ${toString().substring(1)}";
    final index = fullText.indexOf('£');
    String color = " ";
    if (index != -1) {
      color = " ${fullText.substring(0, index)} ";
      fullText = fullText.substring(index + 1, fullText.length - 1);
    }
    TextStyle textStyle = this.textStyle ?? defaultText;
    var backgroundTextSpan = SpecialTextSpan(
      children: [
        TextSpan(
          text: fullText,
          style: textStyle.copyWith(
            background: Paint()
              ..color = colorChooser[color.trim()]!.withOpacity(0.15),
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => logger.d('[tapped] Background Text Span!'),
        )
      ],
      text: color,
      style: textStyle.copyWith(
          fontSize: 8, background: Paint()..color = Colors.transparent),
      actualText: color,
      start: start,
      deleteAll: true,
      recognizer: TapGestureRecognizer()
        ..onTap = () => logger.d('[tapped]:$color'),
    );
    return backgroundTextSpan;
  }
}

final colorChooser = {'red': Colors.red, 'blue': Colors.blue};
