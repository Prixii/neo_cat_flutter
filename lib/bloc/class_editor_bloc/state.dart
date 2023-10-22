import 'package:neo_cat_flutter/types/label_data.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 09

class ClassEditorState {
  final LabelData? classData;

  ClassEditorState({required this.classData});

  ClassEditorState.initial() : classData = null;

  ClassEditorState copyWith({LabelData? classData}) =>
      ClassEditorState(classData: classData ?? this.classData);
}
