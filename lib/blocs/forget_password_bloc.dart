import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum ForgetPasswordStatus {
  idle,
  loading,
  error,
  success,
}

enum ForgetPasswordProcess {
  inputEmail,
  inputOtp,
  inputNewPassword,
}

class ForgetPasswordState {
  final ForgetPasswordStatus status;
  final ForgetPasswordProcess process;
  final String? email;
  final AuthError? error;

  ForgetPasswordState(
    this.status,
    this.process, {
    this.email,
    this.error,
  });

  ForgetPasswordState copyWith(
          {ForgetPasswordStatus? status,
          ForgetPasswordProcess? process,
          String? email,
          AuthError? error}) =>
      ForgetPasswordState(
        status ?? this.status,
        process ?? this.process,
        email: email ?? this.email,
        error: error ?? this.error,
      );
}

class InputEmail extends BlocEvent<ForgetPasswordState, ForgetPasswordBloc> {
  final String email;

  InputEmail({required this.email});

  @override
  Stream<ForgetPasswordState> toState(
      ForgetPasswordState current, ForgetPasswordBloc bloc) async* {
    yield current.copyWith(status: ForgetPasswordStatus.loading);

    final res = await bloc._repo.forgetPassword(email);

    yield res.incase(
      value: (value) => current.copyWith(
        status: ForgetPasswordStatus.idle,
        process: ForgetPasswordProcess.inputOtp,
        email: email,
      ),
      error: (error) => current.copyWith(
        status: ForgetPasswordStatus.error,
        error: error,
      ),
    );
  }
}

class InputOtpCode extends BlocEvent<ForgetPasswordState, ForgetPasswordBloc> {
  final String otp;

  InputOtpCode({required this.otp});

  @override
  Stream<ForgetPasswordState> toState(
      ForgetPasswordState current, ForgetPasswordBloc bloc) async* {
    yield current.copyWith(status: ForgetPasswordStatus.loading);

    final res = await bloc._repo.checkOtpCode(otp, current.email!);

    yield res.incase(
      value: (value) => current.copyWith(
        status: ForgetPasswordStatus.idle,
        process: ForgetPasswordProcess.inputNewPassword,
      ),
      error: (error) => current.copyWith(
        status: ForgetPasswordStatus.error,
        error: error,
      ),
    );
  }
}

class InputNewPassword
    extends BlocEvent<ForgetPasswordState, ForgetPasswordBloc> {
  final String password;
  final String confirmPassword;

  InputNewPassword({required this.password, required this.confirmPassword});

  @override
  Stream<ForgetPasswordState> toState(
      ForgetPasswordState current, ForgetPasswordBloc bloc) async* {
    yield current.copyWith(status: ForgetPasswordStatus.loading);

    if (password != confirmPassword) {
      yield current.copyWith(
        status: ForgetPasswordStatus.error,
        error: AuthError.passwordsNotMatching,
      );
      return;
    }

    // TODO:: validate password

    final res = await bloc._repo.changePassword(current.email!, password);

    yield res.incase(
      value: (value) => current.copyWith(
        status: ForgetPasswordStatus.idle,
        process: ForgetPasswordProcess.inputNewPassword,
      ),
      error: (error) => current.copyWith(
        status: ForgetPasswordStatus.error,
        error: error,
      ),
    );
  }
}

class ForgetPasswordBloc extends BaseBloc<ForgetPasswordState> {
  final _repo = serviceLocator<AuthRepository>();
  ForgetPasswordBloc()
      : super(
          ForgetPasswordState(
            ForgetPasswordStatus.idle,
            ForgetPasswordProcess.inputEmail,
          ),
        );
}
