import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:country_picker/country_picker.dart';

enum RegisterStatus {
  idle,
  loading,
  error,
  success,
}

enum RegisterProcess {
  gender,
  age,
  categories,
  profile,
  account,
}

class RegisterState {
  final RegisterStatus status;
  final RegisterProcess process;
  final Profile profile;
  final RegisterError? error;

  RegisterState(this.status, this.process, {required this.profile, this.error});

  RegisterState copyWith({
    RegisterStatus? status,
    RegisterProcess? process,
    Profile? profile,
    RegisterError? error,
  }) =>
      RegisterState(
        status ?? this.status,
        process ?? this.process,
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
      process: RegisterProcess.age,
      profile: current.profile.copyWith(
        gender: gender,
      ),
      status: RegisterStatus.idle,
      error: null,
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
      process: RegisterProcess.categories,
      profile: current.profile.copyWith(
        age: age,
      ),
      status: RegisterStatus.idle,
      error: null,
    );
  }
}

class InputFavouriteCategories extends BlocEvent<RegisterState, RegisterBloc> {
  final List<String>? categoriesIds;

  InputFavouriteCategories({this.categoriesIds});

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    if (categoriesIds != null) {
      if (categoriesIds!.isEmpty) {
        yield current.copyWith(
          status: RegisterStatus.error,
          error: RegisterError.emptyCategories,
        );
        return;
      }
    }

    yield current.copyWith(
      process: RegisterProcess.profile,
      profile: current.profile.copyWith(
        favouriteCategories:
            categoriesIds ?? current.profile.favouriteCategories,
      ),
      status: RegisterStatus.idle,
      error: null,
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
        status: RegisterStatus.idle,
        error: null,
      );
    } else {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.uploadAvatarError,
      );
    }
  }
}

class InputProfileInfo extends BlocEvent<RegisterState, RegisterBloc> {
  final String fullName;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final Country? country;

  InputProfileInfo({
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.country,
  });

  @override
  Stream<RegisterState> toState(
      RegisterState current, RegisterBloc bloc) async* {
    if (fullName.isEmpty) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.emptyName,
      );
      return;
    }

    if (phoneNumber.isEmpty || !phoneNumber.startsWith("+")) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.invalidPhoneNumber,
      );
      return;
    }

    if (dateOfBirth == null) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.emptyBirthDay,
      );
      return;
    }

    if (country == null) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.emptyCountry,
      );
      return;
    }

    yield current.copyWith(
      process: RegisterProcess.account,
      profile: current.profile.copyWith(
        fullName: fullName,
        phoneNumber: phoneNumber,
        birthDate: dateOfBirth!,
        country: country!.name,
      ),
      status: RegisterStatus.idle,
      error: null,
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
    if (username.isEmpty) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.emptyUsername,
      );
      return;
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.emptyEmail,
      );
      return;
    }

    if (password.length < 8) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.shortPassword,
      );
      return;
    }

    if (password != passwordConfirm) {
      yield current.copyWith(
        status: RegisterStatus.error,
        error: RegisterError.nonMatchingPasswords,
      );
      return;
    }

    final profile = current.profile.copyWith(
      email: email,
      username: username,
    );

    yield current.copyWith(
      status: RegisterStatus.loading,
      profile: profile,
      process: RegisterProcess.account,
      error: null,
    );

    final res = await bloc._repo.signUp(profile, password);

    yield res.incase(
      value: (value) => current.copyWith(
        status: RegisterStatus.success,
        error: null,
      ),
      error: (error) => current.copyWith(
        status: RegisterStatus.error,
        process: RegisterProcess.account,
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
            RegisterProcess.gender,
            profile: Profile.empty(),
          ),
        );
}
