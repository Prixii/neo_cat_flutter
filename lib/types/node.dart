import 'package:freezed_annotation/freezed_annotation.dart';
part 'node.g.dart';
part 'node.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-09-29 10

@freezed
class Node with _$Node {
  const factory Node({
    required String name,
    required String id,
    required String className,
    @Default(30) int symbolSize,
  }) = _Node;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);
}
