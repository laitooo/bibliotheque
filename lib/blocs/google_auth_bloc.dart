import 'package:bibliotheque/repos/auth_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum GoogleAuthStatus {
  idle,
  loading,
  error,
  success,
}

class GoogleAuthState {
  final GoogleAuthStatus status;
  final AuthError? error;

  GoogleAuthState(this.status, {this.error});
}

class ContinueWithGoogle extends BlocEvent<GoogleAuthState, GoogleAuthBloc> {
  @override
  Stream<GoogleAuthState> toState(
      GoogleAuthState current, GoogleAuthBloc bloc) async* {
    yield GoogleAuthState(GoogleAuthStatus.loading);

    final res = await bloc._repo.googleSignIn();

    yield res.incase(
      value: (value) => GoogleAuthState(
        GoogleAuthStatus.success,
      ),
      error: (error) => GoogleAuthState(
        GoogleAuthStatus.error,
        error: error,
      ),
    );
  }
}

class GoogleAuthBloc extends BaseBloc<GoogleAuthState> {
  final _repo = serviceLocator<AuthRepository>();

  GoogleAuthBloc()
      : super(
          GoogleAuthState(
            GoogleAuthStatus.idle,
          ),
        );
}
