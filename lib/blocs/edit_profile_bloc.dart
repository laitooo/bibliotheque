import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/repos/profile_repo.dart';
import 'package:bibliotheque/service_locator.dart';
import 'package:bibliotheque/utils/bloc.dart';
import 'package:bibliotheque/utils/error_enums.dart';
import 'package:country_picker/country_picker.dart';

enum EditProfileStatus {
  idle,
  editing,
  sending,
  error,
  success,
}

class EditProfileState {
  final EditProfileStatus status;
  final Profile? newProfile;
  final EditProfileError? error;

  EditProfileState(this.status, {this.newProfile, this.error});

  bool get isEditing =>
      status == EditProfileStatus.editing || status == EditProfileStatus.error;
}

class StartEditingProfile extends BlocEvent<EditProfileState, EditProfileBloc> {
  @override
  Stream<EditProfileState> toState(
      EditProfileState current, EditProfileBloc bloc) async* {
    yield EditProfileState(EditProfileStatus.editing);
  }
}

class CancelEditingProfile
    extends BlocEvent<EditProfileState, EditProfileBloc> {
  @override
  Stream<EditProfileState> toState(
      EditProfileState current, EditProfileBloc bloc) async* {
    yield EditProfileState(EditProfileStatus.idle);
  }
}

class UploadProfilePicture
    extends BlocEvent<EditProfileState, EditProfileBloc> {
  @override
  Stream<EditProfileState> toState(
      EditProfileState current, EditProfileBloc bloc) async* {
    // final res = await bloc._repo.uploadProfilePicture();
    //
    // if (res.isValue) {
    //   // TODO:: handle upload avatar ui
    //   final profileUrl = res.asValue;
    //   // yield current.copyWith(
    //   //   profile: current.profile.copyWith(
    //   //     avatarUrl: profileUrl,
    //   //   ),
    //   // );
    // } else {
    //   // yield current.copyWith(
    //   //   status: EditProfileStatus.error,
    //   //   error: AuthError.uploadProfileError,
    //   // );
    // }
  }
}

class SubmitProfileEdits extends BlocEvent<EditProfileState, EditProfileBloc> {
  final String fullName;
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final Country? country;
  final String avatarUrl;

  SubmitProfileEdits({
    required this.fullName,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.dateOfBirth,
    required this.country,
  });

  @override
  Stream<EditProfileState> toState(
      EditProfileState current, EditProfileBloc bloc) async* {
    yield EditProfileState(EditProfileStatus.sending);

    if (fullName.isEmpty) {
      yield EditProfileState(
        EditProfileStatus.error,
        error: EditProfileError.emptyName,
      );
      return;
    }

    if (phoneNumber.isEmpty || !phoneNumber.startsWith("+")) {
      yield EditProfileState(
        EditProfileStatus.error,
        error: EditProfileError.invalidPhoneNumber,
      );
      return;
    }

    if (dateOfBirth == null) {
      yield EditProfileState(
        EditProfileStatus.error,
        error: EditProfileError.emptyBirthDay,
      );
      return;
    }

    if (country == null) {
      yield EditProfileState(
        EditProfileStatus.error,
        error: EditProfileError.emptyCountry,
      );
      return;
    }

    final res = await bloc._repo.updateProfile(
      fullName,
      phoneNumber,
      country!.name,
      avatarUrl,
      dateOfBirth!,
    );

    yield res.incase(value: (value) {
      return EditProfileState(
        EditProfileStatus.success,
        newProfile: value,
      );
    }, error: (error) {
      return EditProfileState(
        EditProfileStatus.error,
        error: error,
      );
    });
  }
}

class EditProfileBloc extends BaseBloc<EditProfileState> {
  final _repo = serviceLocator<ProfileRepository>();

  EditProfileBloc()
      : super(
          EditProfileState(
            EditProfileStatus.idle,
          ),
        );
}
