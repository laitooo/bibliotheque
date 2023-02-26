import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum SignInStatus {
  loading,
  error,
  success,
}

class SignInState {
  final SignInStatus status;
  final AuthError? error;

  SignInState(this.status, {this.error});
}

// TODO:: maybe do copy with to all blocs and make the value required always

class SignIn extends BlocEvent<SignInState, SignInBloc> {
  final String usernameEmail;
  final String password;
  final bool rememberMe;

  SignIn(
      {required this.usernameEmail,
      required this.password,
      required this.rememberMe});

  @override
  Stream<SignInState> toState(SignInState current, SignInBloc bloc) async* {
    final res = await bloc._repo.signIn(usernameEmail, password);

    yield res.incase(
      value: (value) => SignInState(
        SignInStatus.success,
      ),
      error: (error) => SignInState(
        SignInStatus.error,
        error: error,
      ),
    );
  }
}

class GoogleSignIn extends BlocEvent<SignInState, SignInBloc> {
  @override
  Stream<SignInState> toState(SignInState current, SignInBloc bloc) async* {
    final res = await bloc._repo.googleSignIn();

    yield res.incase(
      value: (value) => SignInState(
        SignInStatus.success,
      ),
      error: (error) => SignInState(
        SignInStatus.error,
        error: error,
      ),
    );
  }
}

class AppleSignIn extends BlocEvent<SignInState, SignInBloc> {
  @override
  Stream<SignInState> toState(SignInState current, SignInBloc bloc) async* {
    final res = await bloc._repo.appleSignIn();

    yield res.incase(
      value: (value) => SignInState(
        SignInStatus.success,
      ),
      error: (error) => SignInState(
        SignInStatus.error,
        error: error,
      ),
    );
  }
}

class FacebookSignIn extends BlocEvent<SignInState, SignInBloc> {
  @override
  Stream<SignInState> toState(SignInState current, SignInBloc bloc) async* {
    final res = await bloc._repo.facebookSignIn();

    yield res.incase(
      value: (value) => SignInState(
        SignInStatus.success,
      ),
      error: (error) => SignInState(
        SignInStatus.error,
        error: error,
      ),
    );
  }
}

class SignInBloc extends BaseBloc<SignInState> {
  final _repo = serviceLocator<AuthRepository>();
  SignInBloc() : super(SignInState(SignInStatus.loading));
}
