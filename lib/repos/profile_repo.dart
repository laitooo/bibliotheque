import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class ProfileRepository {
  Future<Result<Profile, ProfileError>> loadProfile(String userId);
  Future<Result<Profile, EditProfileError>> updateProfile(
    String fullName,
    String phoneNumber,
    String country,
    String avatarUrl,
    DateTime birthDate,
  );
}

class MockProfileRepository extends ProfileRepository {
  @override
  Future<Result<Profile, ProfileError>> loadProfile(String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(ProfileError.networkError);
    }

    return Result.value(generator.profile());
  }

  @override
  Future<Result<Profile, EditProfileError>> updateProfile(
    String fullName,
    String phoneNumber,
    String country,
    String avatarUrl,
    DateTime birthDate,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    if (Features.isMockErrors) {
      return Result.error(EditProfileError.networkError);
    }

    return Result.value(
      generator.profile().copyWith(
            fullName: fullName,
            phoneNumber: phoneNumber,
            country: country,
            avatarUrl: avatarUrl,
            birthDate: birthDate,
          ),
    );
  }
}
