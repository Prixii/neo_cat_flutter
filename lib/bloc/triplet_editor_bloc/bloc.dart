import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<ChooseNode>((event, emit) async => emit(await _handleChooseNode(event)));
    on<RemoveNode>((event, emit) => emit(_handleRemoveNode(event)));
    on<ChooseRelation>((event, emit) => emit(_handleChooseRelation(event)));
    on<ClickTripletNode>((event, emit) => emit(_handleClickTripletNode(event)));
  }

  Future<TripletEditorState> _handleChooseNode(ChooseNode event) async {
    logger.i('[tripletEditorState]: ChooseNode!');
    var startNode = state.sourceNode;
    var endNode = state.endNode;
    if (startNode == null) {
      startNode = event.newNode;
      GraphEdge? edge;
      if (endNode != null) {
        edge = await getEdge(startNode.id, endNode.id);
      }
      return state.copyWith(sourceNode: event.newNode, edge: edge);
    } else if (endNode == null) {
      endNode = event.newNode;
      var edge = await getEdge(startNode.id, endNode.id);
      return state.copyWith(endNode: endNode, edge: edge);
    } else {
      return state;
    }
  }

  TripletEditorState _handleRemoveNode(RemoveNode event) {
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

  TripletEditorState _handleChooseRelation(ChooseRelation event) {
    logger.i('[tripletEditorState]: ChooseRelation!');
    var newState = state.copyWith(edge: event.relation);
    return newState;
  }

  TripletEditorState _handleClickTripletNode(ClickTripletNode event) {
    logger
        .i('[tripletEditorState] new ${event.position} last ${state.viewMode}');
    return state.copyWith(viewMode: event.position);
  }

  Future<GraphEdge?> getEdge(NodeId source, NodeId end) async {
    var edgeMap = dataBloc.state.edgeMap;
    for (var edge in edgeMap.values.toList()) {
      if (edge.start.id == source && edge.end.id == end) {
        return edge;
      }
    }
    return null;
  }
}
