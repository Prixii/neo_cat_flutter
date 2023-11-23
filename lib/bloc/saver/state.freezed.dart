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
  bool get isLoading => throw _privateConstructorUsedError;

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
  $Res call({bool isLoading});
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
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
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
  $Res call({bool isLoading});
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
    Object? isLoading = null,
  }) {
    return _then(_$SaverStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SaverStateImpl implements _SaverState {
  const _$SaverStateImpl({required this.isLoading});

  @override
  final bool isLoading;

  @override
  String toString() {
    return 'SaverState(isLoading: $isLoading)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaverStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SaverStateImplCopyWith<_$SaverStateImpl> get copyWith =>
      __$$SaverStateImplCopyWithImpl<_$SaverStateImpl>(this, _$identity);
}

abstract class _SaverState implements SaverState {
  const factory _SaverState({required final bool isLoading}) = _$SaverStateImpl;

  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$SaverStateImplCopyWith<_$SaverStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
