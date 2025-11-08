// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApiResponseImpl<T> _$$ApiResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _$ApiResponseImpl<T>(
  message: json['message'] as String?,
  data: _$nullableGenericFromJson(json['data'], fromJsonT),
);

Map<String, dynamic> _$$ApiResponseImplToJson<T>(
  _$ApiResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'message': instance.message,
  'data': _$nullableGenericToJson(instance.data, toJsonT),
};

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) => input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) => input == null ? null : toJson(input);

_$ExperiencesDataImpl _$$ExperiencesDataImplFromJson(
  Map<String, dynamic> json,
) => _$ExperiencesDataImpl(
  experiences: (json['experiences'] as List<dynamic>)
      .map((e) => Experience.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$ExperiencesDataImplToJson(
  _$ExperiencesDataImpl instance,
) => <String, dynamic>{'experiences': instance.experiences};
