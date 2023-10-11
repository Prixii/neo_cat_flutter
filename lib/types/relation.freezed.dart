// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Relation _$RelationFromJson(Map<String, dynamic> json) {
  return _Relation.fromJson(json);
}

/// @nodoc
mixin _$Relation {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get sourceNodeId => throw _privateConstructorUsedError;
  String get endNodeId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RelationCopyWith<Relation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationCopyWith<$Res> {
  factory $RelationCopyWith(Relation value, $Res Function(Relation) then) =
      _$RelationCopyWithImpl<$Res, Relation>;
  @useResult
  $Res call({String id, String name, String sourceNodeId, String endNodeId});
}

/// @nodoc
class _$RelationCopyWithImpl<$Res, $Val extends Relation>
    implements $RelationCopyWith<$Res> {
  _$RelationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceNodeId = null,
    Object? endNodeId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceNodeId: null == sourceNodeId
          ? _value.sourceNodeId
          : sourceNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      endNodeId: null == endNodeId
          ? _value.endNodeId
          : endNodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RelationImplCopyWith<$Res>
    implements $RelationCopyWith<$Res> {
  factory _$$RelationImplCopyWith(
          _$RelationImpl value, $Res Function(_$RelationImpl) then) =
      __$$RelationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String sourceNodeId, String endNodeId});
}

/// @nodoc
class __$$RelationImplCopyWithImpl<$Res>
    extends _$RelationCopyWithImpl<$Res, _$RelationImpl>
    implements _$$RelationImplCopyWith<$Res> {
  __$$RelationImplCopyWithImpl(
      _$RelationImpl _value, $Res Function(_$RelationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sourceNodeId = null,
    Object? endNodeId = null,
  }) {
    return _then(_$RelationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sourceNodeId: null == sourceNodeId
          ? _value.sourceNodeId
          : sourceNodeId // ignore: cast_nullable_to_non_nullable
              as String,
      endNodeId: null == endNodeId
          ? _value.endNodeId
          : endNodeId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationImpl implements _Relation {
  const _$RelationImpl(
      {required this.id,
      required this.name,
      required this.sourceNodeId,
      required this.endNodeId});

  factory _$RelationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String sourceNodeId;
  @override
  final String endNodeId;

  @override
  String toString() {
    return 'Relation(id: $id, name: $name, sourceNodeId: $sourceNodeId, endNodeId: $endNodeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sourceNodeId, sourceNodeId) ||
                other.sourceNodeId == sourceNodeId) &&
            (identical(other.endNodeId, endNodeId) ||
                other.endNodeId == endNodeId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, sourceNodeId, endNodeId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationImplCopyWith<_$RelationImpl> get copyWith =>
      __$$RelationImplCopyWithImpl<_$RelationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationImplToJson(
      this,
    );
  }
}

abstract class _Relation implements Relation {
  const factory _Relation(
      {required final String id,
      required final String name,
      required final String sourceNodeId,
      required final String endNodeId}) = _$RelationImpl;

  factory _Relation.fromJson(Map<String, dynamic> json) =
      _$RelationImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get sourceNodeId;
  @override
  String get endNodeId;
  @override
  @JsonKey(ignore: true)
  _$$RelationImplCopyWith<_$RelationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
