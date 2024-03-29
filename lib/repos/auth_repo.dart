import 'package:bibliotheque/features.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/models/user.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:bibliotheque/utils/generator.dart';
import 'package:bibliotheque/utils/result.dart';

abstract class AuthRepository {
  User? get user;
  Future<bool> isLoggedIn();
  Future<Result<void, AuthError>> signIn(String usernameEmail, String password);
  Future<Result<void, RegisterError>> signUp(Profile profile, String password);
  Future<Result<void, AuthError>> googleSignIn();
  Future<Result<void, AuthError>> appleSignIn();
  Future<Result<void, AuthError>> facebookSignIn();
  Future<Result<void, ForgetPasswordError>> forgetPassword(String email);
  Future<Result<void, ForgetPasswordError>> checkOtpCode(
      String otp, String email);
  Future<Result<void, ForgetPasswordError>> changePassword(
      String email, String newPassword);
  Future<Result<String, AuthError>> uploadProfilePicture();
  Future<void> signOut();
}

class MockAuthRepository extends AuthRepository {
  /// Here you can give the user a value from the generator if you want to test
  /// while authenticated:
  final _user = generator.user();

  /// Or if you want to test without authentication you can leave it like:
  /// User? _user;

  @override
  User? get user => _user;

  @override
  Future<Result<void, AuthError>> signIn(
      String usernameEmail, String password) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(AuthError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, RegisterError>> signUp(
      Profile profile, String password) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(RegisterError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, AuthError>> appleSignIn() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (Features.isMockErrors) {
      return Result.error(AuthError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, AuthError>> facebookSignIn() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (Features.isMockErrors) {
      return Result.error(AuthError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, AuthError>> googleSignIn() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (Features.isMockErrors) {
      return Result.error(AuthError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, ForgetPasswordError>> forgetPassword(String email) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(ForgetPasswordError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, ForgetPasswordError>> changePassword(
      String email, String newPassword) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(ForgetPasswordError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<void, ForgetPasswordError>> checkOtpCode(
      String otp, String email) async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(ForgetPasswordError.networkError);
    }

    return Result.value(null);
  }

  @override
  Future<Result<String, AuthError>> uploadProfilePicture() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    if (Features.isMockErrors) {
      return Result.error(AuthError.networkError);
    }

    return Result.value(
      generator.avatar(),
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    return generator.boolean();
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(
      const Duration(seconds: 0),
    );
  }
}
