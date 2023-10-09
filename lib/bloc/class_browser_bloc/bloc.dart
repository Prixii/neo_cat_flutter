import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/event.dart';
import 'package:neo_cat_flutter/bloc/class_browser_bloc/state.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 14

class ClassBrowserBloc extends Bloc<ClassBrowserEvent, ClassBrowserState> {
  ClassBrowserBloc() : super(ClassBrowserState.initial()) {
    on<InitClassBrowserState>(
        (event, emit) => emit(_handleInitClassBrowserState(event)));
    on<SetIsClassVisible>((event, emit) => emit(_handleSetClassVisible(event)));
    on<UpdateClassData>((event, emit) => emit(_handleUpdateClassData(event)));
    on<DeleteClassData>((event, emit) => emit(_handleDeleteClass(event)));
  }

  ClassBrowserState _handleInitClassBrowserState(InitClassBrowserState event) {
    return ClassBrowserState.fromRelationChartData(event.model);
  }

  ClassBrowserState _handleSetClassVisible(SetIsClassVisible event) {
    var classVisibilityMap = state.classVisibilityMap;
    if (classVisibilityMap[event.className] != null) {
      classVisibilityMap[event.className] =
          !classVisibilityMap[event.className]!;
      return state.copyWith(classVisibilityMap: classVisibilityMap);
    }
    return state;
  }

  ClassBrowserState _handleUpdateClassData(UpdateClassData event) {
    /// 未改名则不需要更新map
    if (event.oldName == event.classData.name) {
      var classList = state.classList;
      for (var index = 0; index < classList.length; index++) {
        if (classList[index].name == event.oldName) {
          classList[index] =
              classList[index].copyWith(properties: event.classData.properties);
          return state.copyWith(classList: classList);
        }
      }
    } else {
      /// 类已经被改名了
      var classList = state.classList;
      for (var index = 0; index < classList.length; index++) {
        if (classList[index].name == event.oldName) {
          classList[index] = event.classData;
        }
      }

      var classVisibilityMap = state.classVisibilityMap;
      classVisibilityMap[event.classData.name] =
          classVisibilityMap[event.oldName] ?? true;
      classVisibilityMap.remove(event.oldName);

      var nodeToClassMap = state.nodeToClassMap;
      nodeToClassMap[event.classData.name] =
          nodeToClassMap[event.oldName] ?? [];
      nodeToClassMap.remove(event.oldName);
      return state.copyWith(
        nodeToClassMap: nodeToClassMap,
        classList: classList,
        classVisibilityMap: classVisibilityMap,
      );
    }
    return state;
  }

  ClassBrowserState _handleDeleteClass(DeleteClassData event) {
    var targetName = event.className;
    var classList = state.classList;
    for (var classData in classList) {
      if (classData.name == targetName) {
        classList.remove(classData);
        break;
      }
    }
    var classVisiblityMap = state.classVisibilityMap..remove(targetName);
    var nodeToClassMap = state.nodeToClassMap..remove(targetName);

    return state.copyWith(
      nodeToClassMap: nodeToClassMap,
      classVisibilityMap: classVisiblityMap,
      classList: classList,
    );
  }
}
