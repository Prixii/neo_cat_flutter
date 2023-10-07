import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'class_data.g.dart';

/// @author wang.jiaqi
/// @date 2023-10-07 10

@JsonSerializable()
class ClassData extends Equatable {
  final String? name;
  final List<String>? properties;

  const ClassData({required this.name, required this.properties});

  factory ClassData.fromJson(Map<String, dynamic> json) =>
      _$ClassDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClassDataToJson(this);

  @override
  List<Object?> get props => [name, properties];
}
