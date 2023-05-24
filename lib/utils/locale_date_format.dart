import 'package:bibliotheque/utils/preferences.dart';
import 'package:intl/intl.dart';

class LocaleDateFormat {
  static String defaultFormat(DateTime dateTime) {
    String lang = prefs.getPreferredLanguage() ?? 'ar';
    return DateFormat('d MMM yyyy', lang).format(dateTime);
  }

  static String monthYearFormat(DateTime dateTime) {
    String lang = prefs.getPreferredLanguage() ?? 'ar';
    return DateFormat('MMM yyyy', lang).format(dateTime);
  }
}
