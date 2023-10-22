import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/types/class_data.dart';

import '../../types/node.dart';
import '../../types/relation.dart';
import '../../types/typdef.dart';
import '../../utils/common_util.dart';
import '../label/event.dart';
import '../relation/event.dart';
import 'event.dart';
import 'state.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 08

class RelationChartDataBloc
    extends Bloc<RelationChartDataEvent, RelationChartDataState> {
  RelationChartDataBloc() : super(RelationChartDataState.initial()) {
    on<InitRelationChartData>(
        (event, emit) => emit(_handleInitRelationChartData(event)));
    on<ReplacePositionMap>(
        (event, emit) => emit(_handleReplacePositionMap(event)));
    on<SetClassVisibility>(
        (event, emit) => emit(_handleSetClassVisibility(event)));
    on<UpdateClassData>((event, emit) => emit(_handleUpdateClassData(event)));
    on<DeleteClassData>((event, emit) => emit(_handleDeleteClass(event)));
    on<UpdateRelation>((event, emit) => emit(_handleUpdateRelation(event)));
    on<DeleteRelation>((event, emit) => emit(_handleDeleteRelation(event)));
    on<CreateLabel>((event, emit) => emit(_handleCreateLabel(event)));
  }

  RelationChartDataState _handleInitRelationChartData(
    InitRelationChartData event,
  ) {
    var state = RelationChartDataState.fromJson(jsonDecode(event.rawData));
    logger.i('[relationChartDataEvent]: initRelationChartData!');
    return state;
  }

  RelationChartDataState _handleReplacePositionMap(
    ReplacePositionMap event,
  ) {
    logger.i('[relationChartDataEvent]: replacePositionMap!');
    return state.copyWith(positionMap: event.positionMap);
  }

  RelationChartDataState _handleSetClassVisibility(SetClassVisibility event) {
    var classVisibilityMap = state.classVisibilityMap;
    logger.i('[classBrowser]: SetClassVisible!');
    if (classVisibilityMap[event.className] != null) {
      classVisibilityMap[event.className] =
          !classVisibilityMap[event.className]!;
      return state.copyWith(classVisibilityMap: classVisibilityMap);
    }
    return state;
  }

  RelationChartDataState _handleUpdateClassData(UpdateClassData event) {
    /// 未改名则不需要更新map
    if (event.oldName == event.classData.name) {
      var classMap = state.classMap;
      classMap[event.oldName] = event.classData;
      return state.copyWith(classMap: classMap);
    } else {
      /// 类已经被改名了
      var classMap = state.classMap;
      var classVisibilityMap = state.classVisibilityMap;
      classVisibilityMap[event.classData.name] =
          classVisibilityMap[event.oldName] ?? true;
      classVisibilityMap.remove(event.oldName);

      var nodeToClassMap = state.nodeToClassMap;
      nodeToClassMap[event.classData.name] =
          nodeToClassMap[event.oldName] ?? [];
      nodeToClassMap.remove(event.oldName);
      logger.i('[classBrowser]: updateClassData renamed!');
      return state.copyWith(
        nodeToClassMap: nodeToClassMap,
        classMap: classMap,
        classVisibilityMap: classVisibilityMap,
      );
    }
  }

  /// 确保class没有实例！！！
  RelationChartDataState _handleDeleteClass(DeleteClassData event) {
    var classMap = state.classMap..remove(event.className);
    var classVisiblityMap = state.classVisibilityMap..remove(event.className);
    var nodeToClassMap = state.nodeToClassMap..remove(event.className);

    logger.i('[classBrowser]: DeleteClassData!');

    return state.copyWith(
      nodeToClassMap: nodeToClassMap,
      classVisibilityMap: classVisiblityMap,
      classMap: classMap,
    );
  }

  RelationChartDataState _handleUpdateRelation(UpdateRelation event) {
    var relationMap = state.relationMap;
    relationMap[event.relation.id] = event.relation;
    return state.copyWith(relationMap: relationMap);
  }

  RelationChartDataState _handleDeleteRelation(DeleteRelation event) {
    return state.copyWith(
        relationMap: state.relationMap..remove(event.targetId));
  }

  RelationChartDataState _handleCreateLabel(CreateLabel event) {
    var labelMap = <ClassName, ClassData>{}..addAll(state.classMap);
    labelMap[event.classData.name] = event.classData;
    logger.d(labelMap);
    return state.copyWith(classMap: labelMap);
  }

  Future<void> generateRelativePositionMap() async {
    // TODO 计算关系相对坐标
  }

  /// 根据 [center] 返回关系的绝对坐标
  Future<Map<NodeId, Position>> getAbsolutePositionMap(
      {required Position center}) async {
    var absolutePositionMap = state.positionMap;
    for (var key in absolutePositionMap.keys) {
      var relativePosition = absolutePositionMap[key];
      if (relativePosition != null) {
        var absolutePosition = (
          relativePosition.$1 + center.$1,
          relativePosition.$2 + center.$2,
        );
        absolutePositionMap[key] = absolutePosition;
      }
    }
    return absolutePositionMap;
  }

  Triplet? getTriplet(Relation relation) {
    Node? sourceNode = state.nodeMap[relation.sourceNodeId];
    Node? endNode = state.nodeMap[relation.endNodeId];
    if (sourceNode != null && endNode != null) {
      return (sourceNode, relation, endNode);
    }
    return null;
  }

  int instanceCount(ClassName className) =>
      state.nodeToClassMap[className]?.length ?? 0;
}
