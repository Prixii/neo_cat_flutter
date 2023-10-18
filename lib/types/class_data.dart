import 'package:freezed_annotation/freezed_annotation.dart';

part 'class_data.g.dart';
part 'class_data.freezed.dart';

/// @author wang.jiaqi
/// @date 2023-10-07 10

@freezed
class ClassData with _$ClassData {
  const factory ClassData({
    required String name,
    required List<String> properties,
    required String Color,
  }) = _ClassData;

  factory ClassData.fromJson(Map<String, dynamic> json) =>
      _$ClassDataFromJson(json);
}
