import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/components/common/property_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';
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
  List<String>? properties = [];
  Map<String, dynamic> nodeProperties = {};
  GraphNode? _getSourceNode() {
    GraphNode? startNode = tripletEditorBloc(context).state.sourceNode;
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

  Widget _innerPropertiesListBuiler(
      List<String> properties, Map<String, dynamic> nodeProperties) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      child: ListView.builder(
        itemCount: properties.length,
        itemBuilder: (BuildContext context, int index) {
          return PropertyTile(
            propertyName: properties[index],
            propertyValue: nodeProperties[properties[index]],
          );
        },
      ),
    );
  }

  Widget _propertiesListBuilder() {
    switch (tripletEditorBloc(context).state.viewMode) {
      case TripletPosition.start:
        {
          if (_getSourceNode() != null) {
            var node = _getSourceNode()!;
            var labelData =
                relationChartDataBloc(context).state.labelMap[node.label];
            List<String> properties = labelData?.properties ?? [];
            Map<String, dynamic> nodeProperties = node.properties ?? {};
            return _innerPropertiesListBuiler(properties, nodeProperties);
          }
          break;
        }
      case TripletPosition.end:
        {
          if (_getEndNode() != null) {
            var node = _getEndNode()!;
            var labelData =
                relationChartDataBloc(context).state.labelMap[node.label];
            List<String> properties = labelData?.properties ?? [];
            Map<String, dynamic> nodeProperties = node.properties ?? {};
            return _innerPropertiesListBuiler(properties, nodeProperties);
          }
          break;
        }

      case TripletPosition.edge:
        {
          return emptyView;
        }
    }
    return emptyView;
  }

  Widget _confirmBtnBuilder() {
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
              child: _propertiesListBuilder(),
            ),
          ),
          _confirmBtnBuilder(),
        ],
      ),
    );
  }
}
