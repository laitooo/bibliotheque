import 'package:bibliotheque/blocs/edit_profile_bloc.dart';
import 'package:bibliotheque/blocs/profile_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/bloc_generic_loader.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/progress_indicator.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/screens/settings/profile/edit_profile_page.dart';
import 'package:bibliotheque/ui/screens/settings/profile/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final globalEditProfileKey = GlobalKey<EditProfilePageState>();

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (__, profileState) {
        if (profileState.status == ProfileStatus.loading) {
          return const Center(
            child: AppProgressIndicator(),
          );
        }

        if (profileState.status == ProfileStatus.error) {
          return TryAgainWidget(
            onPressed: () {
              BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
            },
          );
        }

        return BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (_, editProfileState) {
            // TODO:: complete this
            if (editProfileState.status == EditProfileStatus.error) {}

            if (editProfileState.status == EditProfileStatus.success) {
              BlocProvider.of<ProfileBloc>(context).add(
                UpdateProfile(
                  editProfileState.newProfile!,
                ),
              );
            }
          },
          builder: (_, editProfileState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  t.account.personalInfo.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: context.theme.textColor1,
                  ),
                ),
                leading: IconButton(
                  icon: const Svg('back.svg'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: false,
                actions: [
                  if (!editProfileState.isEditing)
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<EditProfileBloc>(context).add(
                          StartEditingProfile(),
                        );
                      },
                      icon: const Svg('edit_account.svg'),
                    ),
                  if (editProfileState.isEditing)
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<EditProfileBloc>(context).add(
                          CancelEditingProfile(),
                        );
                      },
                      child: Text(
                        // TODO:: translate these
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                ],
              ),
              bottomNavigationBar: editProfileState.isEditing
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: MainButton(
                        title: "Submit",
                        removePadding: true,
                        onPressed: () {
                          if (globalEditProfileKey.currentState != null) {
                            globalEditProfileKey.currentState!.submitEdits();
                          }
                        },
                      ),
                    )
                  : null,
              body: Builder(
                builder: (_) {
                  if (editProfileState.status == EditProfileStatus.sending) {
                    return const Center(
                      child: AppProgressIndicator(size: 100),
                    );
                  }

                  if (editProfileState.isEditing) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider.value(
                          value: BlocProvider.of<ProfileBloc>(context),
                        ),
                        BlocProvider.value(
                          value: BlocProvider.of<EditProfileBloc>(context),
                        ),
                      ],
                      child: EditProfilePage(
                        key: globalEditProfileKey,
                        profile: profileState.profile!,
                      ),
                    );
                  }

                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: BlocProvider.of<ProfileBloc>(context),
                      ),
                    ],
                    child: const UserProfilePage(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
