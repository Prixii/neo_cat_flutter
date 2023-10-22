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
  int get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get start => throw _privateConstructorUsedError;
  int get end => throw _privateConstructorUsedError;

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
  $Res call({int id, String type, int start, int end});
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
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
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
  $Res call({int id, String type, int start, int end});
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
    Object? type = null,
    Object? start = null,
    Object? end = null,
  }) {
    return _then(_$RelationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as int,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationImpl implements _Relation {
  const _$RelationImpl(
      {required this.id,
      required this.type,
      required this.start,
      required this.end});

  factory _$RelationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationImplFromJson(json);

  @override
  final int id;
  @override
  final String type;
  @override
  final int start;
  @override
  final int end;

  @override
  String toString() {
    return 'Relation(id: $id, type: $type, start: $start, end: $end)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, type, start, end);

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
      {required final int id,
      required final String type,
      required final int start,
      required final int end}) = _$RelationImpl;

  factory _Relation.fromJson(Map<String, dynamic> json) =
      _$RelationImpl.fromJson;

  @override
  int get id;
  @override
  String get type;
  @override
  int get start;
  @override
  int get end;
  @override
  @JsonKey(ignore: true)
  _$$RelationImplCopyWith<_$RelationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
