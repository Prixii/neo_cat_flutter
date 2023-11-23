import 'package:flutter/material.dart' show Material;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:neo_cat_flutter/bloc/edge/edge_event.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import 'package:neo_cat_flutter/types/label_data.dart';
import '../../theme/common_theme.dart';
import '../../types/enums.dart';
import '../../types/graph_edge.dart';
import '../../types/typdef.dart';
import '../../utils/common_util.dart';
import '../node/node_event.dart' as data_event;
import '../relation_chart_data_bloc/bloc.dart';
import 'event.dart';
import 'state.dart';

/// @author wang.jiaqi
/// @date 2023-10-23 15

class TripletEditorBloc extends Bloc<TripletEditorEvent, TripletEditorState> {
  TripletEditorBloc({required this.dataBloc})
      : super(TripletEditorState.initial()) {
    on<ChooseNode>((event, emit) async => emit(await _onChooseNode(event)));
    on<RemoveNode>((event, emit) => emit(_onRemoveNode(event)));
    on<SetNodeLabel>((event, emit) => emit(_onSetNodeLabel(event)));
    on<ChooseEdge>((event, emit) => emit(_onChooseEdge(event)));
    on<ClickTripletNode>((event, emit) => emit(_onClickTripletNode(event)));
    on<UpdateNode>((event, emit) => emit(_onUpdateNode(event)));
    on<SetEdgeType>((event, emit) => emit(_onSetEdgeType(event)));
    on<CreateType>((event, emit) async => emit(await _onCreateType(event)));
    on<CreateLabel>((event, emit) async => emit(await _onCreateLabel(event)));
    on<ResetEdge>((event, emit) => emit(_onResetEdge()));
    on<ResizeNode>((event, emit) => emit(_onResizeNode(event)));
  }

  final RelationChartDataBloc dataBloc;

  Future<GraphEdge?> getEdge(NodeId start, NodeId end) async {
    var edgeMap = dataBloc.state.edgeMap;
    for (var edge in edgeMap.values.toList()) {
      if (edge.start.id == start && edge.end.id == end) {
        return edge;
      }
    }
    return null;
  }

  bool showEdge() => (state.startNode != null && state.endNode != null);

  Future<TripletEditorState> _onChooseNode(ChooseNode event) async {
    logger.i('[tripletEditorState]: ChooseNode!');
    var startNode = state.startNode;
    var endNode = state.endNode;
    if (startNode == null) {
      startNode = event.newNode;
      GraphEdge? edge;
      GraphNode? showNode;
      TripletPosition? viewMode;
      if (endNode != null) {
        edge = await getEdge(startNode.id, endNode.id);
      }
      showNode = startNode;
      viewMode = TripletPosition.start;
      return state.copyWith(
        startNode: event.newNode,
        edge: edge,
        viewMode: viewMode,
        showNode: showNode,
        startNodeBorder: selectedColor,
        endNodeBorder: opacity,
      );
    } else if (endNode == null) {
      endNode = event.newNode;
      var edge = await getEdge(
        startNode.id,
        endNode.id,
      ).then((value) => value?.copyWith());
      return state.copyWith(
        endNode: endNode,
        edge: edge,
        showNode: endNode,
        viewMode: TripletPosition.end,
        startNodeBorder: opacity,
        endNodeBorder: selectedColor,
      );
    } else {
      return state;
    }
  }

  TripletEditorState _onRemoveNode(RemoveNode event) {
    logger.i('[tripletEditorState]: RemoveNode!');
    switch (event.position) {
      case TripletPosition.start:
        {
          var newState = state.removeStartNode();
          if (state.endNode != null) {
            return newState.copyWith(
              startNodeBorder: opacity,
              endNodeBorder: selectedColor,
            );
          }
          return newState.copyWith();
        }
      case TripletPosition.end:
        {
          return state.removeEndNode();
        }
      case TripletPosition.edge:
        {
          return state;
        }
    }
  }

  TripletEditorState _onChooseEdge(ChooseEdge event) {
    logger.i('[tripletEditorState]: ChooseRelation!');
    var newState = state.copyWith(
      edge: event.edge.copyWith(),
      startNode: event.edge.start,
      endNode: event.edge.end,
      showNode: event.edge.start,
      startNodeBorder: selectedColor,
      endNodeBorder: opacity,
    );
    return newState;
  }

  TripletEditorState _onClickTripletNode(ClickTripletNode event) {
    logger.i('[tripletEditorState]: setPosition! ${event.position}');

    switch (event.position) {
      case TripletPosition.start:
        {
          return state.copyWith(
            showNode: state.startNode,
            viewMode: event.position,
            startNodeBorder: selectedColor,
            endNodeBorder: opacity,
          );
        }
      case TripletPosition.end:
        {
          return state.copyWith(
            showNode: state.endNode,
            viewMode: event.position,
            startNodeBorder: opacity,
            endNodeBorder: selectedColor,
          );
        }
      default:
        {
          return state;
        }
    }
  }

  TripletEditorState _onSetNodeLabel(SetNodeLabel event) {
    logger.i('[tripletEditorState]: setLabel! ${event.label}');
    var newNode = state.showNode?.copyWith(label: event.label);

    return state.copyWith(showNode: newNode);
  }

  TripletEditorState _onUpdateNode(UpdateNode event) {
    var newNode = state.showNode!
      ..properties = event.properties
      ..name = event.name;
    logger.i('[newNode] $newNode');
    dataBloc.add(data_event.UpdateNode(newNode));
    switch (state.viewMode) {
      case TripletPosition.start:
        {
          return state.copyWith(startNode: newNode, showNode: newNode);
        }
      case TripletPosition.end:
        {
          {
            return state.copyWith(endNode: newNode, showNode: newNode);
          }
        }
      default:
        {
          return state;
        }
    }
  }

  TripletEditorState _onSetEdgeType(SetEdgeType event) {
    logger.i('[setEdgeType] ${event.type}');
    if (state.edge != null) {
      var oldType = state.edge!.type;
      var newEdge = state.edge!.copyWith(type: event.type);
      dataBloc.add(UpdateEdge(edge: newEdge, oldType: oldType));
      return state.copyWith(edge: newEdge);
    }
    return _onCreateEdge(event.type);
  }

  TripletEditorState _onCreateEdge(EdgeType type) {
    var hashCode =
        (state.startNode.toString() + state.endNode.toString() + type).hashCode;
    var edge = GraphEdge(state.startNode!, state.endNode!, type, hashCode);
    dataBloc.add(CreateEdge(edge));
    return state.copyWith(edge: edge);
  }

  TripletEditorState _onResizeNode(ResizeNode event) {
    var radius = event.newSize;
    var showNode = state.showNode;
    showNode!.size = Size(radius, radius);
    dataBloc.add(data_event.UpdateNode(showNode));
    return state.copyWith(showNode: showNode);
  }

  Future<TripletEditorState> _onCreateType(CreateType event) async {
    var controller = TextEditingController();
    var isCreated = false;
    await showDialog(
      context: event.context,
      builder: (context) => ContentDialog(
        title: Text(
          '创建新的Edge Type',
          style: defaultTextBlack,
        ),
        content: TextBox(
          autofocus: true,
          controller: controller,
        ),
        actions: [
          Button(
              child: const Text('算了'),
              onPressed: () {
                Navigator.pop(context);
              }),
          Button(
              child: const Text('创建'),
              onPressed: () {
                isCreated = true;
                Navigator.pop(context);
              }),
        ],
      ),
    );
    if (isCreated) {
      var newType = controller.text;
      var newEdge = GraphEdge(state.startNode!, state.endNode!, newType,
          "${state.startNode!}${state.endNode!}$newType".hashCode);
      dataBloc.add(CreateEdgeTypeAndAddEdge(controller.text, newEdge));
      controller.dispose();

      return state.copyWith(edge: newEdge);
    } else {
      controller.dispose();
      return state;
    }
  }

  Future<TripletEditorState> _onCreateLabel(CreateLabel event) async {
    var controller = TextEditingController();
    Color pickerColor = Colors.blue;
    var isCreated = false;
    await showDialog(
      context: event.context,
      builder: (context) => ContentDialog(
        title: Text(
          '创建新的Label',
          style: defaultTextBlack,
        ),
        content: SizedBox(
          height: 246,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Row(
                  children: [
                    Expanded(
                      child: TextBox(
                        autofocus: true,
                        controller: controller,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Container(color: pickerColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Material(
                  child: SlidePicker(
                    showIndicator: false,
                    enableAlpha: false,
                    pickerColor: pickerColor,
                    onColorChanged: (Color newColor) {
                      pickerColor = newColor;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Button(
              child: const Text('算了'),
              onPressed: () {
                Navigator.pop(context);
              }),
          Button(
              child: const Text('创建'),
              onPressed: () {
                isCreated = true;
                Navigator.pop(context);
              }),
        ],
      ),
    );
    if (isCreated) {
      var labelName = controller.text;
      controller.dispose();
      var newLabel = LabelData(name: labelName, color: pickerColor.toHex());
      dataBloc.add(
          data_event.CreateLabelAndSetNode(newLabel, state.showNode!, true));
      return state.copyWith(
        showNode: state.showNode!.copyWith(label: labelName),
      );
    } else {
      controller.dispose();
      return state;
    }
  }

  TripletEditorState _onResetEdge() {
    return TripletEditorState(
      startNode: state.startNode,
      edge: null,
      endNode: state.endNode,
      viewMode: state.viewMode,
      showNode: state.showNode,
      startNodeBorder: state.startNodeBorder,
      endNodeBorder: state.endNodeBorder,
    );
  }
}
