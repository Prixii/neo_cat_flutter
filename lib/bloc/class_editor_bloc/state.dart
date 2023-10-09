import 'package:neo_cat_flutter/types/class_data.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class ClassEditorState {
  final ClassData? classData;

  ClassEditorState({required this.classData});

  ClassEditorState.initial() : classData = null;

  ClassEditorState copyWith({ClassData? classData}) =>
      ClassEditorState(classData: classData ?? this.classData);
}
