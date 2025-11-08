// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ApiResponse<T> _$ApiResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object?) fromJsonT,
) {
  return _ApiResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ApiResponse<T> {
  String? get message => throw _privateConstructorUsedError;
  T? get data => throw _privateConstructorUsedError;

  /// Serializes this ApiResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApiResponseCopyWith<T, ApiResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, $Res> {
  factory $ApiResponseCopyWith(
    ApiResponse<T> value,
    $Res Function(ApiResponse<T>) then,
  ) = _$ApiResponseCopyWithImpl<T, $Res, ApiResponse<T>>;
  @useResult
  $Res call({String? message, T? data});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, $Res, $Val extends ApiResponse<T>>
    implements $ApiResponseCopyWith<T, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? data = freezed}) {
    return _then(
      _value.copyWith(
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as T?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ApiResponseImplCopyWith<T, $Res>
    implements $ApiResponseCopyWith<T, $Res> {
  factory _$$ApiResponseImplCopyWith(
    _$ApiResponseImpl<T> value,
    $Res Function(_$ApiResponseImpl<T>) then,
  ) = __$$ApiResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({String? message, T? data});
}

/// @nodoc
class __$$ApiResponseImplCopyWithImpl<T, $Res>
    extends _$ApiResponseCopyWithImpl<T, $Res, _$ApiResponseImpl<T>>
    implements _$$ApiResponseImplCopyWith<T, $Res> {
  __$$ApiResponseImplCopyWithImpl(
    _$ApiResponseImpl<T> _value,
    $Res Function(_$ApiResponseImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed, Object? data = freezed}) {
    return _then(
      _$ApiResponseImpl<T>(
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as T?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ApiResponseImpl<T> implements _ApiResponse<T> {
  const _$ApiResponseImpl({this.message, this.data});

  factory _$ApiResponseImpl.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$$ApiResponseImplFromJson(json, fromJsonT);

  @override
  final String? message;
  @override
  final T? data;

  @override
  String toString() {
    return 'ApiResponse<$T>(message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseImpl<T> &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(data),
  );

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      __$$ApiResponseImplCopyWithImpl<T, _$ApiResponseImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ApiResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ApiResponse<T> implements ApiResponse<T> {
  const factory _ApiResponse({final String? message, final T? data}) =
      _$ApiResponseImpl<T>;

  factory _ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) = _$ApiResponseImpl<T>.fromJson;

  @override
  String? get message;
  @override
  T? get data;

  /// Create a copy of ApiResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApiResponseImplCopyWith<T, _$ApiResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

ExperiencesData _$ExperiencesDataFromJson(Map<String, dynamic> json) {
  return _ExperiencesData.fromJson(json);
}

/// @nodoc
mixin _$ExperiencesData {
  List<Experience> get experiences => throw _privateConstructorUsedError;

  /// Serializes this ExperiencesData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExperiencesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExperiencesDataCopyWith<ExperiencesData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExperiencesDataCopyWith<$Res> {
  factory $ExperiencesDataCopyWith(
    ExperiencesData value,
    $Res Function(ExperiencesData) then,
  ) = _$ExperiencesDataCopyWithImpl<$Res, ExperiencesData>;
  @useResult
  $Res call({List<Experience> experiences});
}

/// @nodoc
class _$ExperiencesDataCopyWithImpl<$Res, $Val extends ExperiencesData>
    implements $ExperiencesDataCopyWith<$Res> {
  _$ExperiencesDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExperiencesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? experiences = null}) {
    return _then(
      _value.copyWith(
            experiences: null == experiences
                ? _value.experiences
                : experiences // ignore: cast_nullable_to_non_nullable
                      as List<Experience>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ExperiencesDataImplCopyWith<$Res>
    implements $ExperiencesDataCopyWith<$Res> {
  factory _$$ExperiencesDataImplCopyWith(
    _$ExperiencesDataImpl value,
    $Res Function(_$ExperiencesDataImpl) then,
  ) = __$$ExperiencesDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Experience> experiences});
}

/// @nodoc
class __$$ExperiencesDataImplCopyWithImpl<$Res>
    extends _$ExperiencesDataCopyWithImpl<$Res, _$ExperiencesDataImpl>
    implements _$$ExperiencesDataImplCopyWith<$Res> {
  __$$ExperiencesDataImplCopyWithImpl(
    _$ExperiencesDataImpl _value,
    $Res Function(_$ExperiencesDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExperiencesData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? experiences = null}) {
    return _then(
      _$ExperiencesDataImpl(
        experiences: null == experiences
            ? _value._experiences
            : experiences // ignore: cast_nullable_to_non_nullable
                  as List<Experience>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ExperiencesDataImpl implements _ExperiencesData {
  const _$ExperiencesDataImpl({required final List<Experience> experiences})
    : _experiences = experiences;

  factory _$ExperiencesDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExperiencesDataImplFromJson(json);

  final List<Experience> _experiences;
  @override
  List<Experience> get experiences {
    if (_experiences is EqualUnmodifiableListView) return _experiences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_experiences);
  }

  @override
  String toString() {
    return 'ExperiencesData(experiences: $experiences)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExperiencesDataImpl &&
            const DeepCollectionEquality().equals(
              other._experiences,
              _experiences,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_experiences),
  );

  /// Create a copy of ExperiencesData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExperiencesDataImplCopyWith<_$ExperiencesDataImpl> get copyWith =>
      __$$ExperiencesDataImplCopyWithImpl<_$ExperiencesDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ExperiencesDataImplToJson(this);
  }
}

abstract class _ExperiencesData implements ExperiencesData {
  const factory _ExperiencesData({
    required final List<Experience> experiences,
  }) = _$ExperiencesDataImpl;

  factory _ExperiencesData.fromJson(Map<String, dynamic> json) =
      _$ExperiencesDataImpl.fromJson;

  @override
  List<Experience> get experiences;

  /// Create a copy of ExperiencesData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExperiencesDataImplCopyWith<_$ExperiencesDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
