import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class ProfileRepository {
  Future<Result<Profile, ProfileError>> loadProfile(String userId);
}

class MockProfileRepository extends ProfileRepository {
  @override
  Future<Result<Profile, ProfileError>> loadProfile(String userId) async {
    await Future.delayed(const Duration(seconds: 1));

    return Result.value(generator.profile());
  }
}
