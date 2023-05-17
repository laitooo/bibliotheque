import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/repos/profile_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';

enum ProfileStatus {
  loading,
  error,
  success,
}

class ProfileState {
  final ProfileStatus status;
  final Profile? profile;
  final ProfileError? error;

  ProfileState(this.status, {this.profile, this.error});
}

class LoadProfile extends BlocEvent<ProfileState, ProfileBloc> {
  @override
  Stream<ProfileState> toState(ProfileState current, ProfileBloc bloc) async* {
    yield ProfileState(ProfileStatus.loading);

    // TODO: add user id
    final res = await bloc._repo.loadProfile('bloc._auth.user!.id');

    yield res.incase(
      value: (value) {
        return ProfileState(
          ProfileStatus.success,
          profile: value,
        );
      },
      error: (error) {
        return ProfileState(
          ProfileStatus.error,
          error: error,
        );
      },
    );
  }
}

class UpdateProfile extends BlocEvent<ProfileState, ProfileBloc> {
  final Profile profile;

  UpdateProfile(this.profile);

  @override
  Stream<ProfileState> toState(ProfileState current, ProfileBloc bloc) async* {
    yield ProfileState(ProfileStatus.loading);

    yield ProfileState(
      ProfileStatus.success,
      profile: profile,
    );
  }
}

class ProfileBloc extends BaseBloc<ProfileState> {
  final _repo = serviceLocator<ProfileRepository>();
  ProfileBloc() : super(ProfileState(ProfileStatus.loading));
}
