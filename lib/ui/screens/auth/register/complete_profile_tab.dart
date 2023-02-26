import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/ui/common_widgets/circle_image_widget.dart';
import 'package:bibliotheque/ui/widgets/input_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CompleteProfileTab extends StatefulWidget {
  const CompleteProfileTab({Key? key}) : super(key: key);

  @override
  State<CompleteProfileTab> createState() => _CompleteProfileTabState();
}

class _CompleteProfileTabState extends State<CompleteProfileTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime birthDay = DateTime(2000);
  Country country = Country.parse("sd");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete your profile",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Don't worry, only you can see your personal data. No one else will be able to see it.",
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: context.theme.textColor5,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Stack(
              children: [
                const CircleImageWidget(
                  "https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745",
                  size: 130,
                ),
                PositionedDirectional(
                  bottom: 10,
                  end: 10,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: context.theme.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      Icons.edit,
                      size: 16,
                      color: context.theme.iconColor3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          AppTextField(
            label: "Full name",
            initialValue: "Laitooo san",
            controller: nameController,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: "Phone Number",
            initialValue: "+1-300-555-0399",
            controller: phoneController,
            inputType: TextInputType.phone,
          ),
          const SizedBox(height: 20),
          AppDateSelector(
            label: "Date of birth",
            currentTime: birthDay,
            onDateSelected: (dateTime) {
              setState(() {
                birthDay = dateTime;
              });
            },
          ),
          const SizedBox(height: 20),
          AppCountrySelector(
            label: "Date of birth",
            selectedCountry: country.name,
            onCountrySelected: (selectedCountry) {
              setState(() {
                country = selectedCountry;
              });
            },
          ),
        ],
      ),
    );
  }
}
