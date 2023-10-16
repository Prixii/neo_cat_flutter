import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:neo_cat_flutter/components/initializr/rich_text_field/at_text.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_editing_controller.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

/// @author wang.jiaqi
/// @date 2023-10-16 22

Widget richTextFieldBuilder({required RichTextEditingController controller}) {
  return material.Material(
    child: ExtendedTextField(
      controller: controller,
      maxLines: null,
      decoration: const material.InputDecoration(
        focusedBorder: material.UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: material.UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusColor: opacity,
      ),
      specialTextSpanBuilder: MySpecialTextSpanBuilder(
        showAtBackground: true,
        type: BuilderType.extendedTextField,
      ),
    ),
  );
}

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  /// whether show background for @somebody
  final bool showAtBackground;
  final BuilderType type;
  MySpecialTextSpanBuilder(
      {this.showAtBackground = false, this.type = BuilderType.extendedText});
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      required int index}) {
    if (flag == "") return null;

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, AtText.flag)) {
      return AtText(textStyle ?? defaultText, onTap,
          start: index - (AtText.flag.length - 1),
          showAtBackground: showAtBackground,
          type: type);
    }
    return null;
  }
}

enum BuilderType { extendedText, extendedTextField }
