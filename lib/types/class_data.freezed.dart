// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClassData _$ClassDataFromJson(Map<String, dynamic> json) {
  return _ClassData.fromJson(json);
}

/// @nodoc
mixin _$ClassData {
  String get name => throw _privateConstructorUsedError;
  List<String> get properties => throw _privateConstructorUsedError;
  String get Color => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClassDataCopyWith<ClassData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassDataCopyWith<$Res> {
  factory $ClassDataCopyWith(ClassData value, $Res Function(ClassData) then) =
      _$ClassDataCopyWithImpl<$Res, ClassData>;
  @useResult
  $Res call({String name, List<String> properties, String Color});
}

/// @nodoc
class _$ClassDataCopyWithImpl<$Res, $Val extends ClassData>
    implements $ClassDataCopyWith<$Res> {
  _$ClassDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
    Object? Color = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Color: null == Color
          ? _value.Color
          : Color // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClassDataImplCopyWith<$Res>
    implements $ClassDataCopyWith<$Res> {
  factory _$$ClassDataImplCopyWith(
          _$ClassDataImpl value, $Res Function(_$ClassDataImpl) then) =
      __$$ClassDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> properties, String Color});
}

/// @nodoc
class __$$ClassDataImplCopyWithImpl<$Res>
    extends _$ClassDataCopyWithImpl<$Res, _$ClassDataImpl>
    implements _$$ClassDataImplCopyWith<$Res> {
  __$$ClassDataImplCopyWithImpl(
      _$ClassDataImpl _value, $Res Function(_$ClassDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
    Object? Color = null,
  }) {
    return _then(_$ClassDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      Color: null == Color
          ? _value.Color
          : Color // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClassDataImpl implements _ClassData {
  const _$ClassDataImpl(
      {required this.name,
      required final List<String> properties,
      required this.Color})
      : _properties = properties;

  factory _$ClassDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClassDataImplFromJson(json);

  @override
  final String name;
  final List<String> _properties;
  @override
  List<String> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  @override
  final String Color;

  @override
  String toString() {
    return 'ClassData(name: $name, properties: $properties, Color: $Color)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClassDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties) &&
            (identical(other.Color, Color) || other.Color == Color));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(_properties), Color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      __$$ClassDataImplCopyWithImpl<_$ClassDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClassDataImplToJson(
      this,
    );
  }
}

abstract class _ClassData implements ClassData {
  const factory _ClassData(
      {required final String name,
      required final List<String> properties,
      required final String Color}) = _$ClassDataImpl;

  factory _ClassData.fromJson(Map<String, dynamic> json) =
      _$ClassDataImpl.fromJson;

  @override
  String get name;
  @override
  List<String> get properties;
  @override
  String get Color;
  @override
  @JsonKey(ignore: true)
  _$$ClassDataImplCopyWith<_$ClassDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
