import 'package:freezed_annotation/freezed_annotation.dart';
import 'experience.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

/// API Response wrapper
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const factory ApiResponse({
    String? message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);
}

/// Experiences Data wrapper
@freezed
class ExperiencesData with _$ExperiencesData {
  const factory ExperiencesData({
    required List<Experience> experiences,
  }) = _ExperiencesData;

  factory ExperiencesData.fromJson(Map<String, dynamic> json) =>
      _$ExperiencesDataFromJson(json);
}

