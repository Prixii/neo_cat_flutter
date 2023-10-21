import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/class_setter.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/class_tile.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import 'rich_text_editing_controller.dart';

Widget elevatedClassMenuBuilder({
  required BuildContext context,
  required ExtendedEditableTextState editableTextState,
  required RichTextEditingController controller,
}) {
  List<ClassData> getClassData() => context
      .read<RelationChartDataBloc>()
      .state
      .relationChartData
      .classDataList;

  return AdaptiveTextSelectionToolbar(
    anchors: editableTextState.contextMenuAnchors,
    children: [
      const ClassSetter(),
      const Divider(),
      SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: getClassData().length,
          itemBuilder: (context, index) => ClassTile(
            className: getClassData()[index].name,
            color: colorFromString(getClassData()[index].color),
            getController: () => controller,
          ),
        ),
      ),
    ],
  );
}
