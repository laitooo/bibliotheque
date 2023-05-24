import 'package:bibliotheque/blocs/edit_profile_bloc.dart';
import 'package:bibliotheque/blocs/profile_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfilePage> createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late String avatar;
  late Country country;
  late DateTime birthDate;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    avatar = widget.profile.avatarUrl;
    birthDate = widget.profile.birthDate;
    country = Country.parse(widget.profile.country);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  // TODO:: upload avatar procedure here
                  CircleImageWidget(
                    avatar,
                    size: 130,
                  ),
                  PositionedDirectional(
                    bottom: 10,
                    end: 10,
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<EditProfileBloc>(context).add(
                          UploadProfilePicture(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: context.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Svg(
                          "edit_picture.svg",
                          size: 16,
                          color: context.theme.iconColor3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            AppTextField(
              label: t.auth.register.fullName,
              initialValue: widget.profile.fullName,
              controller: nameController,
            ),
            const SizedBox(height: 35),
            AppTextField(
              label: t.auth.register.phoneNumber,
              initialValue: widget.profile.phoneNumber,
              controller: phoneController,
              inputType: TextInputType.phone,
            ),
            const SizedBox(height: 35),
            AppCountrySelector(
              label: t.auth.register.country,
              selectedCountry: country,
              onCountrySelected: (selectedCountry) {
                setState(() {
                  country = selectedCountry;
                });
              },
            ),
            const SizedBox(height: 35),
            AppDateSelector(
              label: t.auth.register.birthDate,
              selectedDateTime: birthDate,
              onDateSelected: (dateTime) {
                setState(() {
                  birthDate = dateTime;
                });
              },
            ),
          ],
        );
      },
    );
  }

  submitEdits() {
    BlocProvider.of<EditProfileBloc>(context).add(
      SubmitProfileEdits(
        fullName: nameController.text,
        phoneNumber: phoneController.text,
        country: country,
        dateOfBirth: birthDate,
        avatarUrl: avatar,
      ),
    );
  }
}
