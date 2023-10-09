import 'package:neo_cat_flutter/types/class_data.dart';
import 'package:neo_cat_flutter/types/node.dart';

import '../../types/typdef.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class ClassBrowserState {
  final Map<ClassName, List<BaseNode>> nodeToClassMap;
  final Map<ClassName, bool> classVisibilityMap;
  final List<ClassData> classList;

  ClassBrowserState({
    required this.nodeToClassMap,
    required this.classVisibilityMap,
    required this.classList,
  });

  ClassBrowserState.initial()
      : nodeToClassMap = <ClassName, List<BaseNode>>{},
        classVisibilityMap = <ClassName, bool>{},
        classList = <ClassData>[];

  ClassBrowserState copyWith(
          {Map<ClassName, List<BaseNode>>? nodeToClassMap,
          Map<ClassName, bool>? classVisibilityMap,
          List<ClassData>? classList}) =>
      ClassBrowserState(
          nodeToClassMap: nodeToClassMap ?? this.nodeToClassMap,
          classVisibilityMap: classVisibilityMap ?? this.classVisibilityMap,
          classList: classList ?? this.classList);
}
