import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = Preferences();
  await prefs.init();

  String storedLocale = prefs.getPreferredLanguage() ?? 'ar';
  LocaleSettings.setLocaleRaw(storedLocale);
}
