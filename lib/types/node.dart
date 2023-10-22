import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';
part 'node.g.dart';
part 'node.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@freezed
class Node with _$Node {
  const factory Node({
    required String name,
    required Map<String, dynamic>? properties,
    required NodeId id,
    required LabelName label,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
