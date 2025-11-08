import 'package:freezed_annotation/freezed_annotation.dart';

part 'experience.freezed.dart';
part 'experience.g.dart';

@freezed
class Experience with _$Experience {
  const factory Experience({
    required int id,
    required String name,
    String? tagline,
    String? description,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'icon_url') String? iconUrl,
  }) = _Experience;

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);
}
