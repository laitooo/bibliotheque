import 'package:shared_preferences/shared_preferences.dart';

late Preferences prefs;

class Preferences {
  late SharedPreferences _prefs;
  final _locale = 'Locale';
  final _nightMode = 'Night mode';
  final _isFirstTimer = 'Is first timer';

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clearAll() async {
    await _prefs.clear();
  }

  setPreferredLanguage(String locale) async {
    await _prefs.setString(_locale, locale);
  }

  String? getPreferredLanguage() {
    return _prefs.getString(_locale);
  }

  bool isArabic() {
    return _prefs.getString(_locale) != "en";
  }

  setIsNightMode(bool isNightMode) async {
    await _prefs.setBool(_nightMode, isNightMode);
  }

  bool? isNightMode() {
    return _prefs.getBool(_nightMode);
  }

  setIsFirstTimer(bool isFirstTimer) async {
    await _prefs.setBool(_isFirstTimer, isFirstTimer);
  }

  bool? isFirstTimer() {
    return _prefs.getBool(_isFirstTimer);
  }
}
