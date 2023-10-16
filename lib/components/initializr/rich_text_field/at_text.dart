import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/gestures.dart';

import 'rich_text_field.dart';

class AtText extends SpecialText {
  static const String flag = "@";
  final int start;

  /// whether show background for @somebody
  final bool showAtBackground;

  final BuilderType type;
  AtText(TextStyle textStyle, SpecialTextGestureTapCallback? onTap,
      {this.showAtBackground = false, required this.type, required this.start})
      : super(flag, " ", textStyle, onTap: onTap);

  @override
  TextSpan finishText() {
    TextStyle textStyle =
        this.textStyle!.copyWith(color: Colors.blue, fontSize: 16.0);

    final String atText = toString();

    if (type == BuilderType.extendedText) {
      return TextSpan(
          text: atText,
          style: textStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              if (onTap != null) onTap!(atText);
            });
    }

    return showAtBackground
        ? BackgroundTextSpan(
            background: Paint()..color = Colors.blue.withOpacity(0.15),
            text: atText,
            actualText: atText,
            start: start,
            deleteAll: false,
            style: textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (onTap != null) onTap!(atText);
                  })
                : null)
        : SpecialTextSpan(
            text: atText,
            actualText: atText,
            start: start,
            deleteAll: false,
            style: textStyle,
            recognizer: type == BuilderType.extendedText
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    if (onTap != null) onTap!(atText);
                  })
                : null);
  }
}
