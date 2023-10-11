// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relation_chart_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RelationChartDataModel _$RelationChartDataModelFromJson(
    Map<String, dynamic> json) {
  return _RelationChartDataModel.fromJson(json);
}

/// @nodoc
mixin _$RelationChartDataModel {
  List<Node> get nodeList => throw _privateConstructorUsedError;
  List<Relation> get relationList => throw _privateConstructorUsedError;
  List<ClassData> get classDataList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RelationChartDataModelCopyWith<RelationChartDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelationChartDataModelCopyWith<$Res> {
  factory $RelationChartDataModelCopyWith(RelationChartDataModel value,
          $Res Function(RelationChartDataModel) then) =
      _$RelationChartDataModelCopyWithImpl<$Res, RelationChartDataModel>;
  @useResult
  $Res call(
      {List<Node> nodeList,
      List<Relation> relationList,
      List<ClassData> classDataList});
}

/// @nodoc
class _$RelationChartDataModelCopyWithImpl<$Res,
        $Val extends RelationChartDataModel>
    implements $RelationChartDataModelCopyWith<$Res> {
  _$RelationChartDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeList = null,
    Object? relationList = null,
    Object? classDataList = null,
  }) {
    return _then(_value.copyWith(
      nodeList: null == nodeList
          ? _value.nodeList
          : nodeList // ignore: cast_nullable_to_non_nullable
              as List<Node>,
      relationList: null == relationList
          ? _value.relationList
          : relationList // ignore: cast_nullable_to_non_nullable
              as List<Relation>,
      classDataList: null == classDataList
          ? _value.classDataList
          : classDataList // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RelationChartDataModelImplCopyWith<$Res>
    implements $RelationChartDataModelCopyWith<$Res> {
  factory _$$RelationChartDataModelImplCopyWith(
          _$RelationChartDataModelImpl value,
          $Res Function(_$RelationChartDataModelImpl) then) =
      __$$RelationChartDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Node> nodeList,
      List<Relation> relationList,
      List<ClassData> classDataList});
}

/// @nodoc
class __$$RelationChartDataModelImplCopyWithImpl<$Res>
    extends _$RelationChartDataModelCopyWithImpl<$Res,
        _$RelationChartDataModelImpl>
    implements _$$RelationChartDataModelImplCopyWith<$Res> {
  __$$RelationChartDataModelImplCopyWithImpl(
      _$RelationChartDataModelImpl _value,
      $Res Function(_$RelationChartDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nodeList = null,
    Object? relationList = null,
    Object? classDataList = null,
  }) {
    return _then(_$RelationChartDataModelImpl(
      nodeList: null == nodeList
          ? _value._nodeList
          : nodeList // ignore: cast_nullable_to_non_nullable
              as List<Node>,
      relationList: null == relationList
          ? _value._relationList
          : relationList // ignore: cast_nullable_to_non_nullable
              as List<Relation>,
      classDataList: null == classDataList
          ? _value._classDataList
          : classDataList // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RelationChartDataModelImpl implements _RelationChartDataModel {
  const _$RelationChartDataModelImpl(
      {required final List<Node> nodeList,
      required final List<Relation> relationList,
      required final List<ClassData> classDataList})
      : _nodeList = nodeList,
        _relationList = relationList,
        _classDataList = classDataList;

  factory _$RelationChartDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RelationChartDataModelImplFromJson(json);

  final List<Node> _nodeList;
  @override
  List<Node> get nodeList {
    if (_nodeList is EqualUnmodifiableListView) return _nodeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nodeList);
  }

  final List<Relation> _relationList;
  @override
  List<Relation> get relationList {
    if (_relationList is EqualUnmodifiableListView) return _relationList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relationList);
  }

  final List<ClassData> _classDataList;
  @override
  List<ClassData> get classDataList {
    if (_classDataList is EqualUnmodifiableListView) return _classDataList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classDataList);
  }

  @override
  String toString() {
    return 'RelationChartDataModel(nodeList: $nodeList, relationList: $relationList, classDataList: $classDataList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RelationChartDataModelImpl &&
            const DeepCollectionEquality().equals(other._nodeList, _nodeList) &&
            const DeepCollectionEquality()
                .equals(other._relationList, _relationList) &&
            const DeepCollectionEquality()
                .equals(other._classDataList, _classDataList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_nodeList),
      const DeepCollectionEquality().hash(_relationList),
      const DeepCollectionEquality().hash(_classDataList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RelationChartDataModelImplCopyWith<_$RelationChartDataModelImpl>
      get copyWith => __$$RelationChartDataModelImplCopyWithImpl<
          _$RelationChartDataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RelationChartDataModelImplToJson(
      this,
    );
  }
}

abstract class _RelationChartDataModel implements RelationChartDataModel {
  const factory _RelationChartDataModel(
          {required final List<Node> nodeList,
          required final List<Relation> relationList,
          required final List<ClassData> classDataList}) =
      _$RelationChartDataModelImpl;

  factory _RelationChartDataModel.fromJson(Map<String, dynamic> json) =
      _$RelationChartDataModelImpl.fromJson;

  @override
  List<Node> get nodeList;
  @override
  List<Relation> get relationList;
  @override
  List<ClassData> get classDataList;
  @override
  @JsonKey(ignore: true)
  _$$RelationChartDataModelImplCopyWith<_$RelationChartDataModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
