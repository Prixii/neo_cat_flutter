import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/edge/edge_event.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
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
  final RelationChartDataBloc dataBloc;

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
  }

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
          return state.removeStartNode();
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
        showNode: event.edge.start);
    return newState;
  }

  TripletEditorState _onClickTripletNode(ClickTripletNode event) {
    logger.i('[tripletEditorState]: setPosition! ${event.position}');

    switch (event.position) {
      case TripletPosition.start:
        {
          return state.copyWith(
              showNode: state.startNode, viewMode: event.position);
        }
      case TripletPosition.end:
        {
          return state.copyWith(
              showNode: state.endNode, viewMode: event.position);
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

  Future<TripletEditorState> _onCreateType(CreateType event) async {
    var controller = TextEditingController();
    await showDialog(
      context: event.context,
      builder: (context) => ContentDialog(
        title: Text(
          '警告!',
          style: defaultTextBlack,
        ),
        content: TextBox(
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
                Navigator.pop(context);
              }),
        ],
      ),
    );
    dataBloc.add(CreateEdgeType(controller.text));
    controller.dispose();
    return state;
  }

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
}
