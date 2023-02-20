import 'package:bibliotheque/blocs/theme_bloc.dart';
import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  late String current;

  @override
  void initState() {
    super.initState();
    current = prefs.getPreferredLanguage() ?? 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              'العربية',
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
              'English',
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
