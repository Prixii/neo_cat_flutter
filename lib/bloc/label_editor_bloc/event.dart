import 'package:neo_cat_flutter/types/label_data.dart';

/// @author wang.jiaqi
/// @date 2023-10-09 18

abstract class ClassEditorEvent {
  ClassEditorEvent();
}

class ChooseClass extends ClassEditorEvent {
  ChooseClass({required this.classData});

  final LabelData classData;
}
