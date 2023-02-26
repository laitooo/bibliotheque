import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum RegisterStatus {
  idle,
  loading,
  error,
  success,
}

class RegisterState {
  final RegisterStatus status;
  final Profile profile;
  final AuthError? error;

  RegisterState(this.status, {required this.profile, this.error});

  RegisterState copyWith(
          {RegisterStatus? status, Profile? profile, AuthError? error}) =>
      RegisterState(
        status ?? this.status,
        error: error ?? this.error,
        profile: profile ?? this.profile,
      );
}

class InputGender extends BlocEvent<RegisterState, RegisterBloc> {
  final Gender gender;

  InputGender({required this.gender});

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    yield current.copyWith(
      profile: current.profile.copyWith(
        gender: gender,
      ),
    );
  }
}

class InputAge extends BlocEvent<RegisterState, RegisterBloc> {
  final Age age;

  InputAge({required this.age});

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    yield current.copyWith(
      profile: current.profile.copyWith(
        age: age,
      ),
    );
  }
}

class InputFavouriteCategories extends BlocEvent<RegisterState, RegisterBloc> {
  final List<String> categoriesIds;

  InputFavouriteCategories({required this.categoriesIds});

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    yield current.copyWith(
      profile: current.profile.copyWith(
        favouriteCategories: categoriesIds,
      ),
    );
  }
}

class UploadProfilePicture extends BlocEvent<RegisterState, RegisterBloc> {
  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    final res = await bloc._repo.uploadProfilePicture();

    if (res.isValue) {
      // TODO:: handle upload avatar ui
      final profileUrl = res.asValue;
      yield current.copyWith(
        profile: current.profile.copyWith(
          avatarUrl: profileUrl,
        ),
      );
    } else {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: AuthError.uploadProfileError,
      );
    }
  }
}

class InputProfileInfo extends BlocEvent<RegisterState, RegisterBloc> {
  final String fullName;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final String? country;

  InputProfileInfo({
    required this.fullName,
    required this.phoneNumber,
    this.dateOfBirth,
    this.country,
  });

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    // TODO:: validate all data in all blocs
    yield current.copyWith(
      profile: current.profile.copyWith(
        fullName: fullName,
        phoneNumber: phoneNumber,
        birthDate: dateOfBirth,
        country: country,
      ),
    );
  }
}

class SignUp extends BlocEvent<RegisterState, RegisterBloc> {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm;
  final bool rememberMe;

  SignUp({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.rememberMe,
  });

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    final profile = current.profile.copyWith(
      email: email,
      username: username,
    );

    yield current.copyWith(
      status: RegisterStatus.loading,
      profile: profile,
    );

    final res = await bloc._repo.signUp(profile, username, password, email);

    yield res.incase(
      value: (value) => current.copyWith(
        status: RegisterStatus.success,
      ),
      error: (error) => current.copyWith(
        status: RegisterStatus.error,
        error: error,
      ),
    );
  }
}

class RegisterBloc extends BaseBloc<RegisterState> {
  final _repo = serviceLocator<AuthRepository>();

  RegisterBloc()
      : super(
          RegisterState(
            RegisterStatus.idle,
            profile: Profile.empty(),
          ),
        );
}
