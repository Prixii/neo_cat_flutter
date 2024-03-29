import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/state.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/bloc.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/triplet_editor_bloc/state.dart';
import 'package:neo_cat_flutter/components/common/node_radius_editor.dart';
import 'package:neo_cat_flutter/components/common/property_tile.dart';
import 'package:neo_cat_flutter/theme/common_theme.dart';
import 'package:neo_cat_flutter/types/enums.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
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
  Map<String, TextEditingController> controllers = {};
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    disposeControllers();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void handleHover(Color color) {
    setState(() {
      color = const Color.fromRGBO(0, 0, 0, 0.04);
    });
  }

  void handleExit(Color color) {
    setState(() {
      color = opacity;
    });
  }

  void disposeControllers() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    controllers = {};
  }

  GraphNode? _getStartNode() {
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
            Expanded(flex: 1, child: _startNodeBuilder()),
            Expanded(flex: 3, child: _edgeBuilder()),
            Expanded(flex: 1, child: _endNodeBuilder()),
          ],
        ),
      ),
    );
  }

  Widget _startNodeBuilder() {
    var bgColor =
        relationChartDataBloc(context).getColor(_getStartNode()?.label);
    return GestureDetector(
      onTap: () => tripletEditorBloc(context)
          .add(ClickTripletNode(TripletPosition.start)),
      onSecondaryTap: () => tripletEditorBloc(context)
          .add(RemoveNode(position: TripletPosition.start)),
      onLongPress: () => tripletEditorBloc(context)
          .add(RemoveNode(position: TripletPosition.start)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 4,
              color: tripletEditorBloc(context).state.startNodeBorder,
            ),
          ),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: CirclePainter(
                      radius: 25,
                      color: bgColor,
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  _getStartNode()?.name ?? '待选择',
                  overflow: TextOverflow.ellipsis,
                  style: calculateTextColor(bgColor).copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _edgeBuilder() {
    return Stack(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: ArrowPainter(),
            );
          },
        ),
        Center(
          child: SizedBox(
            height: 40,
            child: Visibility(
              visible: tripletEditorBloc(context).showEdge(),
              child: Container(
                color: Colors.white,
                child:
                    BlocBuilder<RelationChartDataBloc, RelationChartDataState>(
                  builder: (context, state) => ComboBox(
                    key: Key(_edgeItemGenerator().length.toString()),
                    items: _edgeItemGenerator(),
                    value: _getEdge()?.type ?? '',
                    onChanged: (e) => {},
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<ComboBoxItem<String>> _edgeItemGenerator() {
    var itemList = <ComboBoxItem<String>>[];
    itemList.add(ComboBoxItem(
      child: Text(
        '创建Type',
        style: defaultTextBlack,
      ),
      onTap: () {
        tripletEditorBloc(context).add(CreateType(context));
      },
    ));
    for (var type in relationChartDataBloc(context).state.edgeTypes.toList()) {
      itemList.add(
        ComboBoxItem(
          value: type,
          child: Text(
            type,
            style: defaultTextBlack,
          ),
          onTap: () {
            if (type != tripletEditorBloc(context).state.edge?.type) {
              tripletEditorBloc(context).add(SetEdgeType(type));
            }
          },
        ),
      );
    }
    return itemList;
  }

  Widget _endNodeBuilder() {
    var bgColor = relationChartDataBloc(context).getColor(_getEndNode()?.label);
    return GestureDetector(
      onTap: () =>
          tripletEditorBloc(context).add(ClickTripletNode(TripletPosition.end)),
      onSecondaryTap: () => tripletEditorBloc(context)
          .add(RemoveNode(position: TripletPosition.end)),
      onLongPress: () => tripletEditorBloc(context)
          .add(RemoveNode(position: TripletPosition.end)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: 4,
              color: tripletEditorBloc(context).state.endNodeBorder,
            ),
          ),
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return CustomPaint(
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                    painter: CirclePainter(radius: 25, color: bgColor),
                  );
                },
              ),
              Center(
                child: Text(
                  _getEndNode()?.name ?? '待选择',
                  overflow: TextOverflow.ellipsis,
                  style: calculateTextColor(bgColor).copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GraphNode? showNode() => tripletEditorBloc(context).state.showNode;

  Widget _instantPropertiesEditorBuilder() {
    if (showNode() == null) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          children: [
            PropertyTile(propertyName: 'radius'),
            PropertyTile(propertyName: 'Label'),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          children: [
            const NodeRadiusEditor(),
            _labelSetterBuilder(showNode()!.label),
          ],
        ),
      );
    }
  }

  Widget _propertiesListBuiler() {
    disposeControllers();
    nameController.text = '';
    LabelData? labelData() =>
        relationChartDataBloc(context).state.labelMap[showNode()?.label];
    if (showNode() == null) {
      return emptyView;
    } else {
      var itemCount = labelData()?.properties.length ?? 0;
      for (var i = 0; i < itemCount; i++) {
        controllers[labelData()!.properties[i]] = TextEditingController();
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
        child: Column(
          children: [
            PropertyTile(
              propertyName: 'name',
              controller: nameController..text = showNode()!.name,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return PropertyTile(
                    controller: controllers[labelData()!.properties[index]]!
                      ..text = showNode()!
                              .properties?[labelData()!.properties[index]] ??
                          '',
                    propertyName: labelData()!.properties[index],
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
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
              child: ComboBox(
                key: Key(_labelItemGenerator().length.toString()),
                value: tripletEditorBloc(context).state.showNode!.label,
                items: _labelItemGenerator(),
                onChanged: (label) => {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _confirmButtonBuilder() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
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
          onPressed: () {
            if (!_isLabelExist()) {
              return;
            }
            var properties = <String, dynamic>{};
            for (var entry in controllers.entries.toList()) {
              properties[entry.key] = entry.value.text;
            }
            tripletEditorBloc(context)
                .add(UpdateNode(properties, nameController.text));
          },
        ),
      ),
    );
  }

  bool _isLabelExist() {
    if (!relationChartDataBloc(context)
        .state
        .labelMap
        .keys
        .toList()
        .contains(tripletEditorBloc(context).state.showNode?.label ?? '')) {
      showDialog(
        context: context,
        builder: (context) => ContentDialog(
          title: Text(
            '警告',
            style: defaultTextBlack,
          ),
          content: const Text('此Label不存在，请先创建对应的Label'),
          actions: [
            Button(
                child: const Text('我知道了'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  List<ComboBoxItem<String>> _labelItemGenerator() {
    var itemList = <ComboBoxItem<String>>[];
    itemList.add(ComboBoxItem(
      child: Text(
        '创建Label',
        style: defaultTextBlack,
      ),
      onTap: () {
        tripletEditorBloc(context).add(CreateLabel(context));
      },
    ));
    for (var label
        in relationChartDataBloc(context).state.labelMap.values.toList()) {
      itemList.add(
        ComboBoxItem(
          value: label.name,
          child: Text(
            label.name,
            style: defaultTextBlack,
          ),
          onTap: () {
            if (label.name ==
                tripletEditorBloc(context).state.showNode!.label) {
              return;
            }
            tripletEditorBloc(context).add(SetNodeLabel(label: label.name));
          },
        ),
      );
    }
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripletEditorBloc, TripletEditorState>(
      builder: (context, state) => Column(
        children: [
          Container(
            decoration: normalBoxDecoration.copyWith(
              border: normalBorder,
            ),
            child: _tripletEditorBuilder(),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            decoration: normalBoxDecoration.copyWith(
              border: normalBorder,
            ),
            child: _instantPropertiesEditorBuilder(),
          ),
          const SizedBox(
            height: 6,
          ),
          Expanded(
            child: Container(
              decoration: normalBoxDecoration.copyWith(
                border: normalBorder,
              ),
              child: _propertiesListBuiler(),
            ),
          ),
          _confirmButtonBuilder(),
        ],
      ),
    );
  }
}
