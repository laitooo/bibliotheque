import 'package:bibliotheque/i18n/translations.g.dart';
import 'package:bibliotheque/repos/book_details_repo.dart';
import 'package:bibliotheque/repos/books_repo.dart';
import 'package:bibliotheque/repos/categories_repo.dart';
import 'package:bibliotheque/repos/faqs_repo.dart';
import 'package:bibliotheque/repos/notificatios_repo.dart';
import 'package:bibliotheque/repos/profile_repo.dart';
import 'package:bibliotheque/repos/wish_list_repo.dart';
import 'package:bibliotheque/utils/preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = Preferences();
  await prefs.init();

  String storedLocale = prefs.getPreferredLanguage() ?? 'en';
  LocaleSettings.setLocaleRaw(storedLocale);

  serviceLocator.registerSingleton<BooksRepository>(
    MockBooksRepository(),
  );
  serviceLocator.registerSingleton<CategoriesRepositories>(
    MockCategoriesRepositories(),
  );
  serviceLocator.registerSingleton<WishListRepository>(
    MockWishListRepository(),
  );
  serviceLocator.registerSingleton<BookDetailsRepository>(
    MockBookDetailsRepository(),
  );
  serviceLocator.registerSingleton<NotificationsRepository>(
    MockNotificationsRepository(),
  );
  serviceLocator.registerSingleton<ProfileRepository>(
    MockProfileRepository(),
  );
  serviceLocator.registerSingleton<FAQsRepository>(
    MockFAQsRepository(),
  );
}
