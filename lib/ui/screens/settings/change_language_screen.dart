import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/svg.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  late String current;

  @override
  void initState() {
    super.initState();
    current = prefs.getPreferredLanguage() ?? 'en';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.account.language.language,
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
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              t.account.language.arabic,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: context.theme.textColor1,
              ),
            ),
            leading: Radio<String>(
              value: 'ar',
              groupValue: current,
              onChanged: (newValue) async {
                await prefs.setPreferredLanguage(newValue!);
                LocaleSettings.setLocaleRaw(newValue);
                setState(() {
                  current = newValue;
                });
              },
            ),
          ),
          ListTile(
            title: Text(
              t.account.language.english,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: context.theme.textColor1,
              ),
            ),
            leading: Radio<String>(
              value: 'en',
              groupValue: current,
              onChanged: (newValue) async {
                await prefs.setPreferredLanguage(newValue!);
                LocaleSettings.setLocaleRaw(newValue);
                setState(() {
                  current = newValue;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
