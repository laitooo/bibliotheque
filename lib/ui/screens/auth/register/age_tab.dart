import 'package:bibliotheque/blocs/register_bloc.dart';
import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/models/profile.dart';
import 'package:bibliotheque/ui/common_widgets/buttons.dart';
import 'package:bibliotheque/ui/widgets/filter_item.dart';
import 'package:bibliotheque/utils/enum_to_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../i18n/translations.dart';

class AgeTab extends StatefulWidget {
  const AgeTab({Key? key}) : super(key: key);

  @override
  State<AgeTab> createState() => _AgeTabState();
}

class _AgeTabState extends State<AgeTab> {
  Age userAge = Age.from14To17;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.auth.register.chooseAge,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: context.theme.textColor1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            t.auth.register.selectAgeRange,
            style: TextStyle(
              fontSize: 14,
              color: context.theme.textColor4,
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Wrap(
                spacing: 15,
                runSpacing: 20,
                children: Age.values
                    .map(
                      (age) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FilterItem(
                          name: ageToText(age),
                          isSelected: age == userAge,
                          isTextCentered: true,
                          onClick: () {
                            setState(() {
                              userAge = age;
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Spacer(),
          MainButton(
            title: t.auth.register.continu,
            removePadding: true,
            onPressed: () {
              BlocProvider.of<RegisterBloc>(context).add(
                InputAge(
                  age: userAge,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
