import 'package:freezed_annotation/freezed_annotation.dart';

part 'relation.g.dart';
part 'relation.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@freezed
class Relation with _$Relation {
  const factory Relation({
    required String id,
    required String name,
    required String sourceNodeId,
    required String endNodeId,
  }) = _Relation;

  factory Relation.fromJson(Map<String, dynamic> json) =>
      _$RelationFromJson(json);
}
