import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.g.dart';
part 'profile.freezed.dart';

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String name,
    required String email,
    required String phoneNumber,
    required String avatarUrl,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
