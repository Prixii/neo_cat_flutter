import 'package:neo_cat_flutter/bloc/relation_chart_data_bloc/relation_chart_data_model.dart';
import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/utils/common_util.dart';

import '../../types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class ClassBrowserState {
  final Map<ClassName, List<Node>> nodeToClassMap;
  final Map<ClassName, bool> classVisibilityMap;
  final List<ClassData> classList;

  ClassBrowserState({
    required this.nodeToClassMap,
    required this.classVisibilityMap,
    required this.classList,
  });

  ClassBrowserState.initial()
      : nodeToClassMap = <ClassName, List<Node>>{},
        classVisibilityMap = <ClassName, bool>{},
        classList = <ClassData>[];

  factory ClassBrowserState.fromRelationChartData(
      RelationChartDataModel model) {
    var classList = model.classDataList;
    var nodeList = model.nodeList;
    var classVisibilityMap = <ClassName, bool>{};
    var nodeToClassMap = <ClassName, List<Node>>{};

    for (var classData in classList) {
      classVisibilityMap[classData.name] = true;
      nodeToClassMap[classData.name] = [];
    }

    for (var node in nodeList) {
      var newList = nodeToClassMap[node.className];
      if (newList != null) {
        newList.add(node);
        nodeToClassMap[node.className] = newList;
      }
    }
    return ClassBrowserState(
      nodeToClassMap: nodeToClassMap,
      classVisibilityMap: classVisibilityMap,
      classList: classList,
    );
  }

  ClassBrowserState copyWith(
          {Map<ClassName, List<Node>>? nodeToClassMap,
          Map<ClassName, bool>? classVisibilityMap,
          List<ClassData>? classList}) =>
      ClassBrowserState(
          nodeToClassMap: nodeToClassMap ?? this.nodeToClassMap,
          classVisibilityMap: classVisibilityMap ?? this.classVisibilityMap,
          classList: classList ?? this.classList);
}
