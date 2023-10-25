// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SaverState {
  bool get isAlertVisible => throw _privateConstructorUsedError;
  String get alertMessage => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isNameConflict => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SaverStateCopyWith<SaverState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaverStateCopyWith<$Res> {
  factory $SaverStateCopyWith(
          SaverState value, $Res Function(SaverState) then) =
      _$SaverStateCopyWithImpl<$Res, SaverState>;
  @useResult
  $Res call(
      {bool isAlertVisible,
      String alertMessage,
      bool isLoading,
      bool isNameConflict});
}

/// @nodoc
class _$SaverStateCopyWithImpl<$Res, $Val extends SaverState>
    implements $SaverStateCopyWith<$Res> {
  _$SaverStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlertVisible = null,
    Object? alertMessage = null,
    Object? isLoading = null,
    Object? isNameConflict = null,
  }) {
    return _then(_value.copyWith(
      isAlertVisible: null == isAlertVisible
          ? _value.isAlertVisible
          : isAlertVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      alertMessage: null == alertMessage
          ? _value.alertMessage
          : alertMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isNameConflict: null == isNameConflict
          ? _value.isNameConflict
          : isNameConflict // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaverStateImplCopyWith<$Res>
    implements $SaverStateCopyWith<$Res> {
  factory _$$SaverStateImplCopyWith(
          _$SaverStateImpl value, $Res Function(_$SaverStateImpl) then) =
      __$$SaverStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isAlertVisible,
      String alertMessage,
      bool isLoading,
      bool isNameConflict});
}

/// @nodoc
class __$$SaverStateImplCopyWithImpl<$Res>
    extends _$SaverStateCopyWithImpl<$Res, _$SaverStateImpl>
    implements _$$SaverStateImplCopyWith<$Res> {
  __$$SaverStateImplCopyWithImpl(
      _$SaverStateImpl _value, $Res Function(_$SaverStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlertVisible = null,
    Object? alertMessage = null,
    Object? isLoading = null,
    Object? isNameConflict = null,
  }) {
    return _then(_$SaverStateImpl(
      isAlertVisible: null == isAlertVisible
          ? _value.isAlertVisible
          : isAlertVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      alertMessage: null == alertMessage
          ? _value.alertMessage
          : alertMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isNameConflict: null == isNameConflict
          ? _value.isNameConflict
          : isNameConflict // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SaverStateImpl implements _SaverState {
  const _$SaverStateImpl(
      {required this.isAlertVisible,
      required this.alertMessage,
      required this.isLoading,
      required this.isNameConflict});

  @override
  final bool isAlertVisible;
  @override
  final String alertMessage;
  @override
  final bool isLoading;
  @override
  final bool isNameConflict;

  @override
  String toString() {
    return 'SaverState(isAlertVisible: $isAlertVisible, alertMessage: $alertMessage, isLoading: $isLoading, isNameConflict: $isNameConflict)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaverStateImpl &&
            (identical(other.isAlertVisible, isAlertVisible) ||
                other.isAlertVisible == isAlertVisible) &&
            (identical(other.alertMessage, alertMessage) ||
                other.alertMessage == alertMessage) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isNameConflict, isNameConflict) ||
                other.isNameConflict == isNameConflict));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, isAlertVisible, alertMessage, isLoading, isNameConflict);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaverStateImplCopyWith<_$SaverStateImpl> get copyWith =>
      __$$SaverStateImplCopyWithImpl<_$SaverStateImpl>(this, _$identity);
}

abstract class _SaverState implements SaverState {
  const factory _SaverState(
      {required final bool isAlertVisible,
      required final String alertMessage,
      required final bool isLoading,
      required final bool isNameConflict}) = _$SaverStateImpl;

  @override
  bool get isAlertVisible;
  @override
  String get alertMessage;
  @override
  bool get isLoading;
  @override
  bool get isNameConflict;
  @override
  @JsonKey(ignore: true)
  _$$SaverStateImplCopyWith<_$SaverStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
