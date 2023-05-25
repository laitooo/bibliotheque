import 'package:bibliotheque/blocs/register_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/common_widgets/svg.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteProfileTab extends StatefulWidget {
  const CompleteProfileTab({Key? key}) : super(key: key);

  @override
  State<CompleteProfileTab> createState() => _CompleteProfileTabState();
}

class _CompleteProfileTabState extends State<CompleteProfileTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime? birthDate;
  Country? country;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.auth.register.completeProfile,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            t.auth.register.onlyYouCanSeePersonalInfo,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: context.theme.textColor4,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Stack(
              children: [
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return CircleImageWidget(
                      state.profile.avatarUrl,
                      size: 130,
                    );
                  },
                ),
                PositionedDirectional(
                  bottom: 10,
                  end: 10,
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<RegisterBloc>(context).add(
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
            initialValue: "",
            controller: nameController,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: t.auth.register.phoneNumber,
            initialValue: "",
            controller: phoneController,
            inputType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          AppDateSelector(
            label: t.auth.register.birthDate,
            selectedDateTime: birthDate,
            onDateSelected: (dateTime) {
              setState(() {
                birthDate = dateTime;
              });
            },
          ),
          const SizedBox(height: 20),
          AppCountrySelector(
            label: t.auth.register.country,
            selectedCountry: country,
            onCountrySelected: (selectedCountry) {
              setState(() {
                country = selectedCountry;
              });
            },
          ),
          const SizedBox(height: 20),
          const Spacer(),
          MainButton(
            title: t.auth.register.continu,
            removePadding: true,
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(
                InputProfileInfo(
                  fullName: nameController.text,
                  phoneNumber: phoneController.text,
                  country: country,
                  dateOfBirth: birthDate,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
