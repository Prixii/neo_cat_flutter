import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/types/graph_node.dart';
import '../../types/enums.dart';
import '../../types/graph_edge.dart';
import '../../types/typdef.dart';
import '../../utils/common_util.dart';
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
      );
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
        edge: event.edge,
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
    var newNode = state.showNode?..label = event.label;
    logger.d('[newNode]${newNode!.label}');
    return state.copyWith(showNode: newNode);
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
}
