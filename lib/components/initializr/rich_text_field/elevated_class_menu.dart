import 'package:extended_text_field/extended_text_field.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/label_setter.dart';
import 'package:neo_cat_flutter/components/initializr/rich_text_field/label_tile.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/utils/bloc_util.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import 'rich_text_editing_controller.dart';

Widget elevatedClassMenuBuilder({
  required BuildContext context,
  required ExtendedEditableTextState editableTextState,
  required RichTextEditingController controller,
}) {
  List<LabelData> getLabelData() =>
      relationChartDataBloc(context).state.labelMap.values.toList();

  return BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
    builder: (context, state) => AdaptiveTextSelectionToolbar(
      anchors: editableTextState.contextMenuAnchors,
      children: [
        LabelSetter(getController: () => controller),
        const Divider(),
        SizedBox(
          height: 200,
          child: ListView.builder(
            itemCount: getLabelData().length,
            itemBuilder: (context, index) => LabelTile(
              labelName: getLabelData()[index].name,
              color: getLabelData()[index].color.toColor(),
              getController: () => controller,
            ),
          ),
        ),
      ],
    ),
  );
}
