import 'package:bibliotheque/blocs/profile_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/utils/locale_date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleImageWidget(
                  state.profile!.avatarUrl,
                  size: 130,
                ),
              ),
              const SizedBox(height: 40),
              _infoWidget(
                t.auth.register.fullName,
                state.profile!.fullName,
                context,
              ),
              const SizedBox(height: 40),
              _infoWidget(
                t.auth.register.phoneNumber,
                state.profile!.phoneNumber,
                context,
              ),
              const SizedBox(height: 40),
              _infoWidget(
                t.auth.register.country,
                state.profile!.country,
                context,
              ),
              const SizedBox(height: 40),
              _infoWidget(
                t.auth.register.birthDate,
                LocaleDateFormat.defaultFormat(state.profile!.birthDate),
                context,
              ),
            ],
          ),
        );
      },
    );
  }

  _infoWidget(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: context.theme.textColor1,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: context.theme.textFieldActiveColor,
          ),
        ),
      ],
    );
  }
}
