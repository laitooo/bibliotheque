import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';

class GenderTab extends StatefulWidget {
  const GenderTab({Key? key}) : super(key: key);

  @override
  State<GenderTab> createState() => _GenderTabState();
}

class _GenderTabState extends State<GenderTab> {
  Gender userGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What is your gender?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Select gender for better content",
            style: TextStyle(
              fontSize: 14,
              color: context.theme.textColor5,
            ),
          ),
          const SizedBox(height: 20),
          ...Gender.values
              .map(
                (gender) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.5,
                        color: context.theme.dividerColor,
                      ),
                    ),
                  ),
                  child: RadioListTile(
                    value: gender,
                    groupValue: userGender,
                    title: Text(
                      genderToText(gender),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.theme.textColor1,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        userGender = gender;
                      });
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
