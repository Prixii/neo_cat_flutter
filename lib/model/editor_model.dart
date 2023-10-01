import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:neo_cat_flutter/types/node.dart';
import 'package:neo_cat_flutter/types/relation.dart';

part 'editor_model.g.dart';

/// @author wang.jiaqi
/// @date 2023-10-01 20

@JsonSerializable()
class EditorModel extends Equatable {
  final BaseNode? startNode;
  final BaseNode? endNode;
  final BaseRelation? relation;

  const EditorModel({this.startNode, this.endNode, this.relation});

  factory EditorModel.fromJson(Map<String, dynamic> json) =>
      _$EditorModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditorModelToJson(this);

  @override
  List<Object?> get props => [startNode, endNode, relation];
}
