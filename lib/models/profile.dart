import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.g.dart';
part 'profile.freezed.dart';

enum Gender {
  male,
  female,
  preferNotToSay,
}

enum Age {
  from14To17,
  from18To24,
  from25To29,
  from30To34,
  from35To39,
  from40To44,
  from45To49,
  moreThan50,
}

@freezed
class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String email,
    required String username,
    required String fullName,
    required String phoneNumber,
    required String avatarUrl,
    required Gender gender,
    required Age age,
    List<String>? favouriteCategories,
    String? country,
    DateTime? birthDate,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  factory Profile.empty() => const Profile(
        id: "",
        email: "",
        username: "",
        fullName: "",
        phoneNumber: "",
        avatarUrl: "",
        gender: Gender.male,
        age: Age.from18To24,
        favouriteCategories: [],
      );
}
