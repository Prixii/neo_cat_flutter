import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:neo_cat_flutter/types/typdef.dart';

part 'relation.g.dart';
part 'relation.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@freezed
class Relation with _$Relation {
  const factory Relation({
    required RelationId id,
    required String type,
    required int start,
    required int end,
  }) = _Relation;

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);
}
