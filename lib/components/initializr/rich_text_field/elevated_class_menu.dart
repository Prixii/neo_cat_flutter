import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/class_setter.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/class_tile.dart';

import 'rich_text_editing_controller.dart';

Widget elevatedClassMenuBuilder({
  required BuildContext context,
  required ExtendedEditableTextState editableTextState,
  required RichTextEditingController controller,
}) {
  return AdaptiveTextSelectionToolbar(
    anchors: editableTextState.contextMenuAnchors,
    children: [
      const ClassSetter(),
      const Divider(),
      ClassTile(
        className: 'ClassName',
        color: Colors.blue,
        getController: () => controller,
      ),
    ],
  );
}
