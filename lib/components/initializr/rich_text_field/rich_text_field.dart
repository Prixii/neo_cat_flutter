import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart'
    show Material, InputDecoration, UnderlineInputBorder;
import 'package:neo_cat_flutter/components/initializr/rich_text_field/background_text.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/rich_text_editing_controller.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';

import 'elevated_class_menu.dart';

/// @author wang.jiaqi
/// @date 2023-10-16 22

Widget richTextFieldBuilder(
    {required RichTextEditingController controller,
    required BuildContext context}) {
  bool isAnyTextSelected() =>
      controller.selection.textInside(controller.value.text).isNotEmpty;

  return Material(
    child: ExtendedTextField(
      controller: controller,
      extendedContextMenuBuilder: (context, editableTextState) =>
          isAnyTextSelected()
              ? elevatedClassMenuBuilder(
                  context: context,
                  editableTextState: editableTextState,
                  controller: controller,
                )
              : Container(),
      maxLines: null,
      minLines: 6,
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      specialTextSpanBuilder: MySpecialTextSpanBuilder(
        context: context,
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
  final BuildContext context;
  MySpecialTextSpanBuilder(
      {this.showAtBackground = true,
      this.type = BuilderType.extendedText,
      required this.context});
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
    return textSpan;
  }

  @override
  SpecialText? createSpecialText(
    String flag, {
    TextStyle? textStyle,
    SpecialTextGestureTapCallback? onTap,
    required int index,
  }) {
    if (flag == "") return null;

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, BackgroundText.flag)) {
      return BackgroundText(
        textStyle ?? defaultTextBlack,
        context: context,
        (parameter) {},
        type: type,
        start: index - (BackgroundText.flag.length - 1),
      );
    }
    return null;
  }
}

enum BuilderType { extendedText, extendedTextField }
