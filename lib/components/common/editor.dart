import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/components/common/property_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import 'package:neo_cat_flutter/utils/painter_util.dart';

import '../../types/graph_edge.dart';
import '../../utils/bloc_util.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 11

final emptyView = Center(
  child: Text(
    '空空如也呢',
    style: defaultTextBlack,
  ),
);

class TripletEditor extends StatefulWidget {
  const TripletEditor({super.key});

  @override
  State<TripletEditor> createState() => _TripletEditorState();
}

class _TripletEditorState extends State<TripletEditor> {
  GraphNode? _getSourceNode() {
    GraphNode? startNode = tripletEditorBloc(context).state.startNode;
    if (startNode != null) {
      return startNode;
    }
    return null;
  }

  GraphNode? _getEndNode() {
    GraphNode? endNode = tripletEditorBloc(context).state.endNode;
    if (endNode != null) {
      return endNode;
    }
    return null;
  }

  GraphEdge? _getEdge() {
    GraphEdge? edge = tripletEditorBloc(context).state.edge;
    if (edge != null) {
      return edge;
    }
    return null;
  }

  Widget _tripletEditorBuilder() {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => tripletEditorBloc(context)
                    .add(ClickTripletNode(TripletPosition.start)),
                onSecondaryTap: () => tripletEditorBloc(context)
                    .add(RemoveNode(position: TripletPosition.start)),
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: CirclePainter(),
                        );
                      },
                    ),
                    Center(
                      child: Text(
                        _getSourceNode()?.name ?? '待选择',
                        style: defaultText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomPaint(
                        size: Size(constraints.maxWidth, constraints.maxHeight),
                        painter: ArrowPainter(),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            _getEdge()?.type ?? '待选择',
                            style: defaultTextBlack,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => tripletEditorBloc(context)
                    .add(ClickTripletNode(TripletPosition.end)),
                onSecondaryTap: () => tripletEditorBloc(context)
                    .add(RemoveNode(position: TripletPosition.end)),
                child: Stack(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return CustomPaint(
                          size:
                              Size(constraints.maxWidth, constraints.maxHeight),
                          painter: CirclePainter(),
                        );
                      },
                    ),
                    Center(
                      child: Text(
                        _getEndNode()?.name ?? '待选择',
                        style: defaultText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _propertiesListBuiler() {
    GraphNode? showNode() => tripletEditorBloc(context).state.showNode;
    LabelData? labelData() =>
        relationChartDataBloc(context).state.labelMap[showNode()?.label];
    return (showNode() == null)
        ? emptyView
        : Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            child: Column(
              children: [
                PropertyTile(
                    propertyName: 'name', propertyValue: showNode()!.name),
                _labelSetterBuilder(showNode()!.label),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: labelData()?.properties.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return PropertyTile(
                        propertyName: labelData()!.properties[index],
                        propertyValue: showNode()!
                            .properties?[labelData()!.properties[index]],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget _confirmButtonBuilder() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Button(
          child: Center(
            child: Text(
              'confirm',
              style: defaultTextBlack,
            ),
          ),
          onPressed: () => {
            // TODO 提交实现
          },
        ),
      ),
    );
  }

  Widget _labelSetterBuilder(String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                'Label',
                textAlign: TextAlign.center,
                style: defaultTextBlack,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: AutoSuggestBox(
                placeholder: label,
                items: _itemGenerator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<AutoSuggestBoxItem> _itemGenerator() {
    var list = <AutoSuggestBoxItem>[];
    for (var labelEntry
        in relationChartDataBloc(context).state.labelMap.entries) {
      list.add(
          AutoSuggestBoxItem(value: labelEntry.value, label: labelEntry.key));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripletEditorBloc, TripletEditorState>(
      builder: (context, state) => Column(
        children: [
          _tripletEditorBuilder(),
          const Divider(),
          Expanded(
            child: Container(
              decoration: normalBoxDecoration,
              child: _propertiesListBuiler(),
            ),
          ),
          _confirmButtonBuilder(),
        ],
      ),
    );
  }
}
